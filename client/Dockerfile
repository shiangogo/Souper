FROM node:18

WORKDIR /app

COPY package*.json .
COPY vite.config.js .
RUN npm install
RUN npm install vite@4.3.9

COPY . .

EXPOSE 5173

CMD [ "npm", "run", "dev" ]
