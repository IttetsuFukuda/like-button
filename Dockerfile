# stage 1
FROM node:20-alpine as builder
WORKDIR /app
# install dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn install
# copy src and build
COPY . .
RUN yarn build

# stage 2
FROM nginx:1.25.2-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
