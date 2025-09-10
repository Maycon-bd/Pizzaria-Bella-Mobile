import 'package:flutter/material.dart';
import '../data/pizzas_data.dart';

// Componente SEM estado para demonstrar grids
class IngredientesGrid extends StatelessWidget {
  final List<String> ingredientesSelecionados;
  final Function(String) onIngredienteToggle;
  
  const IngredientesGrid({
    super.key,
    required this.ingredientesSelecionados,
    required this.onIngredienteToggle,
  });
  
  // Lista de ingredientes extras disponíveis
  static const List<String> _ingredientesExtras = [
    'Queijo Extra',
    'Bacon',
    'Cogumelos',
    'Cebola',
    'Pimentão',
    'Azeitona',
    'Tomate',
    'Orégano',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da seção
          Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Ingredientes Extras',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          Text(
            'Selecione os ingredientes adicionais (+ R\$ 3,00 cada)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Grid de ingredientes - demonstra conceito de Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 colunas
              childAspectRatio: 3.5, // Proporção largura/altura
              crossAxisSpacing: 8, // Espaçamento horizontal
              mainAxisSpacing: 8, // Espaçamento vertical
            ),
            itemCount: _ingredientesExtras.length,
            itemBuilder: (context, index) {
              final ingrediente = _ingredientesExtras[index];
              final isSelected = ingredientesSelecionados.contains(ingrediente);
              
              return _buildIngredienteCard(ingrediente, isSelected);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Grid alternativo com diferentes proporções
          const Text(
            'Sugestões Populares:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Grid com 3 colunas para demonstrar flexibilidade
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            children: [
              _buildSugestaoChip('🧀 + 🍄', ['Queijo Extra', 'Cogumelos']),
              _buildSugestaoChip('🥓 + 🧅', ['Bacon', 'Cebola']),
              _buildSugestaoChip('🍅 + 🌿', ['Tomate', 'Manjericão']),
            ],
          ),
          
          if (ingredientesSelecionados.isNotEmpty) ...[
            const SizedBox(height: 16),
            
            // Resumo dos ingredientes selecionados
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredientes Selecionados:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: ingredientesSelecionados.map((ingrediente) {
                      return Chip(
                        label: Text(
                          ingrediente,
                          style: const TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.blue.shade100,
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => onIngredienteToggle(ingrediente),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total extras: + R\$ ${(ingredientesSelecionados.length * 3.0).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIngredienteCard(String ingrediente, bool isSelected) {
    return GestureDetector(
      onTap: () => onIngredienteToggle(ingrediente),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue.shade400 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              // Ícone do ingrediente
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade400 : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSelected ? Icons.check : Icons.add,
                  size: 12,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Nome do ingrediente
              Expanded(
                child: Text(
                  ingrediente,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSugestaoChip(String emoji, List<String> ingredientes) {
    final jaTemTodos = ingredientes.every((ing) => ingredientesSelecionados.contains(ing));
    
    return GestureDetector(
      onTap: () {
        for (String ingrediente in ingredientes) {
          if (!ingredientesSelecionados.contains(ingrediente)) {
            onIngredienteToggle(ingrediente);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: jaTemTodos ? Colors.green.shade100 : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: jaTemTodos ? Colors.green.shade300 : Colors.orange.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 2),
            Icon(
              jaTemTodos ? Icons.check_circle : Icons.add_circle_outline,
              size: 12,
              color: jaTemTodos ? Colors.green.shade600 : Colors.orange.shade600,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget adicional para demonstrar Grid com diferentes layouts
class IngredientesStaggeredGrid extends StatelessWidget {
  final List<String> ingredientes;
  final List<String> selecionados;
  final Function(String) onToggle;
  
  const IngredientesStaggeredGrid({
    super.key,
    required this.ingredientes,
    required this.selecionados,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ingredientes.map((ingrediente) {
        final isSelected = selecionados.contains(ingrediente);
        return FilterChip(
          label: Text(ingrediente),
          selected: isSelected,
          onSelected: (selected) => onToggle(ingrediente),
          backgroundColor: Colors.grey.shade100,
          selectedColor: Colors.blue.shade100,
          checkmarkColor: Colors.blue.shade700,
        );
      }).toList(),
    );
  }
}