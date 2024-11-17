# 1. Resmi Node.js imajını kullanıyoruz (hafif Alpine sürümü)
FROM node:18-alpine

# 2. Çalışma dizinini belirtiyoruz
WORKDIR /app

# 3. package.json ve package-lock.json dosyalarını kopyalıyoruz
COPY package.json package-lock.json ./

# 4. Node.js bağımlılıklarını yüklüyoruz
RUN npm install

# 5. Uygulama kodunu kopyalıyoruz
COPY . .

# 6. Next.js uygulamasını optimize ediyoruz (opsiyonel)
RUN npm run build

# 7. Uygulama 3000 portunda çalışıyor
EXPOSE 3000

# 8. Uygulama çalıştırma komutu
CMD ["npm", "start"]
