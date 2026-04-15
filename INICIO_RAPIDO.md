# 🚀 INSTRUÇÕES FINAIS - 3 PASSOS SIMPLES

## ✅ Projeto Pronto em: `c:\atlas_industrial\`

---

## 📋 PASSO 1: Criar Repositório GitHub (5 minutos)

1. Abra: https://github.com/new
2. Preencha:
   - **Repository name:** `atlas_industrial`
   - **Description:** "Catálogo de peças mecânicas"
   - Marque: **Public**
3. Clique: **Create repository**
4. Copie a URL mostrada (será algo como `https://github.com/seu-usuario/atlas_industrial.git`)

---

## 📤 PASSO 2: Fazer Push (1 minuto)

**Opção A - MAIS FÁCIL (Script automático):**

1. Abra terminal em `c:\atlas_industrial\`
2. Execute:
   ```bash
   push-github.bat
   ```
3. Cole seu username do GitHub quando pedido
4. Pronto! ✅

---

**Opção B - Manual (se o script não funcionar):**

1. Abra terminal em `c:\atlas_industrial\`
2. Execute EXATAMENTE:
   ```bash
   git remote add origin https://github.com/SEU_USERNAME_AQUI/atlas_industrial.git
   git branch -M main
   git push -u origin main
   ```
   (Substitua `SEU_USERNAME_AQUI` pelo seu username do GitHub)

3. Se pedir senha, use um **token** (veja fim deste arquivo)

---

## ⏳ PASSO 3: Aguardar e Baixar Build (10-15 minutos)

1. Vá em: `https://github.com/seu-usuario/atlas_industrial`
2. Clique em: **Actions** (aba na página)
3. Aguarde workflows executarem (verá uma lista)
4. Quando terminar, clique no workflow
5. Role até **Artifacts**
6. Baixe: `atlas-industrial-web-*`
7. Extraia em qualquer pasta
8. Abra: `build/web/index.html` em navegador

**PRONTO! Seu app está rodando! 🎉**

---

## 🔑 Se Pedir Token/Senha

Se Git pedir senha:
1. Vá em: https://github.com/settings/tokens
2. Clique: **Generate new token** → **Generate new token (classic)**
3. Preencha:
   - **Note:** "Atlas Industrial"
   - **Expiration:** 30 days
   - Marque: **repo** (único checkbox necessário)
4. Clique: **Generate token**
5. **Copie o token** (aparece em verde)
6. Use como SENHA no git push

---

## 🎯 Resumo

| Passo | Ação | Tempo |
|-------|------|-------|
| 1 | Criar repo GitHub | 5 min |
| 2 | Fazer push | 1 min |
| 3 | Aguardar + baixar | 15 min |
| **TOTAL** | | **~20 min** |

---

## ✨ Pronto!

Após fazer push e baixar o build:

✅ App rodando na web  
✅ CI/CD automático  
✅ Código no GitHub  
✅ Build compilado  
✅ 0 consumo de disco local  

**Tudo funcionando! 🚀**

---

Dúvidas? Veja:
- `PUSH_GUIDE_PT-BR.md` - Guia completo
- `STATUS_COMPLETO.md` - Status detalhado
- `README.md` - Documentação do projeto
