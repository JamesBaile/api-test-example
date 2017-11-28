FROM node:latest

RUN npm install -g cucumber@1.3.3

RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN npm install

CMD [ "cucumber-js", "--tags", "~@ignore" ]