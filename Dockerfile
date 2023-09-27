# Docker best practice
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

# Example from here
# https://mherman.org/blog/dockerizing-a-react-app/
# https://github.com/sanjaysaini2000/react-todo-app/blob/master/Dockerfile

# Add this line to test auto build in docker hub v2
# Add this line to test auto deploy to azure

# build environment
# Get minimal base image
FROM alpine:latest as build
RUN apk update
RUN apk add --update nodejs npm yarn
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app
RUN yarn install
COPY . /app
RUN yarn build

#########################
# Prod
#########################
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html

###################
# Dev
###################
# EXPOSE 3000
# CMD [ "yarn", "start" ]