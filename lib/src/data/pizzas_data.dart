import '../models/pizza.dart';

class PizzasData {
  static const List<Pizza> pizzas = [
    Pizza(
      id: '1',
      nome: 'Margherita',
      descricao: 'Molho de tomate, mussarela, manjericão fresco e azeite',
      preco: 32.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Manjericão', 'Azeite'],
    ),
    Pizza(
      id: '2',
      nome: 'Pepperoni',
      descricao: 'Molho de tomate, mussarela e pepperoni',
      preco: 38.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Pepperoni'],
    ),
    Pizza(
      id: '3',
      nome: 'Quatro Queijos',
      descricao: 'Mussarela, gorgonzola, parmesão e provolone',
      preco: 42.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Mussarela', 'Gorgonzola', 'Parmesão', 'Provolone'],
    ),
    Pizza(
      id: '4',
      nome: 'Calabresa',
      descricao: 'Molho de tomate, mussarela, calabresa e cebola',
      preco: 35.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Calabresa', 'Cebola'],
    ),
    Pizza(
      id: '5',
      nome: 'Portuguesa',
      descricao: 'Molho de tomate, mussarela, presunto, ovos, cebola e azeitona',
      preco: 39.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Presunto', 'Ovos', 'Cebola', 'Azeitona'],
    ),
    Pizza(
      id: '6',
      nome: 'Frango com Catupiry',
      descricao: 'Molho de tomate, mussarela, frango desfiado e catupiry',
      preco: 41.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Frango desfiado', 'Catupiry'],
    ),
    Pizza(
      id: '7',
      nome: 'Vegetariana',
      descricao: 'Molho de tomate, mussarela, tomate, pimentão, cebola e azeitona',
      preco: 36.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Tomate', 'Pimentão', 'Cebola', 'Azeitona'],
    ),
    Pizza(
      id: '8',
      nome: 'Bacon',
      descricao: 'Molho de tomate, mussarela, bacon e cebola',
      preco: 37.90,
      imagemUrl: 'assets/images/pizza.jfif',
      ingredientes: ['Molho de tomate', 'Mussarela', 'Bacon', 'Cebola'],
    ),
  ];

  static const List<String> ingredientesExtras = [
    'Bacon',
    'Pepperoni',
    'Calabresa',
    'Frango',
    'Presunto',
    'Catupiry',
    'Cheddar',
    'Gorgonzola',
    'Parmesão',
    'Tomate',
    'Cebola',
    'Pimentão',
    'Azeitona',
    'Manjericão',
    'Rúcula',
    'Champignon',
  ];

  static const List<String> tamanhos = [
    'Pequena',
    'Média',
    'Grande',
    'Família',
  ];

  static double getPrecoTamanho(String tamanho) {
    switch (tamanho) {
      case 'Pequena':
        return 0.8; // 20% desconto
      case 'Média':
        return 1.0; // preço base
      case 'Grande':
        return 1.3; // 30% acréscimo
      case 'Família':
        return 1.6; // 60% acréscimo
      default:
        return 1.0;
    }
  }
}