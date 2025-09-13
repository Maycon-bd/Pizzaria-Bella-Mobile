import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/pizza.dart';
import '../models/item_carrinho.dart';
import '../models/pedido.dart';
import '../services/api_service.dart';

class CarrinhoProvider with ChangeNotifier {
  final List<ItemCarrinho> _itens = [];
  final List<Pedido> _pedidos = [];
  final Uuid _uuid = const Uuid();
  final ApiService _apiService = ApiService();

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

  Future<void> finalizarPedido({
    required String nomeCliente,
    required String telefone,
    required String endereco,
  }) async {
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

    try {
      // Envia o pedido para a API
      final response = await _apiService.criarPedido(novoPedidoCriado.toJson());
      print('Pedido salvo na API: $response');
      
      // Adiciona o pedido à lista local apenas se foi salvo com sucesso na API
      _pedidos.add(novoPedidoCriado);
      limparCarrinho();
      notifyListeners();
    } catch (e) {
      print('Erro ao salvar pedido na API: $e');
      // Ainda adiciona localmente para não perder o pedido
      _pedidos.add(novoPedidoCriado);
      limparCarrinho();
      notifyListeners();
      // Re-lança o erro para que a UI possa tratar
      rethrow;
    }
  }

  void atualizarStatusPedido(String pedidoId, StatusPedido novoStatus) {
    final indice = _pedidos.indexWhere((pedido) => pedido.id == pedidoId);
    if (indice != -1) {
      _pedidos[indice] = _pedidos[indice].copyWith(status: novoStatus);
      notifyListeners();
    }
  }

  /// Carrega pedidos salvos na API
  Future<void> carregarPedidosDaAPI() async {
    try {
      final pedidosJson = await _apiService.getPedidos();
      final pedidosCarregados = pedidosJson
          .map((json) => Pedido.fromJson(json))
          .toList();
      
      // Mescla com pedidos locais, evitando duplicatas
      for (final pedidoAPI in pedidosCarregados) {
        final jaExiste = _pedidos.any((p) => p.id == pedidoAPI.id);
        if (!jaExiste) {
          _pedidos.add(pedidoAPI);
        }
      }
      
      // Ordena por data (mais recente primeiro)
      _pedidos.sort((a, b) => b.dataHora.compareTo(a.dataHora));
      
      notifyListeners();
      print('Pedidos carregados da API: ${pedidosCarregados.length}');
    } catch (e) {
      print('Erro ao carregar pedidos da API: $e');
      // Não lança erro para não quebrar a UI
    }
  }
}