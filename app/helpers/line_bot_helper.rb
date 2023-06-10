module LineBotHelper
  class Line::Bot::Event::Message
    def is_in_group?
      return self["source"]["type"] == "group"
    end
  end
end
