FROM node:14
WORKDIR /hello
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "hello.js"]
