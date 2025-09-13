# 🍕 Pizzaria Bella Mobile App

Aplicativo mobile completo para pizzaria desenvolvido em Flutter, com integração de API e sistema de fallback local.

## ✨ Funcionalidades

- 📱 **Interface Moderna**: Design responsivo e intuitivo
- 🍕 **Cardápio Dinâmico**: Carregamento via API com fallback local
- 🛒 **Carrinho de Compras**: Adicionar, remover e gerenciar pedidos
- 📦 **Sistema de Pedidos**: Finalização e acompanhamento de pedidos
- 🔄 **Modo Offline**: Funciona mesmo sem conexão com a API
- 💾 **Persistência**: Dados salvos localmente e sincronizados com API

## 🚀 Tecnologias Utilizadas

- **Flutter 3.24.5**: Framework principal
- **Provider**: Gerenciamento de estado
- **HTTP**: Comunicação com API REST
- **Material Design**: Interface de usuário

## 📋 Pré-requisitos

- Flutter SDK (versão 3.24.5 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

## 🛠️ Instalação e Execução

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/Maycon-bd/Pizzaria-Bella-Mobile.git
   cd Pizzaria-Bella-Mobile
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**:
   ```bash
   flutter run
   ```

## 🏗️ Estrutura do Projeto

```
lib/
├── src/
│   ├── models/          # Modelos de dados
│   │   ├── pizza.dart
│   │   ├── pedido.dart
│   │   └── item_carrinho.dart
│   ├── providers/       # Gerenciamento de estado
│   │   ├── cardapio_provider.dart
│   │   └── carrinho_provider.dart
│   ├── screens/         # Telas do aplicativo
│   │   ├── home_screen.dart
│   │   ├── checkout_screen.dart
│   │   └── pedidos_screen.dart
│   ├── services/        # Serviços e APIs
│   │   └── api_service.dart
│   ├── data/           # Dados locais
│   │   └── pizzas_data.dart
│   └── app.dart        # Configuração principal
└── main.dart           # Ponto de entrada
```

## 🔧 Configuração da API

O aplicativo está configurado para se conectar com uma API REST. Para alterar a URL da API, edite o arquivo `lib/src/services/api_service.dart`:

```dart
class ApiService {
  static const String baseUrl = 'http://SEU_IP:3000'; // Altere aqui
  // ...
}
```

## 📱 Funcionalidades Detalhadas

### Cardápio
- Carregamento automático via API
- Fallback para dados locais quando API indisponível
- Indicador visual de modo offline
- Refresh manual disponível

### Carrinho
- Adicionar pizzas com quantidades personalizadas
- Calcular total automaticamente
- Persistência entre sessões
- Validação antes da finalização

### Pedidos
- Finalização via API
- Histórico de pedidos
- Status de acompanhamento
- Sincronização automática

## 🔄 Sistema de Fallback

O aplicativo possui um sistema inteligente de fallback:

1. **Primeira tentativa**: Busca dados na API
2. **Em caso de erro**: Carrega dados locais automaticamente
3. **Indicação visual**: Banner informativo sobre modo offline
4. **Retry automático**: Tenta reconectar em operações futuras

## 🧪 Testes

Para executar os testes:

```bash
# Testes unitários
flutter test

# Análise de código
flutter analyze

# Formatação de código
flutter format .
```

## 📦 Build para Produção

### Android
```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autor

**Maycon** - [GitHub](https://github.com/Maycon-bd)

## 📞 Suporte

Se você encontrar algum problema ou tiver sugestões, por favor:

1. Verifique se já existe uma [issue](https://github.com/Maycon-bd/Pizzaria-Bella-Mobile/issues) similar
2. Se não existir, crie uma nova issue com detalhes do problema
3. Para dúvidas gerais, use as [Discussions](https://github.com/Maycon-bd/Pizzaria-Bella-Mobile/discussions)

---

**🍕 Feito com ❤️ para a Pizzaria Bella**

---

# 📱 Conceitos Flutter Implementados

Este projeto demonstra a implementação de diversos conceitos fundamentais do Flutter através de um aplicativo de pizzaria completo e funcional.

## 📋 Índice de Conceitos

1. [Estado (State Management)](#1-estado-state-management)
2. [Componentes com e sem Estado](#2-componentes-com-e-sem-estado)
3. [Formulários](#3-formulários)
4. [Listas](#4-listas)
5. [Grids](#5-grids)
6. [Navegação Tradicional](#6-navegação-tradicional)
7. [Bottom Navigation e TabBar](#7-bottom-navigation-e-tabbar)
8. [Conceitos de Front-end](#8-conceitos-de-front-end)
9. [Componente Leading](#9-componente-leading)

---

## 1. Estado (State Management)

### 🔍 O que é Estado?
Estado é qualquer informação que pode mudar durante o ciclo de vida de um widget. No Flutter, gerenciamos estado para manter a interface sincronizada com os dados.

### 📍 Implementações no Projeto:

#### Provider Pattern
- **Arquivo**: [`lib/src/providers/carrinho_provider.dart`](lib/src/providers/carrinho_provider.dart)
- **Conceito**: Gerenciamento de estado global usando ChangeNotifier
- **Exemplo**:
```dart
class CarrinhoProvider with ChangeNotifier {
  final List<ItemCarrinho> _itens = [];
  
  void adicionarItem(ItemCarrinho item) {
    _itens.add(item);
    notifyListeners(); // Notifica mudança de estado
  }
}
```

#### Estado Local com StatefulWidget
- **Arquivo**: [`lib/src/screens/main_screen.dart`](lib/src/screens/main_screen.dart) (linhas 17-31)
- **Conceito**: Gerenciamento de estado local para navegação entre abas
- **Exemplo**:
```dart
class _MainScreenState extends State<MainScreen> {
  late int _indiceAtual; // Estado local
  
  void _onItemTapped(int index) {
    setState(() {
      _indiceAtual = index; // Atualiza estado
    });
  }
}
```

---

## 2. Componentes com e sem Estado

### StatelessWidget (Sem Estado)
**Características**: Imutável, não possui estado interno que pode mudar

#### 📍 Exemplos no Projeto:
- **PizzaCard**: [`lib/src/widgets/pizza_card.dart`](lib/src/widgets/pizza_card.dart) (linhas 4-14)
- **App**: [`lib/src/app.dart`](lib/src/app.dart) (linhas 11-16)
- **IngredientesGrid**: [`lib/src/widgets/ingredientes_grid.dart`](lib/src/widgets/ingredientes_grid.dart) (linhas 4-13)

### StatefulWidget (Com Estado)
**Características**: Mutável, possui estado interno que pode ser alterado

#### 📍 Exemplos no Projeto:
- **MainScreen**: [`lib/src/screens/main_screen.dart`](lib/src/screens/main_screen.dart) (linhas 6-13)
- **CheckoutScreen**: [`lib/src/screens/checkout_screen.dart`](lib/src/screens/checkout_screen.dart) (linhas 6-11)
- **PizzaDetailsScreen**: [`lib/src/screens/pizza_details_screen.dart`](lib/src/screens/pizza_details_screen.dart) (linhas 9-16)

---

## 3. Formulários

### 🔍 Conceito
Formulários permitem coleta e validação de dados do usuário usando TextFormField, Form e GlobalKey.

### 📍 Implementação Principal:
**Arquivo**: [`lib/src/screens/checkout_screen.dart`](lib/src/screens/checkout_screen.dart)

#### Elementos do Formulário:
- **Form Widget**: Linha 118 - Container principal do formulário
- **GlobalKey**: Linha 15 - `final _formKey = GlobalKey<FormState>();`
- **TextFormField**: Múltiplas implementações para:
  - Nome do cliente
  - Telefone
  - Endereço
  - Observações

#### Validação:
```dart
TextFormField(
  controller: _nomeController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }
    return null;
  },
)
```

#### Formulário de Personalização:
**Arquivo**: [`lib/src/screens/pizza_details_screen.dart`](lib/src/screens/pizza_details_screen.dart)
- Campo de observações (linha ~300)
- Seleção de tamanho
- Controle de quantidade

---

## 4. Listas

### 🔍 Conceito
Listas exibem coleções de dados de forma scrollável usando ListView, ListView.builder, etc.

### 📍 Implementações no Projeto:

#### ListView.builder - Lista de Pizzas
**Arquivo**: [`lib/src/screens/home_screen.dart`](lib/src/screens/home_screen.dart) (linhas 240-270)
```dart
ListView.builder(
  itemCount: cardapioProvider.pizzas.length,
  itemBuilder: (context, index) {
    final pizza = cardapioProvider.pizzas[index];
    return PizzaCard(pizza: pizza, onTap: () => {...});
  },
)
```

#### Lista de Itens do Carrinho
**Arquivo**: [`lib/src/screens/carrinho_screen.dart`](lib/src/screens/carrinho_screen.dart) (linhas 69-77)
```dart
ListView.builder(
  itemCount: carrinho.itens.length,
  itemBuilder: (context, index) {
    final item = carrinho.itens[index];
    return _buildItemCarrinho(context, item, carrinho);
  },
)
```

#### Lista de Pedidos
**Arquivo**: [`lib/src/screens/pedidos_screen.dart`](lib/src/screens/pedidos_screen.dart)
- Implementa ListView para histórico de pedidos
- Usa Consumer para reatividade

---

## 5. Grids

### 🔍 Conceito
Grids organizam elementos em formato de grade usando GridView, Wrap, ou layouts customizados.

### 📍 Implementação Principal:
**Arquivo**: [`lib/src/widgets/ingredientes_grid.dart`](lib/src/widgets/ingredientes_grid.dart)

#### GridView para Ingredientes:
```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: _ingredientesExtras.length,
  itemBuilder: (context, index) {
    // Constrói cada item do grid
  },
)
```

#### Wrap para Tags de Ingredientes:
**Arquivo**: [`lib/src/widgets/pizza_card.dart`](lib/src/widgets/pizza_card.dart) (linhas 70-90)
```dart
Wrap(
  spacing: 6,
  runSpacing: 4,
  children: pizza.ingredientes.map((ingrediente) => 
    Container(/* chip de ingrediente */)
  ).toList(),
)
```

---

## 6. Navegação Tradicional

### 🔍 Conceito
Navegação usando rotas nomeadas e Navigator para transições entre telas.

### 📍 Implementações:

#### Rotas Nomeadas
**Arquivo**: [`lib/src/app.dart`](lib/src/app.dart) (linhas 27-31)
```dart
routes: {
  '/': (context) => const MainScreen(),
  '/checkout': (context) => const CheckoutScreen(),
},
```

#### Navegação por Objeto
**Arquivo**: [`lib/src/screens/home_screen.dart`](lib/src/screens/home_screen.dart) (linhas 260-265)
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PizzaDetailsScreen(pizza: pizza),
  ),
);
```

