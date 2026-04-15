# 🏭 Atlas Industrial - Catálogo de Peças Premium

Catálogo universal de peças de engenharia mecânica desenvolvido em Flutter, com foco em componentes de GLP (gás liquefeito de petróleo).

## ✨ Características

### 🎨 Design Premium Industrial
- Interface sofisticada e moderna
- Paleta de cores profissional (preto, dourado, ciano)
- Layout responsivo e intuitivo
- Tipografia premium com Google Fonts

### 📦 Catálogo Completo
- **Válvulas** - Válvulas de segurança e controle
- **Conexões** - Acoplamentos e conexões rápidas
- **Extensões** - Tubos e extensões
- **Reguladores** - Reguladores de pressão
- **Acessórios** - Diversos componentes

### 🔍 Funcionalidades
- ✅ Busca avançada em tempo real
- ✅ Filtro por categorias
- ✅ Detalhes técnicos precisos
- ✅ Galeria de imagens
- ✅ Especificações completas
- ✅ Carrinho de compras
- ✅ Favoritos

## 🚀 Tecnologias

- **Flutter 3.41.6** - Framework UI
- **Dart 3.11.4** - Linguagem
- **GoRouter** - Roteamento
- **Provider** - State Management
- **Google Fonts** - Tipografia premium

## 📱 Plataformas Suportadas

- 🌐 **Web** (Principal - Full responsive)
- 📱 **iOS** (Suportado)
- 🤖 **Android** (Suportado)
- 🖥️ **Windows** (Suportado)
- 🍎 **macOS** (Suportado)
- 🐧 **Linux** (Suportado)

## 🔧 Instalação Local (Opcional)

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/atlas_industrial.git
cd atlas_industrial

# Instale dependências
flutter pub get

# Execute a aplicação (web)
flutter run -d chrome

# Build para produção
flutter build web --release
```

## 🧩 Site estático HTML/CSS/JS

Para testar a versão estática do site Atlas Industrial:

```bash
cd site
python3 -m http.server 8000
```

Em seguida, abra no navegador:

`http://127.0.0.1:8000`

## ☁️ CI/CD na Nuvem

Este projeto utiliza **GitHub Actions** para executar testes, análise de código e builds automaticamente na nuvem, sem consumir recursos locais.

### Workflows Disponíveis

1. **Test & Analyze** - Testes unitários e análise estática
2. **Build Web** - Compilação para web (pronto para deploy)
3. **Code Quality** - Cobertura de testes e métricas
4. **Deploy Web** - Publica o build web no GitHub Pages

### Publicação Web

- O site será publicado automaticamente na branch `gh-pages`
- Após o primeiro push, o endereço deverá ser:
  `https://esdrasgomes547-maker.github.io/Atlas-Industrial/`
- Para testar em modo smartphone, abra o site no navegador e use o DevTools > Device Toolbar

### Como Usar

1. **Push seu código:**
   ```bash
   git add .
   git commit -m "feat: Add new feature"
   git push origin main
   ```

2. **Acompanhe em GitHub:**
   - Vá em **Actions** na página do repositório
   - Veja workflows rodando em tempo real
   - Baixe artifacts (builds compilados)

3. **Download dos Resultados:**
   - Web build em `Artifacts > atlas-industrial-web-*`
   - Extraia e hospede em qualquer servidor web

## 📊 Estrutura do Projeto

```
atlas_industrial/
├── lib/
│   ├── main.dart                      # Ponto de entrada
│   ├── screens/                       # Telas da aplicação
│   │   ├── home_screen.dart          # Home com catálogo
│   │   ├── product_detail_screen.dart # Detalhes do produto
│   │   └── search_screen.dart        # Busca
│   ├── widgets/                       # Componentes reutilizáveis
│   │   └── product_card.dart         # Card de produto
│   ├── models/                        # Modelos de dados
│   │   └── product.dart              # Modelo Product
│   ├── providers/                     # State Management
│   │   └── catalog_provider.dart     # Provider do catálogo
│   └── theme/                         # Tema e estilos
│       └── app_theme.dart            # Tema da aplicação
├── site/                              # Site estático HTML/CSS/JS do Atlas Industrial
│   ├── index.html                    # Página principal do catálogo
│   ├── style.css                     # Estilos do site
│   └── app.js                        # Lógica de busca e exibição de produtos
├── test/                              # Testes
├── .github/
│   └── workflows/                     # GitHub Actions
│       └── deploy.yml                # Pipeline de build & deploy
└── pubspec.yaml                       # Dependências
```

## 🎯 Próximos Passos

- [ ] Integração com banco de dados (Firebase)
- [ ] Sistema de autenticação
- [ ] Carrinho de compras persistente
- [ ] Sistema de pedidos
- [ ] Admin dashboard
- [ ] API REST customizada
- [ ] Notificações push
- [ ] App mobile otimizado

## 📝 Notas

- **0 consumo de disco local** - Builds na nuvem via GitHub Actions
- **Atualização contínua** - Deploy automático de mudanças
- **Escalável** - Pronto para crescimento
- **Premium first** - Design sofisticado e industrial

## 📞 Suporte

Para dúvidas ou problemas:
1. Consulte a documentação do [Flutter](https://flutter.dev)
2. Verifique os logs em GitHub Actions
3. Abra uma issue no repositório

## 📄 Licença

MIT License - Sinta-se livre para usar e modificar.

---

**Desenvolvido com ❤️ para a engenharia mecânica**
