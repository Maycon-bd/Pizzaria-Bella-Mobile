import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/pizza.dart';
import '../models/item_carrinho.dart';
import '../models/pedido.dart';

class CarrinhoProvider with ChangeNotifier {
  final List<ItemCarrinho> _itens = [];
  final List<Pedido> _pedidos = [];
  final Uuid _uuid = const Uuid();

  List<ItemCarrinho> get itens => List.unmodifiable(_itens);
  List<Pedido> get pedidos => List.unmodifiable(_pedidos);

  int get quantidadeItens {
    return _itens.fold(0, (total, item) => total + item.quantidade);
  }

  double get valorTotal {
    return _itens.fold(0.0, (total, item) => total + item.precoTotal);
  }

  bool get carrinhoVazio => _itens.isEmpty;

  void adicionarItem({
    required Pizza pizza,
    int quantidade = 1,
    List<String> ingredientesExtras = const [],
    String observacoes = '',
  }) {
    final novoItemCarrinho = ItemCarrinho(
      id: _uuid.v4(),
      pizza: pizza,
      quantidade: quantidade,
      ingredientesExtras: ingredientesExtras,
      observacoes: observacoes,
    );

    _itens.add(novoItemCarrinho);
    notifyListeners();
  }

  void removerItem(String itemId) {
    _itens.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void atualizarQuantidade(String itemId, int novaQuantidade) {
    if (novaQuantidade <= 0) {
      removerItem(itemId);
      return;
    }

    final indice = _itens.indexWhere((item) => item.id == itemId);
    if (indice != -1) {
      _itens[indice] = _itens[indice].copyWith(quantidade: novaQuantidade);
      notifyListeners();
    }
  }

  void limparCarrinho() {
    _itens.clear();
    notifyListeners();
  }

  void finalizarPedido({
    required String nomeCliente,
    required String telefone,
    required String endereco,
  }) {
    if (_itens.isEmpty) return;

    final novoPedidoCriado = Pedido(
      id: _uuid.v4(),
      itens: List.from(_itens),
      dataHora: DateTime.now(),
      status: StatusPedido.preparando,
      nomeCliente: nomeCliente,
      telefone: telefone,
      endereco: endereco,
    );

    _pedidos.add(novoPedidoCriado);
    limparCarrinho();
    notifyListeners();
  }

  void atualizarStatusPedido(String pedidoId, StatusPedido novoStatus) {
    final indice = _pedidos.indexWhere((pedido) => pedido.id == pedidoId);
    if (indice != -1) {
      _pedidos[indice] = _pedidos[indice].copyWith(status: novoStatus);
      notifyListeners();
    }
  }
}