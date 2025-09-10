# Imagens do Sistema

Esta pasta contém as imagens utilizadas no aplicativo da pizzaria.

## Como adicionar novas imagens:

1. Coloque suas imagens nesta pasta (formatos suportados: PNG, JPG, JPEG, GIF, WebP)
2. Atualize o arquivo `pubspec.yaml` na seção `flutter > assets` se necessário
3. Use as imagens no código com `Image.asset('assets/images/nome_da_imagem.png')`

## Imagens sugeridas para o projeto:

- `moda_da_casa.png` - Pizza Moda da Casa
- `pepperoni.png` - Pizza Pepperoni
- `quatro_queijos.png` - Pizza Quatro Queijos
- `calabresa.png` - Pizza Calabresa
- `portuguesa.png` - Pizza Portuguesa
- `frango_catupiry.png` - Pizza Frango com Catupiry
- `vegetariana.png` - Pizza Vegetariana
- `bacon.png` - Pizza Bacon
- `logo.png` - Logo da pizzaria

## Exemplo de uso no código:

```dart
Image.asset(
  'assets/images/margherita.png',
  width: 80,
  height: 80,
  fit: BoxFit.cover,
)
```

## Substituindo emojis por imagens reais:

Para substituir os emojis 🍕 por imagens reais:

1. Adicione as imagens das pizzas nesta pasta
2. Atualize o arquivo `pizzas_data.dart` alterando o campo `imagemUrl` de cada pizza
3. Modifique o `pizza_card.dart` para usar `Image.asset()` ao invés de `Text()`