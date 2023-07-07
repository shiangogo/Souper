# Souper 超級湯師傅

這是一個可以主持海龜湯遊戲的 Line Bot 機器人。

## 注意

⚠️ **開發中：此專案仍處於開發階段，主要功能尚未實現或存在問題**。請注意以下事項：

- 功能尚未完善，可能會有錯誤或未預期的行為。
- 目前正在積極開發和測試中，並且持續優化功能和性能。
- **請勿將此專案用於生產環境，僅供測試和學習使用。**

非常感謝您對此專案的興趣和支持！如果您在使用過程中遇到任何問題或有任何建議，歡迎聯絡我，或是提出 PR ～

---

## 啟動方式

1. 創建一個新的 Line Messaging API 的 channel：https://developers.line.biz/zh-hant/
2. 申請 OpenAI 的 API key：https://platform.openai.com/account/api-keys
3. 在 `.example.env` 中設定環境變量，並將其重新命名為 `.env` 。
4. 開啟終端機，並 cd 至專案目錄。
5. 確保本機安裝 Docker ，下載網址：https://www.docker.com/。
6. 在終端機執行 `docker compose up --build` ，可建立容器並運行 PostgreSQL 、 Redis 和專案。下一次啟動可執行 `docker compose up`。
7. 確保本機安裝 ngrok ，下載網址：https://ngrok.com/download
8. 使用 Ngrok 將本地伺服器暴露，在終端機執行 `ngrok http 3000` 。
9. 到 Line Developers 的後台，將 Messaging API 中 Webhook settings 設定的 Webhook URL 設定為 Ngrok 提供的網址，後面要加上 `/callback` ，完整如。https://xxxx-xxx-xxx-xxx-xxx.ngrok-free.app/callback
10. 請確認按下 `Verify` 按鈕後，彈窗顯示 `Success` 的訊息。
11. 啟用 Webhook ，將 Use webhook 打開。

---

## 故事後台管理

當容器執行時，你現在可以透過瀏覽器訪問`localhost:5173`開啟後台頁面，以查看、新增、修改、刪除海龜湯故事。

---

## 開始遊戲

你可以在有「超級湯師傅」的群組對話中輸入以下命令：

```
湯師傅上湯
```

超級湯師傅將會為這個群組出一道海龜湯題目，遊戲即開始。

---

遊戲開始後，群組成員可以提問任何關於故事的封閉性問題，例如：

```
整起事件的兇手只有一個人嗎？
```

---

若您想要更換一個故事，可以輸入：

```
換湯
```

超級湯師傅會隨機幫你替換一個遊戲。

---

若是想讓超級湯師傅結束當前遊戲，可以在對話中輸入：

```
喝完了
```

---

若想了解海龜湯的遊戲規則，請參考維基百科：  
https://zh.wikipedia.org/zh-hant/%E6%83%85%E5%A2%83%E7%8C%9C%E8%AC%8E

---

## 其他注意事項

請確保「超級湯師傅」已加入您的 Line 群組中，才能正常使用功能。
