import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'iniciais.dart';
import 'baldes.dart';
import 'numeros_letras.dart';

void main() => runApp(const MyApp());

int? selectedImageIndex; // Variável global para armazenar o índice da imagem selecionada

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentalmente',
      home: const SalaPage(),
      routes: {
        '/banheiro': (context) => const BanheiroPage(),
        '/sala-jogos': (context) => const GameRoomPage(),
        '/menu-jogos': (context) => const MenuJogos(),
        '/jogo-iniciais': (context) => const JogoIniciais(),
        '/jogo-baldes': (context) => const BaldesPage(),
        '/jogo-numeros-letras': (context) => const NumerosLetrasPage(),
        '/em-construcao': (context) => const TesteRotas(),
      },
    );
  }
}

class SalaPage extends StatefulWidget {
  const SalaPage({super.key});

  @override
  State<SalaPage> createState() => _SalaPageState();
}

class _SalaPageState extends State<SalaPage> {
  bool isImageSelected = false;
  late Size imageSize;
  int index = Random().nextInt(2);
  List<String> imagens = [
    'images/urso-pensativo.png',
  ];
  List<String> draggableImagens = [
    'images/bolinho.png',
  ];

  int? generatedIndex; // Alteração: Usar um tipo opcional para controlar se o índice foi gerado

  @override
  void initState() {
    super.initState();
  }

  Future<void> _choiceImg() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  bool isImageMatched = false;
  Map<int, bool> isImageMatchedMap = {0: false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sala de Estar'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              // Perform an action when the button is pressed
              Navigator.pushNamed(context, '/banheiro');
            },
          ),
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'images/sala.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder(
              future: _choiceImg(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(
                      child: Image.asset(
                        'images/urso-feliz.png', // Substitua pelo caminho da sua imagem
                        width: 200,
                        height: 200,
                      ),
                    );
                  case ConnectionState.done:
                    index = Random().nextInt(1);
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: DragTarget<int>(
                              builder: (context, candidateData, rejectedData) {
                                return isImageMatchedMap[index] == true
                                    ? Image.asset(
                                        imagens[index],
                                        width: 200,
                                        height: 200,
                                      )
                                    : Image.asset(
                                        imagens[index],
                                        width: 200,
                                        height: 200,
                                      );
                              },
                              onAccept: (int draggedImageIndex) async {
                                if (draggedImageIndex == index) {
                                  setState(() {
                                    isImageMatchedMap[index] = true;
                                    selectedImageIndex = draggedImageIndex;
                                    // Save the selected image index to the global variable
                                    _choiceImg();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Draggable<int>(
                                data: 0,
                                feedback: Image.asset(
                                  draggableImagens[0],
                                  width: 50,
                                  height: 50,
                                ),
                                childWhenDragging: Container(),
                                child: Image.asset(
                                  draggableImagens[0],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  default:
                    return Container(); // Add a default return statement
                }
              },
            ),
          ],
        ));
  }
}

class BanheiroPage extends StatefulWidget {
  const BanheiroPage({super.key});

  @override
  State<BanheiroPage> createState() => _BanheiroPageState();
}

class _BanheiroPageState extends State<BanheiroPage> {
  bool isImageSelected = false;
  late Size imageSize;
  int index = Random().nextInt(2);
  List<String> imagens = [
    'images/ursinho-dente-sujo.png',
    'images/ursinho-sujo.png'
  ];
  List<String> draggableImagens = [
    'images/escova-de-dente.png',
    'images/sabonete.png'
  ];
  int?
      generatedIndex; // Alteração: Usar um tipo opcional para controlar se o índice foi gerado

