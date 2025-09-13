import 'package:dio/dio.dart';
import '../models/pizza.dart'; // Importa o modelo Pizza

// Mantenha seu IP aqui
const String BASE_URL = 'http://192.168.0.203:3000';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  /// Busca o cardápio e já retorna uma lista de objetos Pizza prontos.
  Future<List<Pizza>> getPizzas() async {
    try {
      // 1. Faz a chamada para o endpoint que retorna o objeto completo
      final response = await _dio.get('/cardapio');
      
      print('Status Code: ${response.statusCode}');
      print('Response Data Type: ${response.data.runtimeType}');
      print('Response Data: ${response.data}');

      // 2. Valida se a resposta está OK e tem o formato esperado
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        
        // 3. Verifica se existe a estrutura esperada
        if (responseData.containsKey('cardapio') &&
            responseData['cardapio'] is Map<String, dynamic>) {
          
          final cardapioData = responseData['cardapio'] as Map<String, dynamic>;
          
          // 4. Verifica se existe a lista de pizzas
          if (cardapioData.containsKey('pizzas') && cardapioData['pizzas'] is List) {
            final pizzasList = cardapioData['pizzas'] as List;
            
            print('Pizzas encontradas: ${pizzasList.length}');
            
            // 5. Mapeia a lista de JSON para uma lista de Objetos Pizza e a retorna
            return pizzasList.map((json) => Pizza.fromJson(json as Map<String, dynamic>)).toList();
          }
        }
      }
      
      // Se a estrutura do JSON for diferente, lança um erro claro.
      throw Exception('Formato de resposta inválido para cardápio');

    } on DioException catch (e) {
      print('Erro de Dio ao buscar pizzas: $e');
      throw Exception('Erro inesperado ao buscar pizzas: ${e.toString()}');
    } catch (e) {
      print('Erro inesperado ao buscar pizzas: $e');
      throw Exception('Erro inesperado ao buscar pizzas: ${e.toString()}');
    }
  }

  /// Cria um novo pedido
  Future<Map<String, dynamic>> criarPedido(Map<String, dynamic> pedidoData) async {
    try {
      print('Dados sendo enviados para API: $pedidoData');
      final response = await _dio.post('/pedidos', data: pedidoData);
      print('Pedido criado com sucesso: ${response.data}');
      return response.data;
    } catch (e) {
      print('Erro ao criar pedido: $e');
      throw e;
    }
  }

  /// Busca todos os pedidos salvos na API
  Future<List<Map<String, dynamic>>> getPedidos() async {
    try {
      final response = await _dio.get('/pedidos');
      
      print('Status Code: ${response.statusCode}');
      print('Pedidos Response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return List<Map<String, dynamic>>.from(response.data);
        } else if (response.data is Map<String, dynamic> && 
                   response.data.containsKey('pedidos')) {
          return List<Map<String, dynamic>>.from(response.data['pedidos']);
        }
      }
      
      throw Exception('Formato de resposta inválido para pedidos');
    } catch (e) {
      print('Erro ao buscar pedidos: $e');
      throw e;
    }
  }
}

