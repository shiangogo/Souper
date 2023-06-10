require "line/bot"
include LineBotHelper

class HomeController < ApplicationController
  
  def index
    render plain: "Hello, world!"
  end
  
  def callback
    p params
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      p "*****************"
      # p $redis.ping
      # p event
      # p event["source"]["type"]
      p event.is_in_group?
      p "*****************"
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"] == "湯師傅上湯"
            random_game = Game.order("RANDOM()").first
            
            if event.is_in_group?
              $redis.set(event["source"]["groupId"], random_game.id)
              abc = $redis.get(event["source"]["groupId"])
              p abc
            else
              $redis.set(event["source"]["userId"], random_game.id)
            end
            client.reply_message(event['replyToken'], {type: "text", text: random_game.title})

          end
          # message = {
          #   type: 'text',
          #   text: event.message['text']
          # }
          # client.reply_message(event['replyToken'], message)
        end
      end
    end
    
    render status: 200
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
    }
  end

end