#### Navegação com Remoção de Stack
**Arquivo**: [`lib/src/screens/pizza_details_screen.dart`](lib/src/screens/pizza_details_screen.dart) (linhas 58-62)
```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const MainScreen()),
  (route) => false,
);
```

---

## 7. Bottom Navigation e TabBar

### 🔍 Conceito
Navegação inferior e por abas para organizar diferentes seções do app.

### 📍 Implementação Principal:
**Arquivo**: [`lib/src/screens/main_screen.dart`](lib/src/screens/main_screen.dart)

#### BottomNavigationBar
```dart
BottomNavigationBar(
  currentIndex: _indiceAtual,
  onTap: _onItemTapped,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Início',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      activeIcon: Icon(Icons.shopping_cart),
      label: 'Carrinho',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: 'Pedidos',
    ),
  ],
)
```

#### TabBar (Implementação Alternativa Comentada)
**Arquivo**: [`lib/src/screens/main_screen.dart`](lib/src/screens/main_screen.dart) (linhas 136-172)
- Demonstra como implementar TabBar como alternativa
- Usa TabController para gerenciar estado

---

## 8. Conceitos de Front-end

### 🔍 Conceitos Implementados:

#### Responsividade e Layout
- **Flex Layouts**: Row, Column, Expanded, Flexible
- **Container**: Padding, margin, decoration
- **Card**: Elevação e bordas arredondadas

