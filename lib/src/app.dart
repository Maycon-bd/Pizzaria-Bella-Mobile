import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/carrinho_provider.dart';
import 'providers/cardapio_provider.dart';
import 'screens/main_screen.dart';
import 'screens/pizza_details_screen.dart';
import 'screens/checkout_screen.dart';
import 'models/pizza.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarrinhoProvider()),
        ChangeNotifierProvider(create: (context) => CardapioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pizzaria Flutter',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        // Navegação tradicional por rotas nomeadas
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
        // Tratamento de rotas não encontradas
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Página não encontrada'),
              ),
              body: const Center(
                child: Text(
                  'Ops! Página não encontrada 😅',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}