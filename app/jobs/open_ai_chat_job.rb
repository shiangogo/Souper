class OpenAiChatJob < ApplicationJob
  queue_as :default

  def perform(client, event, whole_story, description)
    response = $openai_client.chat(
      parameters: {
        model: ENV.fetch("AI_MODEL"),
        messages: [
          { role: "system", content: "user在進行情境猜謎的遊戲，而assistant是遊戲的主持人。user要根據故事片段來詢問assistant，進而拼湊出完整的故事。assistant知道故事的全貌以及user接收到的故事片段，而user只知道故事的片段。user會根據故事的片段問各式各樣的問題。"},
          { role: "system", content: "assistant需要根據故事全貌和user接收的故事片段僅能回答「是」或「否」。" },
          { role: "system", content: "assistant不可以針對user提出的問題給任何提示，也不可以回答開放式問題或是告知完整故事內容" },
          { role: "system", content: "故事全貌如下：```#{ whole_story }```" },
          { role: "system", content: "user會得知的故事片段如下：```#{ description }```" },
          { role: "user", content: "根據你知道的故事全貌和我得到的故事片段，#{ event.message["text"] }"},
        ],
        temperature: 0.3,
      }
    )
    response = response.dig("choices", 0, "message", "content")
    client.reply_message(event['replyToken'], {type: "text", text: "回應「#{event.message["text"]}」：\n#{response}"})
  end
end
