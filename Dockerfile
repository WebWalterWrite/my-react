# install node for react
FROM node:alpine as builder
LABEL maintainer="contact@codeofduty.dev"
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run build

# install nginx serving routes react-router
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

