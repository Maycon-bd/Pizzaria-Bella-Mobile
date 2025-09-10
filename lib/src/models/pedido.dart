import 'item_carrinho.dart';

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
}