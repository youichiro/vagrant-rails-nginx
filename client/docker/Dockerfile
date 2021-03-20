FROM node:15.12.0

WORKDIR /client

COPY package*.json ./
RUN npm install

CMD ["npm", "run", "server"]
