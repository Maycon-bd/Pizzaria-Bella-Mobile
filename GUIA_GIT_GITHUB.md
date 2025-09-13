# 📚 Guia Completo: Git e GitHub para Pizzaria App

## 🎯 Objetivo
Este guia te ensina como substituir completamente o conteúdo do seu repositório GitHub e configurar tudo para futuras atualizações independentes.

---

## 📋 Pré-requisitos

### 1. Instalar Git (se não tiver)
- Baixe em: https://git-scm.com/download/windows
- Durante a instalação, aceite as configurações padrão
- Reinicie o terminal após a instalação

### 2. Configurar Git (primeira vez apenas)
```bash
# Configure seu nome e email (use os mesmos do GitHub)
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@exemplo.com"

# Verificar configuração
git config --global --list
```

---

## 🚀 Passo a Passo: Substituir Repositório Completo

### Passo 1: Preparar o Projeto Local
```bash
# Navegar para a pasta do projeto
cd "C:\Desenvolvimento\Dev mobile\pizzaria_app"

# Inicializar repositório Git (se não existir)
git init

# Verificar status
git status
```

### Passo 2: Configurar Conexão com GitHub
```bash
# Adicionar repositório remoto (substitua pela sua URL)
git remote add origin https://github.com/Maycon-bd/Pizzaria-Bella-Mobile.git

# Verificar se foi adicionado
git remote -v
```

### Passo 3: Preparar Arquivos para Commit
```bash
# Adicionar todos os arquivos
git add .

# Verificar o que será commitado
git status

# Fazer o primeiro commit
git commit -m "🍕 Projeto Pizzaria App - Versão Completa com API e Fallback Local"
```

### Passo 4: Substituir Conteúdo do GitHub
```bash
# Forçar push (substitui todo o conteúdo do repositório)
git push -f origin main

# Se der erro de branch, tente:
git push -f origin master
```

---

## 🔄 Comandos para Futuras Atualizações

### Fluxo Normal de Trabalho
```bash
# 1. Verificar status dos arquivos
git status

# 2. Adicionar arquivos modificados
git add .                    # Adiciona todos os arquivos
# OU
git add arquivo_especifico.dart  # Adiciona arquivo específico

# 3. Fazer commit com mensagem descritiva
git commit -m "✨ Adicionar nova funcionalidade X"

# 4. Enviar para GitHub
git push origin main
```

### Exemplos de Mensagens de Commit
```bash
# Novas funcionalidades
git commit -m "✨ Adicionar sistema de avaliações"
git commit -m "🎨 Melhorar interface do carrinho"

# Correções de bugs
git commit -m "🐛 Corrigir erro no carregamento de pedidos"
git commit -m "🔧 Ajustar responsividade mobile"

# Atualizações de documentação
git commit -m "📚 Atualizar README com novas instruções"

# Melhorias de performance
git commit -m "⚡ Otimizar carregamento de imagens"
```

---

## 🛠️ Comandos Úteis para o Dia a Dia

### Verificar Histórico
```bash
# Ver últimos commits
git log --oneline -10

# Ver diferenças dos arquivos
git diff

# Ver status atual
git status
```

### Desfazer Alterações
```bash
# Desfazer alterações não commitadas
git checkout -- arquivo.dart

# Desfazer último commit (mantém alterações)
git reset --soft HEAD~1

# Desfazer último commit (remove alterações)
git reset --hard HEAD~1
```

### Trabalhar com Branches
```bash
# Criar nova branch para funcionalidade
git checkout -b nova-funcionalidade

# Voltar para branch principal
git checkout main

# Listar branches
git branch

# Fazer merge de branch
git merge nova-funcionalidade
```

---

## 📁 Arquivo .gitignore Recomendado

Crie/atualize o arquivo `.gitignore` na raiz do projeto:

```gitignore
# Flutter/Dart
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/

# IDE
.vscode/
.idea/
*.iml
*.ipr
*.iws

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Environment
.env
.env.local
.env.*.local

# Dependencies
node_modules/

# Build outputs
*.apk
*.aab
*.ipa
```

---

## 🚨 Solução de Problemas Comuns

### Erro: "Repository not found"
```bash
# Verificar URL do repositório
git remote -v

# Corrigir URL se necessário
git remote set-url origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
```

### Erro: "Permission denied"
```bash
# Configurar autenticação (use token do GitHub)
# Vá em GitHub > Settings > Developer settings > Personal access tokens
# Crie um token e use como senha
```

### Erro: "Branch diverged"
```bash
# Forçar push (cuidado: sobrescreve o remoto)
git push -f origin main

# OU fazer pull primeiro
git pull origin main
```

---

## 📱 Comandos Específicos para Flutter

### Antes de Fazer Commit
```bash
# Limpar build
flutter clean

# Verificar se não há erros
flutter analyze

# Formatar código
flutter format .

# Executar testes
flutter test
```

---

## 🎉 Resumo do Fluxo Completo

1. **Configuração Inicial** (uma vez só):
   ```bash
   git init
   git remote add origin URL_DO_SEU_REPO
   ```

2. **Primeira Substituição**:
   ```bash
   git add .
   git commit -m "🍕 Projeto Pizzaria App Completo"
   git push -f origin main
   ```

3. **Atualizações Futuras**:
   ```bash
   git add .
   git commit -m "Descrição da alteração"
   git push origin main
   ```

---

## 📞 Dicas Finais

- ✅ Sempre faça `git status` antes de qualquer operação
- ✅ Use mensagens de commit descritivas
- ✅ Faça commits pequenos e frequentes
- ✅ Teste o código antes de fazer push
- ✅ Mantenha o `.gitignore` atualizado
- ⚠️ Nunca commite senhas ou chaves de API
- ⚠️ Use `git push -f` apenas quando necessário

---

**🎯 Com este guia, você terá total autonomia para gerenciar seu repositório GitHub!**