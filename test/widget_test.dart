// Teste básico do widget da Pizzaria App.
//
// Para realizar interações com widgets no teste, use o WidgetTester
// da biblioteca flutter_test. Por exemplo, você pode enviar gestos de toque e rolagem.
// Você também pode usar WidgetTester para encontrar widgets filhos na árvore de widgets,
// ler texto e verificar se os valores das propriedades dos widgets estão corretos.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pizzaria_app/src/app.dart';
import 'package:pizzaria_app/src/providers/carrinho_provider.dart';

void main() {
  testWidgets('Pizzaria app loads correctly', (WidgetTester tester) async {
    // Constrói o app e dispara um frame.
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verifica se o app carrega corretamente.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Carrinho'), findsOneWidget);
  });
  
  testWidgets('Carrinho provider works', (WidgetTester tester) async {
    // Testa se o provider do carrinho funciona corretamente.
    final carrinho = CarrinhoProvider();
    
    // Verifica se o carrinho começa vazio.
    expect(carrinho.itens.length, 0);
    expect(carrinho.valorTotal, 0.0);
    expect(carrinho.carrinhoVazio, true);
  });
}
