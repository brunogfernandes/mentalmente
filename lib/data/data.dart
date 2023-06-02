enum ImagensType { animal, comida }

class Imagens {
  final String imageUrl;
  final ImagensType type;

  Imagens({
    required this.imageUrl,
    required this.type,
  });
}

final allImagens = [
  Imagens(type: ImagensType.animal, imageUrl: 'images/tucano.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/uvas.png'),
  Imagens(type: ImagensType.animal, imageUrl: 'images/leao.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/banana.png'),
  Imagens(type: ImagensType.animal, imageUrl: 'images/tartaruga.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/laranja.png'),
  Imagens(type: ImagensType.animal, imageUrl: 'images/elefante.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/morango.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/maca.png'),
  Imagens(type: ImagensType.animal, imageUrl: 'images/gato.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/melancia.png'),
  Imagens(type: ImagensType.animal, imageUrl: 'images/cachorro.png'),
  Imagens(type: ImagensType.comida, imageUrl: 'images/pera.png'),
];
