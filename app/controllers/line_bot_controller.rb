class LineBotController < ApplicationController
  require "json"
  include LineBotHelper

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"] == "湯師傅上湯" && !$redis.get(event.chat_id)
            random_game = Game.find(Game.pluck(:id).sample)

            $redis.set(event.chat_id, {"game_title": random_game.title, "game_description": random_game.description, "game_whole_story": random_game.whole_story}.to_json)

            client.reply_message(event['replyToken'], {type: "text", text: "#{ random_game.title }\n#{ random_game.description }"})

          elsif event.message["text"] == "湯師傅上湯" && $redis.get(event.chat_id)
            p "您有正在進行中的遊戲"
            client.reply_message(event['replyToken'], {type: "text", text: "你這道湯還沒喝完呢！"})
            
          elsif event.message["text"] == "喝完了" && $redis.get(event.chat_id)
            $redis.del(event.chat_id)
            client.reply_message(event['replyToken'], {type: "text", text: "好的，幫你清理清理～"})
            
          elsif $redis.get(event.chat_id)
            # TODO
            description = JSON.parse($redis.get(event.chat_id))["game_description"]
            whole_story = JSON.parse($redis.get(event.chat_id))["game_whole_story"]
            p description
            p whole_story

            response = $openai_client.chat(
              parameters: {
                model: ENV.fetch("AI_MODEL"), # Required.
                messages: [
                  { role: "system", content: "user在進行情境猜謎的遊戲，而assistant是遊戲的主持人。user要根據故事片段來詢問assistant，進而拼湊出完整的故事。assistant知道故事的全貌以及user接收到的故事片段，而user只知道故事的片段。user會根據故事的片段問各式各樣的問題。"},
                  { role: "system", content: "assistant需要根據故事全貌和user接收的故事片段僅能回答「是」或「否」。" },
                  { role: "system", content: "assistant不可以針對user提出的問題給任何提示，也不可以回答開放式問題或是告知完整故事內容" },
                  { role: "system", content: "故事全貌如下：```#{ whole_story }```" },
                  { role: "system", content: "user會得知的故事片段如下：```#{ description }```" },
                  { role: "user", content: "根據你知道的故事全貌和我得到的故事片段，#{event.message["text"]}"},
                ],
                temperature: 0.3,
              }
            )

            p response
            response = response.dig("choices", 0, "message", "content")
            
            client.reply_message(event['replyToken'], {type: "text", text: response})
            
          else
            p "啥事都沒發生"
            
          end

        end
      end
    end
    
    render status: 200
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
    end
  end
end
