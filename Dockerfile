FROM node:19-alpine as build

RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh yarn

RUN mkdir /app

WORKDIR /app

COPY package.json .

RUN yarn install

COPY . .

RUN yarn build

# ---------------

FROM node:19-alpine

RUN mkdir -p /app/build

RUN apk update && apk upgrade && apk add yarn git

WORKDIR /app

COPY --from=build /app/package.json .

RUN yarn install --production

COPY --from=build /app/build ./build
COPY --from=build /app/src/auth_config_template.json ./src/auth_config_template.json
COPY --from=build /app/public/auth_config_template.js ./public/auth_config_template.js
COPY --from=build /app/server.js .
COPY --from=build /app/api-server.js .
COPY --from=build /app/MAKE_CONFIG_FROM_ENV.sh .
COPY --from=build /app/RUN_FROM_DOCKER_ENTRYPOINT.sh .

EXPOSE 3000
EXPOSE 3001

ENV SERVER_PORT=3000
ENV API_PORT=3001
ENV NODE_ENV production

CMD ["./RUN_FROM_DOCKER_ENTRYPOINT.sh"]