  @override
  void initState() {
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      // obtém o tamanho da imagem de fundo
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      imageSize = renderBox.size;
    });*/
  }

  Future<void> _choiceImg() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  bool isImageMatched = false;
  Map<int, bool> isImageMatchedMap = {0: false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Banheiro'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              // Perform an action when the button is pressed
              Navigator.pushNamed(context, '/sala-jogos');
            },
          ),
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'images/banheiro.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder(
              future: _choiceImg(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(
                      child: Image.asset(
                        'images/ursinho-limpo.png', // Substitua pelo caminho da sua imagem
                        width: 200,
                        height: 200,
                      ),
                    );
                  case ConnectionState.done:
                    index = Random().nextInt(2);
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: DragTarget<int>(
                              builder: (context, candidateData, rejectedData) {
                                return isImageMatchedMap[index] == true
                                    ? Image.asset(
                                        imagens[index],
                                        width: 200,
                                        height: 200,
                                      )
                                    : Image.asset(
                                        imagens[index],
                                        width: 200,
                                        height: 200,
                                      );
                              },
                              onAccept: (int draggedImageIndex) async {
                                if (draggedImageIndex == index) {
                                  setState(() {
                                    isImageMatchedMap[index] = true;
                                    selectedImageIndex = draggedImageIndex;
                                    // Save the selected image index to the global variable
                                    _choiceImg();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Draggable<int>(
                                data: 0,
                                feedback: Image.asset(
                                  draggableImagens[0],
                                  width: 50,
                                  height: 50,
                                ),
                                childWhenDragging: Container(),
                                child: Image.asset(
                                  draggableImagens[0],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Draggable<int>(
                                data: 1,
                                feedback: Image.asset(
                                  draggableImagens[1],
                                  width: 50,
                                  height: 50,
                                ),
                                childWhenDragging: Container(),
                                child: Image.asset(
                                  draggableImagens[1],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  default:
                    return Container(); // Add a default return statement
                }
              },
            ),
          ],
        ));
  }
}

class GameRoomPage extends StatelessWidget {
  const GameRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sala de Jogos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // Ação quando o ícone de volta for pressionado
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/sala-jogos.jpeg'), // Caminho da imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('images/urso-feliz.png'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/menu-jogos');
                },
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('images/controle-de-video-game.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuJogos extends StatelessWidget {
  const MenuJogos({super.key});

  @override
  Widget build(BuildContext context) {
    double larguraBotao = MediaQuery.of(context).size.width - 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brincadeiras'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF34deff),
            Color(0xFF9f6fff),
          ],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
                children: [
                  Text(
                    'Mentalmente',
                    style: TextStyle(
                      fontFamily: 'Chewy',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      fontSize: 48,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Escolha uma das brincadeiras e se divirta conosco!',
                    style: TextStyle(
                        fontFamily: 'Comic Sans MS',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        color: Color.fromARGB(255, 250, 249, 249),
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 0.5,
                            color: Colors.black,
                          ),
                        ]),
                  ),
                ],
              ),
              Wrap(
                runSpacing: 16,
                children: [
                  botaoJogo(
                      'Iniciais',
                      'Descubra as iniciais dos animais!',
                      FontAwesomeIcons.font,
                      const Color(0xFF4c5270),
                      larguraBotao,
                      context,
                      '/jogo-iniciais'),
                  botaoJogo(
                      'Animal ou Fruta?',
                      'Arraste para o balde certo!',
                      FontAwesomeIcons.appleWhole,
                      const Color.fromARGB(255, 216, 95, 153),
                      larguraBotao,
                      context,
                      '/jogo-baldes'),
                  botaoJogo(
                      'Vamos contar!',
                      'Acerte o número de bichinhos!',
                      FontAwesomeIcons.arrowUp91,
                      const Color(0xFF3F3FD4),
                      larguraBotao,
                      context,
                      '/jogo-numeros-letras'),
                  botaoJogo(
                      'Historinhas', 
                      'Aprenda com histórias!', 
                      FontAwesomeIcons.book,
                      const Color(0xFFAC001E), 
                      larguraBotao, 
                      context, 
                      '/em-construcao'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector botaoJogo(String titulo, String descricao, IconData icone, Color cor, double larguraBotao, BuildContext context, String rota){

    return GestureDetector(
      child: Container(
        width: larguraBotao,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      descricao,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(160, 255, 255, 255),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),  
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              child: FaIcon(icone, size: 36, color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, rota);
      },
    );
  }
}

class TesteRotas extends StatelessWidget {
  const TesteRotas({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Voltar para o menu'),
      ),
    );
  }
}