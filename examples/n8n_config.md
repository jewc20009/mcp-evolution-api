# Configuração do MCP Server para Evolution API no n8n

Este documento fornece instruções para configurar o MCP Server da Evolution API para uso com o n8n.

## Configuração via STDIO (Command Line)

1. No n8n, adicione um nó "MCP Client (STDIO)".
2. Configure os campos conforme abaixo:

### Para Windows:

**Command:**
```
powershell
```

**Arguments:**
```
/c cd C:\caminho\completo\para\mcp-evolution-api && node dist/index.js
```

**Environments:**
```
EVOLUTION_API_URL=https://seu-servidor-evolution-api.com
EVOLUTION_API_KEY=sua-chave-api
EVOLUTION_API_INSTANCE=sua-instancia
```

### Para Linux/Mac:

**Command:**
```
bash
```

**Arguments:**
```
-c "cd /caminho/completo/para/mcp-evolution-api && node dist/index.js"
```

**Environments:**
```
EVOLUTION_API_URL=https://seu-servidor-evolution-api.com
EVOLUTION_API_KEY=sua-chave-api
EVOLUTION_API_INSTANCE=sua-instancia
```

## Configuração via WebSocket

Se você estiver enfrentando problemas com o método STDIO, especialmente em ambientes Docker, você pode usar o WebSocket:

1. Primeiro, inicie o servidor MCP com suporte a WebSocket:
```bash
cd /caminho/para/mcp-evolution-api
export ENABLE_WEBSOCKET=true
export PORT=3000
npm start
```

2. No n8n, adicione um nó "MCP Client (SSE)".
3. Configure a URL como:
```
ws://seu-servidor:3000
```

## Solução de problemas

### Erro de conexão fechada

Se você encontrar o erro "Connection closed", verifique:

1. O servidor MCP está em execução?
2. Você configurou corretamente o caminho no n8n?
3. As variáveis de ambiente estão corretas?
4. Tente o método WebSocket se o STDIO falhar

### Problemas com Docker

Se estiver executando o n8n em Docker, certifique-se de:

1. Usar o método WebSocket em vez de STDIO
2. Configurar as redes Docker para que o contêiner n8n possa acessar o servidor MCP

### Testando a conexão

Você pode testar a conexão listando as ferramentas disponíveis. Após configurar, clique em "List Available Tools" no nó MCP Client. 