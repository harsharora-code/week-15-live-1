FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*

COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN npm install

COPY . .

RUN npm run build
RUN npx prisma generate


EXPOSE 3000

CMD [ "node", "dist/index.js" ]
