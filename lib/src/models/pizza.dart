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

  /// Factory constructor para criar Pizza a partir de JSON da API (CORRIGIDO)
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      // A API envia 'id' (um número), então convertemos para String.
      id: json['id'].toString(),

      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      preco: (json['preco'] as num).toDouble(),
      
      // A API envia 'imagem', nós o atribuímos à nossa propriedade 'imagemUrl'.
      imagemUrl: json['imagem'] as String, 

      // A API envia 'ingredientes', está correto.
      ingredientes: List<String>.from(json['ingredientes']),

      // A API não envia 'tamanho', então usamos o valor padrão 'Média' do construtor.
      tamanho: json['tamanho'] ?? 'Média',
    );
  }

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

  /// Converte Pizza para JSON para envio à API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagemUrl': imagemUrl,
      'ingredientes': ingredientes,
      'tamanho': tamanho,
    };
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