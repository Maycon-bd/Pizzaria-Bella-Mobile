import 'pizza.dart';

class ItemCarrinho {
  final String id;
  final Pizza pizza;
  final int quantidade;
  final List<String> ingredientesExtras;
  final String observacoes;

  const ItemCarrinho({
    required this.id,
    required this.pizza,
    required this.quantidade,
    this.ingredientesExtras = const [],
    this.observacoes = '',
  });

  double get precoTotal {
    double precoBasico = pizza.preco * quantidade;
    double precoIngredientesExtras = ingredientesExtras.length * 2.0 * quantidade; // R$ 2,00 por ingrediente extra
    return precoBasico + precoIngredientesExtras;
  }

  ItemCarrinho copyWith({
    String? id,
    Pizza? pizza,
    int? quantidade,
    List<String>? ingredientesExtras,
    String? observacoes,
  }) {
    return ItemCarrinho(
      id: id ?? this.id,
      pizza: pizza ?? this.pizza,
      quantidade: quantidade ?? this.quantidade,
      ingredientesExtras: ingredientesExtras ?? this.ingredientesExtras,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  @override
  String toString() {
    return 'ItemCarrinho{id: $id, pizza: ${pizza.nome}, quantidade: $quantidade, precoTotal: $precoTotal}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemCarrinho && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Factory constructor para criar ItemCarrinho a partir de JSON da API
  factory ItemCarrinho.fromJson(Map<String, dynamic> json) {
    return ItemCarrinho(
      id: json['id']?.toString() ?? '',
      pizza: Pizza.fromJson(json['pizza'] ?? {}),
      quantidade: json['quantidade']?.toInt() ?? 1,
      ingredientesExtras: json['ingredientesExtras'] != null
          ? List<String>.from(json['ingredientesExtras'])
          : <String>[],
      observacoes: json['observacoes']?.toString() ?? '',
    );
  }

  /// Converte ItemCarrinho para JSON para envio à API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizza': pizza.toJson(),
      'quantidade': quantidade,
      'ingredientesExtras': ingredientesExtras,
      'observacoes': observacoes,
      'precoTotal': precoTotal,
    };
  }
}