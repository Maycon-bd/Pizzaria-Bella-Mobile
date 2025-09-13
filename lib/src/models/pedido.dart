import 'item_carrinho.dart';
import 'pizza.dart';

enum StatusPedido {
  preparando,
  pronto,
  entregue,
  cancelado,
}

class Pedido {
  final String id;
  final List<ItemCarrinho> itens;
  final DateTime dataHora;
  final StatusPedido status;
  final String endereco;
  final String telefone;
  final String nomeCliente;

  const Pedido({
    required this.id,
    required this.itens,
    required this.dataHora,
    required this.status,
    required this.endereco,
    required this.telefone,
    required this.nomeCliente,
  });

  double get valorTotal {
    return itens.fold(0.0, (total, item) => total + item.precoTotal);
  }

  int get quantidadeItens {
    return itens.fold(0, (total, item) => total + item.quantidade);
  }

  String get statusTexto {
    switch (status) {
      case StatusPedido.preparando:
        return 'Preparando';
      case StatusPedido.pronto:
        return 'Pronto';
      case StatusPedido.entregue:
        return 'Entregue';
      case StatusPedido.cancelado:
        return 'Cancelado';
    }
  }

  Pedido copyWith({
    String? id,
    List<ItemCarrinho>? itens,
    DateTime? dataHora,
    StatusPedido? status,
    String? endereco,
    String? telefone,
    String? nomeCliente,
  }) {
    return Pedido(
      id: id ?? this.id,
      itens: itens ?? this.itens,
      dataHora: dataHora ?? this.dataHora,
      status: status ?? this.status,
      endereco: endereco ?? this.endereco,
      telefone: telefone ?? this.telefone,
      nomeCliente: nomeCliente ?? this.nomeCliente,
    );
  }

  @override
  String toString() {
    return 'Pedido{id: $id, cliente: $nomeCliente, valor: $valorTotal, status: $statusTexto}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pedido && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Factory constructor para criar Pedido a partir de JSON da API
  factory Pedido.fromJson(Map<String, dynamic> json) {
    // Converte itens da API para ItemCarrinho
    List<ItemCarrinho> itensConvertidos = [];
    if (json['itens'] != null) {
      for (var item in json['itens'] as List) {
        try {
          // Cria uma Pizza simples a partir dos dados da API
           final pizza = Pizza(
             id: item['id']?.toString() ?? '',
             nome: item['nome']?.toString() ?? '',
             descricao: item['descricao']?.toString() ?? '',
             preco: (item['preco'] as num?)?.toDouble() ?? 0.0,
             imagemUrl: item['imagem']?.toString() ?? '',
             ingredientes: item['ingredientes'] != null 
                 ? List<String>.from(item['ingredientes'])
                 : <String>[],
             tamanho: item['tamanho']?.toString() ?? 'Média',
           );
          
          final itemId = DateTime.now().millisecondsSinceEpoch.toString();
          print('Criando ItemCarrinho com ID: $itemId');
          
          final itemCarrinho = ItemCarrinho(
            id: itemId,
            pizza: pizza,
            quantidade: (item['quantidade'] as num?)?.toInt() ?? 1,
            observacoes: item['observacoes']?.toString() ?? '',
          );
          
          itensConvertidos.add(itemCarrinho);
        } catch (e) {
          print('Erro ao converter item: $e');
          // Cria um item de fallback para não quebrar a tela
          final pizzaFallback = Pizza(
            id: 'error',
            nome: 'Item com erro',
            descricao: 'Erro ao carregar dados',
            preco: 0.0,
            imagemUrl: '',
            ingredientes: [],
            tamanho: 'Média',
          );
          
          final itemFallback = ItemCarrinho(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            pizza: pizzaFallback,
            quantidade: 1,
            observacoes: 'Erro no carregamento',
          );
          
          itensConvertidos.add(itemFallback);
        }
      }
    }
    
    return Pedido(
      id: json['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      itens: itensConvertidos,
      dataHora: json['dataHora'] != null
          ? DateTime.tryParse(json['dataHora']) ?? DateTime.now()
          : DateTime.now(),
      status: _statusFromString(json['status']?.toString()),
      endereco: json['endereco']?.toString() ?? '',
      telefone: json['telefone']?.toString() ?? '',
      nomeCliente: json['cliente']?.toString() ?? json['nomeCliente']?.toString() ?? 'Cliente',
    );
  }

  /// Converte Pedido para JSON para envio à API
  Map<String, dynamic> toJson() {
    return {
      'cliente': nomeCliente,
      'itens': itens.map((item) => {
        'nome': item.pizza.nome,
        'quantidade': item.quantidade,
        'preco': item.pizza.preco,
      }).toList(),
      'total': valorTotal,
      'observacoes': itens.map((item) => item.observacoes).where((obs) => obs.isNotEmpty).join('; '),
      'status': _statusToString(status),
    };
  }

  /// Converte string para StatusPedido
  static StatusPedido _statusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'recebido':
      case 'preparando':
        return StatusPedido.preparando;
      case 'em preparo':
      case 'pronto':
        return StatusPedido.pronto;
      case 'entregue':
        return StatusPedido.entregue;
      case 'cancelado':
        return StatusPedido.cancelado;
      default:
        return StatusPedido.preparando;
    }
  }

  /// Converte StatusPedido para string
  static String _statusToString(StatusPedido status) {
    switch (status) {
      case StatusPedido.preparando:
        return 'Recebido';
      case StatusPedido.pronto:
        return 'Em preparo';
      case StatusPedido.entregue:
        return 'Entregue';
      case StatusPedido.cancelado:
        return 'Cancelado';
    }
  }
}