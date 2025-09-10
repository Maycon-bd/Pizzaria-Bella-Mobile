class Pizza {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  final List<String> ingredientes;
  final String tamanho;

  const Pizza({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    required this.ingredientes,
    this.tamanho = 'Média',
  });

  Pizza copyWith({
    String? id,
    String? nome,
    String? descricao,
    double? preco,
    String? imagemUrl,
    List<String>? ingredientes,
    String? tamanho,
  }) {
    return Pizza(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      ingredientes: ingredientes ?? this.ingredientes,
      tamanho: tamanho ?? this.tamanho,
    );
  }

  @override
  String toString() {
    return 'Pizza{id: $id, nome: $nome, preco: $preco, tamanho: $tamanho}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pizza && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}