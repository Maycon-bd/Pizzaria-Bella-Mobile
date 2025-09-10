import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carrinho_provider.dart';
import '../models/pizza.dart';
import '../data/pizzas_data.dart';
import '../widgets/pizza_card.dart';
import '../widgets/custom_leading.dart';
import 'pizza_details_screen.dart';
import 'carrinho_screen.dart';

// Componente SEM estado (StatelessWidget)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Lista de pizzas disponíveis
  final List<Pizza> listaPizzas = const [
    Pizza(
      id: '1',
      nome: 'Moda da Casa',
      descricao: 'Molho de tomate, mussarela, manjericão fresco, Ingrediente secreto',
      preco: 32.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Manjericão', 'Ingrediente secreto'],
    ),
    Pizza(
      id: '2',
      nome: 'Pepperoni',
      descricao: 'Molho de tomate, mussarela, pepperoni',
      preco: 38.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Pepperoni'],
    ),
    Pizza(
      id: '3',
      nome: 'Quatro Queijos',
      descricao: 'Mussarela, gorgonzola, parmesão, provolone',
      preco: 42.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Mussarela', 'Gorgonzola', 'Parmesão', 'Provolone'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🍕 Pizzaria Bella',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        // Demonstrando componente leading personalizado
        leading: const LogoLeading(textoFallback: 'PB'),
        actions: [
          // Botão do carrinho com badge
          Consumer<CarrinhoProvider>(
            builder: (context, carrinho, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarrinhoScreen(),
                        ),
                      );
                    },
                  ),
                  if (carrinho.quantidadeItens > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${carrinho.quantidadeItens}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade50,
              Colors.orange.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header com informações da pizzaria
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'As Melhores Pizzas da Cidade!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ingredientes frescos • Massa artesanal • Entrega rápida',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Lista de pizzas (demonstrando ListView)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: listaPizzas.length,
                itemBuilder: (context, index) {
                  final pizza = listaPizzas[index];
                  return PizzaCard(
                    pizza: pizza,
                    onTap: () {
                      // Navegação para tela de detalhes
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PizzaDetailsScreen(pizza: pizza),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}