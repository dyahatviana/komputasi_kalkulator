# Stage 1: Build React Native Web dengan Expo
FROM node:18-alpine AS builder

WORKDIR /app

# 🧩 Tambahkan Git agar npm bisa clone dependency dari GitHub
RUN apk add --no-cache git

# Install Expo CLI
RUN npm install -g expo-cli

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Install tambahan untuk build web
RUN npx expo install react-native-web@~0.19.6 react-dom@18.2.0 @expo/webpack-config@^19.0.0

# Copy seluruh source code
COPY . .

# Build project untuk web
RUN npx expo export:web

# Stage 2: Serve hasil build dengan nginx
FROM nginx:alpine

# Copy hasil build dari builder stage
COPY --from=builder /app/web-build /usr/share/nginx/html

EXPOSE 80

# Jalankan nginx
CMD ["nginx", "-g", "daemon off;"]
