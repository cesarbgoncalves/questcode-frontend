FROM node:10.22.1-stretch AS build
ARG NPM_ENV=development
RUN ["mkdir","-p", "/usr/src/app"]
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY src/ ./src/
COPY public/ ./public/
RUN npm run build:${NPM_ENV}

FROM nginx
COPY --from=build /usr/src/app/build/ /usr/share/nginx/html
EXPOSE 80