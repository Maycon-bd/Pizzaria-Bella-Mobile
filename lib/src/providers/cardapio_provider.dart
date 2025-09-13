import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../services/api_service.dart';
import '../data/pizzas_data.dart';

enum CardapioState { Idle, Loading, Success, Error }

class CardapioProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Pizza> _pizzas = [];
  List<Pizza> get pizzas => _pizzas;

  CardapioState _state = CardapioState.Idle;
  CardapioState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _usingLocalData = false;
  bool get usingLocalData => _usingLocalData;

  Future<void> fetchPizzas() async {
    _state = CardapioState.Loading;
    notifyListeners();

    try {
      // Tenta buscar da API primeiro
      _pizzas = await _apiService.getPizzas();
      _usingLocalData = false;
      _state = CardapioState.Success;
      print('Cardápio carregado da API com sucesso: ${_pizzas.length} pizzas');
    } catch (e) {
      print('Erro ao carregar da API: $e');
      print('Usando dados locais como fallback...');
      
      // Fallback para dados locais
      _pizzas = PizzasData.pizzas;
      _usingLocalData = true;
      _state = CardapioState.Success;
      _errorMessage = 'Usando dados offline. Verifique sua conexão.';
      
      print('Cardápio carregado dos dados locais: ${_pizzas.length} pizzas');
    }

    notifyListeners();
  }
}