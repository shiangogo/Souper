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
            set_game(event)

          elsif event.message["text"] == "湯師傅上湯" && $redis.get(event.chat_id)
            p "您有正在進行中的遊戲"
            client.reply_message(event['replyToken'], {type: "text", text: "你這道湯還沒喝完呢！"})
            
          elsif event.message["text"] == "換湯" && $redis.get(event.chat_id)
            set_game(event)

          elsif event.message["text"] == "喝完了" && $redis.get(event.chat_id)
            $redis.del(event.chat_id)
            client.reply_message(event['replyToken'], {type: "text", text: "好的，幫你清理清理～"})
            
          elsif $redis.get(event.chat_id)
            whole_story = JSON.parse($redis.get(event.chat_id))["game_whole_story"]
            description = JSON.parse($redis.get(event.chat_id))["game_description"]

            OpenAiChatJob.perform_now(client, event, whole_story, description)
            
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

  def set_game(event)
    random_game = Game.find(Game.pluck(:id).sample)

    $redis.set(event.chat_id, {"game_title": random_game.title, "game_description": random_game.description, "game_whole_story": random_game.whole_story}.to_json)

    client.reply_message(event['replyToken'], {type: "text", text: "#{ random_game.title }\n#{ random_game.description }"})
  end
end
