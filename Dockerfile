# Етап 1: Збірка
FROM node:20-alpine AS build-stage
WORKDIR /app

# Копіюємо файли залежностей
COPY package*.json ./
RUN npm install

# Копіюємо решту коду та збираємо проект
COPY . .
RUN npm run build

# Етап 2: Роздача статики через Nginx
FROM nginx:stable-alpine
# Копіюємо зібрані файли з першого етапу
# Vite за замовчуванням збирає все в папку /dist
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]