import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza.dart';
import '../data/pizzas_data.dart';
import '../providers/carrinho_provider.dart';
import '../widgets/ingredientes_grid.dart';
import 'main_screen.dart';

// Componente COM estado (StatefulWidget) - demonstrando formulários
class PizzaDetailsScreen extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetailsScreen({super.key, required this.pizza});

  @override
  State<PizzaDetailsScreen> createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> {
  // Estado do formulário
  String _tamanhoSelecionado = 'Média';
  int _quantidade = 1;
  final List<String> _ingredientesExtras = [];
  final TextEditingController _observacoesController = TextEditingController();

  @override
  void dispose() {
    _observacoesController.dispose();
    super.dispose();
  }

  double get _precoTotal {
    double precoBasico = widget.pizza.preco * PizzasData.getPrecoTamanho(_tamanhoSelecionado);
    double precoIngredientesExtras = _ingredientesExtras.length * 2.0;
    return (precoBasico + precoIngredientesExtras) * _quantidade;
  }

  void _adicionarAoCarrinho() {
    final carrinho = Provider.of<CarrinhoProvider>(context, listen: false);
    
    final pizzaPersonalizada = widget.pizza.copyWith(
      tamanho: _tamanhoSelecionado,
      preco: widget.pizza.preco * PizzasData.getPrecoTamanho(_tamanhoSelecionado),
    );

    carrinho.adicionarItem(
      pizza: pizzaPersonalizada,
      quantidade: _quantidade,
      ingredientesExtras: _ingredientesExtras,
      observacoes: _observacoesController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.pizza.nome} adicionada ao carrinho! 🍕'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // Navegar para a tela principal (dashboard)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pizza.nome),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem e informações básicas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF3E0),
                    Color(0xFFFFFBF0),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFE0B2),
                          Color(0xFFFFCC80),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8A65).withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        widget.pizza.imagemUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              '🍕',
                              style: TextStyle(fontSize: 60),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.pizza.nome,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E2E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pizza.descricao,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF616161),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Formulário de personalização
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ingredientes originais
                  const Text(
                    'Ingredientes:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: widget.pizza.ingredientes
                        .map((ingrediente) => Chip(
                              label: Text(
                                ingrediente,
                                style: const TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              backgroundColor: const Color(0xFFE8F5E8),
                              side: const BorderSide(
                                color: Color(0xFF81C784),
                                width: 1,
                              ),
                            ))
                        .toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Seleção de tamanho
                  const Text(
                    'Tamanho:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: PizzasData.tamanhos.map((tamanho) {
                      final isSelected = _tamanhoSelecionado == tamanho;
                      return ChoiceChip(
                        label: Text(
                          tamanho,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFF616161),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _tamanhoSelecionado = tamanho;
                            });
                          }
                        },
                        selectedColor: const Color(0xFFFFEBEE),
                        backgroundColor: const Color(0xFFF5F5F5),
                        side: BorderSide(
                          color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFE0E0E0),
                          width: isSelected ? 2 : 1,
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Grid de ingredientes extras - demonstra conceito de Grid
                  IngredientesGrid(
                    ingredientesSelecionados: _ingredientesExtras,
                    onIngredienteToggle: (ingrediente) {
                      setState(() {
                        if (_ingredientesExtras.contains(ingrediente)) {
                          _ingredientesExtras.remove(ingrediente);
                        } else {
                          _ingredientesExtras.add(ingrediente);
                        }
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Quantidade
                  const Text(
                    'Quantidade:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 218, 211, 211),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _quantidade > 1
                            ? () {
                                setState(() {
                                  _quantidade--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        iconSize: 32,
                        color: _quantidade > 1 ? const Color(0xFFD32F2F) : const Color(0xFFBDBDBD),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFAFAFA),
                        ),
                        child: Text(
                          '$_quantidade',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E2E2E),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantidade++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 32,
                        color: const Color(0xFFD32F2F),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Campo de observações
                  const Text(
                    'Observações:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 218, 211, 211),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _observacoesController,
                    decoration: InputDecoration(
                      hintText: 'Ex: Sem cebola, massa fina...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9E9E9E),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                      fillColor: const Color(0xFFFAFAFA),
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: Color(0xFF2E2E2E),
                    ),
                    maxLines: 3,
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Botão de adicionar ao carrinho
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'R\$ ${_precoTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _adicionarAoCarrinho,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: const Color(0xFFD32F2F).withOpacity(0.3),
              ),
              child: const Text(
                'Adicionar ao Carrinho',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}