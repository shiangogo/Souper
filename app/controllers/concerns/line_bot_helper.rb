module LineBotHelper
  class Line::Bot::Event::Message
    def is_in_group?
      return self["source"]["type"] == "group"
    end

    def chat_id
      if self.is_in_group?
        self["source"]["groupId"]
      else
        self["source"]["userId"]
      end
    end
  end
end
