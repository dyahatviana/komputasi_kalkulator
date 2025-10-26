# Gunakan image Node.js resmi
FROM node:18

# Set working directory dalam container
WORKDIR /app

# Copy package.json dan yarn.lock (jika ada) ke working directory
COPY package.json yarn.lock* ./

# Install dependencies
RUN yarn install --frozen-lockfile || npm install

# Copy seluruh kode aplikasi ke working directory
COPY . .

# Expose port untuk Metro bundler React Native (default 8081)
EXPOSE 8081

# Jalankan Metro bundler React Native
CMD ["npx", "react-native", "start", "--host", "0.0.0.0"]