#### Temas e Estilização
**Arquivo**: [`lib/src/theme/app_theme.dart`](lib/src/theme/app_theme.dart)
- Tema claro e escuro
- Cores consistentes
- Tipografia padronizada

#### Componentes Reutilizáveis
- **PizzaCard**: [`lib/src/widgets/pizza_card.dart`](lib/src/widgets/pizza_card.dart)
- **CustomLeading**: [`lib/src/widgets/custom_leading.dart`](lib/src/widgets/custom_leading.dart)
- **IngredientesGrid**: [`lib/src/widgets/ingredientes_grid.dart`](lib/src/widgets/ingredientes_grid.dart)

#### UX/UI Patterns
- Loading states
- Error handling
- Feedback visual (SnackBar, Dialog)
- Pull-to-refresh
- Empty states

---

## 9. Componente Leading

### 🔍 Conceito
O componente leading aparece no início do AppBar, usado para navegação ou ações principais.

### 📍 Implementação Completa:
**Arquivo**: [`lib/src/widgets/custom_leading.dart`](lib/src/widgets/custom_leading.dart)

#### Tipos de Leading Implementados:

1. **Ícone Personalizado** (linhas 10-29):
```dart
class IconeLeadingPersonalizado extends StatelessWidget {
  final IconData icone;
  final Color? cor;
  final VoidCallback? onPressed;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icone),
      color: cor ?? Colors.white,
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}
```

