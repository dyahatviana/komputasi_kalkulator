# Gunakan Node image untuk build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install Git karena beberapa dependency npm perlu clone dari GitHub
RUN apk add --no-cache git

# Install expo-cli global
RUN npm install -g expo-cli

# Copy file package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Install library tambahan untuk web build (expo web)
RUN npx expo install react-native-web@~0.19.6 react-dom@18.2.0 @expo/webpack-config@^19.0.0

# Copy seluruh project ke container
COPY . .

# Jalankan build aplikasi
RUN npm run build

# Stage 2: gunakan nginx untuk serve hasil build
FROM nginx:alpine

# Copy hasil build dari stage sebelumnya ke nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Jalankan nginx
CMD ["nginx", "-g", "daemon off;"]
