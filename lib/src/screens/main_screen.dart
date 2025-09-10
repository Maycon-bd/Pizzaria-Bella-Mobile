import 'package:flutter/material.dart';
import 'package:pizzaria_app/src/screens/home_screen.dart';
import 'package:pizzaria_app/src/screens/carrinho_screen.dart';
import 'package:pizzaria_app/src/screens/pedidos_screen.dart';

// Componente COM estado (StatefulWidget) - demonstra gerenciamento de estado
class MainScreen extends StatefulWidget {
  final int initialIndex;
  
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// Estado da tela principal
class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  // Estado: índice da aba atual
  late int _indiceAtual;
  
  // Estado: controlador para animações de transição
  late TabController _controladorAbas;
  
  // Estado: controlador de página para navegação suave
  late PageController _controladorPagina;

  // Lista de telas para navegação
  final List<Widget> _telas = [
    const HomeScreen(),
    const CarrinhoScreen(),
    const PedidosScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Inicialização do estado
    _indiceAtual = widget.initialIndex;
    _controladorAbas = TabController(length: 3, vsync: this, initialIndex: widget.initialIndex);
    _controladorPagina = PageController(initialPage: widget.initialIndex);
    
    // Listener para sincronizar TabController com PageController
    _controladorAbas.addListener(() {
      if (_controladorAbas.indexIsChanging) {
        onTabTapped(_controladorAbas.index);
      }
    });
  }

  @override
  void dispose() {
    // Limpeza do estado
    _controladorAbas.dispose();
    _controladorPagina.dispose();
    super.dispose();
  }

  // Método para atualizar o estado quando uma aba é tocada
  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
    
    // Animação suave entre páginas
    _controladorPagina.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Método para atualizar o estado quando a página é deslizada
  void _onPageChanged(int index) {
    setState(() {
      _indiceAtual = index;
    });
    _controladorAbas.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corpo principal com PageView para navegação por deslize
      body: PageView(
        controller: _controladorPagina,
        onPageChanged: _onPageChanged,
        children: _telas,
      ),
      
      // BottomNavigationBar - demonstra navegação por abas
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Início',
              tooltip: 'Tela inicial com cardápio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Carrinho',
              tooltip: 'Itens no carrinho de compras',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Pedidos',
              tooltip: 'Histórico de pedidos',
            ),
          ],
        ),
      ),
      
      // TabBar alternativo (comentado) - demonstra outra forma de navegação
      /*
      appBar: AppBar(
        title: const Text('Pizzaria Flutter'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
              text: 'Início',
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              text: 'Carrinho',
            ),
            Tab(
              icon: Icon(Icons.receipt_long),
              text: 'Pedidos',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _screens,
      ),
      */
    );
  }
}

// Widget auxiliar para demonstrar conceitos de front-end
class AnimatedTabIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  
  const AnimatedTabIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          itemCount,
          (index) => Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? Colors.blue.shade700
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}