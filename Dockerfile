FROM node:hydrogen-buster>node@18.20.6>git@1:2.20.1-2+deb10u9
COPY graphserver.js .
COPY package.json .
COPY UScities.json .
RUN npm install &&\
    apk update &&\
    apk upgrade
EXPOSE  4000
CMD node graphserver.js
