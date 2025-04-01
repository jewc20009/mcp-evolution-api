FROM node:18-alpine

WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./
RUN npm ci --only=production

# Copiar arquivos de código compilado
COPY dist ./dist
COPY .env.example ./.env.example

# Definir variáveis de ambiente padrão
ENV NODE_ENV=production

# Expor a porta para WebSocket (opcional, usada se WebSocket estiver habilitado)
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["node", "dist/index.js"] 