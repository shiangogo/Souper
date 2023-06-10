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

1. 在 `.example.env` 中設定環境變量，並將其重新命名為 `.env` 。
2. 開啟終端機，並 cd 至專案目錄。
3. 確保本機安裝 Docker。
4. 在終端機執行 `docker compose up --build` ，可建立容器並運行 PostgreSQL 、 Redis 和專案。下一次啟動可執行 `docker compose up`。
5. 使用 Ngrok 將本地伺服器暴露，在終端機執行 `ngrok http 3000` 。
6. 到 Line Developers 的後台，將 Messaging API 中 Webhook settings 設定的 Webhook URL 設定為 Ngrok 提供的網址，後面要加上 `/callback` ，完整如。https://xxxx-xxx-xxx-xxx-xxx.ngrok-free.app/callback
7. 請確認按下 `Verify` 按鈕後，彈窗顯示 `Success` 的訊息。
8. 啟用 Webhook ，將 Use webhook 打開。

---

## 使用方式

你可以在有「超級湯師傅」的群組中輸入以下命令：

```
湯師傅上湯
```

超級湯師傅將會為這個群組端上一道海龜湯。  
海龜湯的遊戲規則，請參考：  
https://zh.wikipedia.org/zh-hant/%E6%83%85%E5%A2%83%E7%8C%9C%E8%AC%8E

---

## 其他注意事項

請確保「超級湯師傅」已加入您的 Line 群組中，才能正常使用功能。
