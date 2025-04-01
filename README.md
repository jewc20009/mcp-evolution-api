# MCP Server para Evolution API

Este projeto implementa um servidor MCP (Model Context Protocol) que expõe todas as funcionalidades da Evolution API v2 para modelos de linguagem.

## Funcionalidades

O servidor expõe todas as categorias de funcionalidades da Evolution API:

### Gestão de Instâncias
- Verificação de status da API e instância
- Criação, exclusão e reinicialização de instâncias
- Gestão de presença
- Logout

### Envio de Mensagens
- Mensagens de texto
- Mensagens com mídia (imagens, documentos, vídeos, áudios)
- Stickers
- Localização
- Contatos
- Enquetes e listas
- Status

### Gestão de Chat
- Verificação de números WhatsApp
- Marcação de mensagens como lidas
- Arquivamento de conversas
- Exclusão de mensagens
- Gestão de presença no chat
- Busca de mensagens e contatos

### Perfil
- Busca e atualização de informações de perfil
- Atualização de foto de perfil
- Configuração de privacidade

### Grupos
- Criação e gestão de grupos
- Adição/remoção de participantes
- Configuração de mensagens efêmeras
- Convites de grupo

### Integrações Adicionais
- Typebot
- Chatwoot

## Requisitos

- Node.js 18+
- NPM ou Yarn
- Acesso a um servidor Evolution API v2

## Configuração

1. Clone este repositório
2. Instale as dependências:

```bash
npm install
```

3. Configure as variáveis de ambiente:

```bash
# URL do servidor Evolution API
export EVOLUTION_API_URL="https://seu-servidor-evolution-api.com"
# Chave API da Evolution API
export EVOLUTION_API_KEY="sua-chave-api"
# ID da instância WhatsApp na Evolution API
export EVOLUTION_API_INSTANCE="instancia-padrao"
```

Ou crie um arquivo `.env` na raiz do projeto com essas variáveis.

## Execução

Para iniciar o servidor em modo de desenvolvimento:

```bash
npm run dev
```

Para compilar e executar em produção:

```bash
npm run build
npm start
```

## Ferramentas Disponíveis

O servidor MCP expõe as seguintes ferramentas que podem ser chamadas pelo cliente MCP:

### Informações Gerais
- `getApiStatus`: Verifica o status da Evolution API

### Gestão de Instâncias
- `getInstanceStatus`: Verifica o status da conexão do WhatsApp
- `setPresence`: Define o status de presença
- `logoutInstance`: Desconecta a instância
- `restartInstance`: Reinicia a instância

### Mensagens
- `sendTextMessage`: Envia uma mensagem de texto
- `sendMedia`: Envia mídia (imagem, documento, vídeo, áudio)
- `sendAudio`: Envia áudio/mensagem de voz
- `sendSticker`: Envia um sticker
- `sendLocation`: Envia uma localização
- `sendContact`: Envia um contato
- `sendPoll`: Envia uma enquete

### Controle de Chat
- `checkWhatsAppNumber`: Verifica se um número é do WhatsApp
- `markMessageAsRead`: Marca mensagem como lida
- `archiveChat`: Arquiva/desarquiva um chat
- `deleteMessageForEveryone`: Exclui mensagem para todos

### Perfil
- `updateProfileName`: Atualiza o nome do perfil
- `updateProfileStatus`: Atualiza o status do perfil

### Grupos
- `createGroup`: Cria um novo grupo
- `addGroupParticipants`: Adiciona participantes a um grupo

## Recursos Disponíveis

O servidor MCP disponibiliza os seguintes recursos:

- `contacts://list`: Lista todos os contatos disponíveis
- `chats://list`: Lista todas as conversas disponíveis
- `groups://list`: Lista todos os grupos disponíveis
- `profile://info`: Exibe informações do perfil
- `privacy://settings`: Exibe configurações de privacidade

## Exemplo de uso com Claude via MCP

```typescript
import { McpClient } from "@modelcontextprotocol/sdk/client/mcp.js";

// Conecte-se ao servidor MCP
const client = new McpClient();
await client.connect(mcpServerTransport);

// Verificar status da API
const status = await client.callTool("getApiStatus", {});
console.log(status.content[0].text);

// Enviar uma mensagem
const msgResult = await client.callTool("sendTextMessage", {
  number: "5511999999999",
  text: "Olá, esta é uma mensagem de teste!"
});
console.log(msgResult.content[0].text);

// Enviar uma mídia
const mediaResult = await client.callTool("sendMedia", {
  number: "5511999999999",
  url: "https://exemplo.com/imagem.jpg",
  caption: "Veja esta imagem!",
  mediaType: "image"
});
console.log(mediaResult.content[0].text);

// Carregar recursos
const groups = await client.loadResource("groups://list");
console.log(groups.contents[0].text);
``` 