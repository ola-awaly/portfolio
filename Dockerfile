# Étape de build
FROM node:20-alpine AS build-env
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Étape finale : production-ready artefacts
FROM alpine:latest AS final-env
WORKDIR /dist
COPY --from=build-env /app/build/client ./