2. **Avatar Leading** (linhas 31-75):
- Exibe avatar do usuário
- Fallback para iniciais
- Suporte a imagem de rede

3. **Logo Leading** (linhas 77-120):
- Logo da empresa
- Texto de fallback
- Ação customizável

#### Uso nos AppBars:
**Arquivo**: [`lib/src/screens/pedidos_screen.dart`](lib/src/screens/pedidos_screen.dart)
```dart
AppBar(
  leading: const IconeLeadingPersonalizado(
    icone: Icons.receipt_long,
    cor: Colors.white,
  ),
  title: const Text('Meus Pedidos'),
)
```

---

## 🏗️ Arquitetura do Projeto

### Estrutura de Pastas:
```
lib/src/
├── app.dart                 # Configuração principal
├── models/                  # Modelos de dados
│   ├── pizza.dart
│   ├── pedido.dart
│   └── item_carrinho.dart
├── providers/               # Gerenciamento de estado
│   ├── carrinho_provider.dart
│   └── cardapio_provider.dart
├── screens/                 # Telas do aplicativo
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── carrinho_screen.dart
│   ├── pedidos_screen.dart
│   ├── checkout_screen.dart
│   └── pizza_details_screen.dart
├── widgets/                 # Componentes reutilizáveis
│   ├── pizza_card.dart
│   ├── custom_leading.dart
│   └── ingredientes_grid.dart
├── services/                # Serviços externos
│   └── api_service.dart
├── theme/                   # Temas e estilos
│   └── app_theme.dart
└── data/                    # Dados estáticos
    └── pizzas_data.dart
```

---

## 🚀 Como Executar

1. **Clone o repositório**
2. **Instale as dependências**: `flutter pub get`
3. **Execute o app**: `flutter run`
4. **Para web**: `flutter run -d chrome`

---

## 📚 Conceitos Avançados Demonstrados

- **Provider Pattern** para gerenciamento de estado
- **Repository Pattern** com ApiService
- **Factory Constructors** para parsing JSON
- **Enum** para status de pedidos
- **Extension Methods** (implícito no uso)
- **Async/Await** para operações assíncronas
- **Error Handling** com try-catch
- **Form Validation** com validators
- **Custom Widgets** reutilizáveis
- **Material Design** guidelines

---

## 🎯 Conclusão

Este projeto demonstra de forma prática e completa todos os conceitos fundamentais do Flutter, desde gerenciamento de estado até navegação avançada, fornecendo uma base sólida para desenvolvimento de aplicativos móveis robustos e escaláveis.

Cada conceito foi implementado seguindo as melhores práticas do Flutter, com código limpo, bem documentado e facilmente extensível.