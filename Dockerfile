# Étape de build
FROM node:20-alpine AS build-env
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Étape finale : production-ready artefacts
# FROM alpine:latest AS final-env
# WORKDIR /dist
# COPY --from=build-env /app/build/client ./

FROM nginx:alpine AS prod-env
COPY --from=build-env ./build/client /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
