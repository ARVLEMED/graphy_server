FROM node:18.20.6-bullseye as build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build   # if you have a build script

FROM node:18.20.6-bullseye-slim
WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/src/app/dist ./dist   # adapt to your build output
COPY package.json package-lock.json ./
RUN npm ci --only=production
USER node
EXPOSE 4000
CMD ["node", "dist/graphserver.js"]
