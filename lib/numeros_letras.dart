import 'package:flutter/material.dart';
import 'dart:math';

class NumerosLetrasPage extends StatefulWidget {
  const NumerosLetrasPage({super.key});

  @override
  State<NumerosLetrasPage> createState() => _NumerosLetrasPageState();
}

class _NumerosLetrasPageState extends State<NumerosLetrasPage> {
  final Random random = Random();
  final int minImages = 1;
  final int maxImages = 5;

  final List<String> animalImages = [
    'images/Baleia.png',
    'images/Urso.png',
    'images/Cachorro.png',
    'images/Passaro.png',
    'images/Pinguin.png',
    'images/Borboleta.png',
    'images/Girafa.png',
    'images/Gato.png',
    'images/Elefante.png',
    'images/Polvo.png',
    'images/Coelho.png',
    'images/Cavalo.png',
    'images/Porco.png',
    'images/Formiga.png',
    'images/Camelo.png',
  ];

  final List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  final List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'X',
    'Z'
  ];

  bool numberSelected = false;
  int selectedNumber = -1;
  bool letterSelected = false;
  String selectedLetter = '';
  int counter = 0;

  List<String> randomImageList = [];

  bool showTemporaryMessage = false;
  String temporaryMessage = '';

  @override
  void initState() {
    super.initState();
    generateRandomImages();
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Bem-vindo!'),
            content: const Text(
                'Para ganhar pontos, arraste a quantidade de números até caixa com nome número, também arraste a letra inicial do nome do animal'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    });
  }

  void generateRandomImages() {
    int numberOfImages = random.nextInt(maxImages - minImages + 1) + minImages;

    int randomIndex = random.nextInt(animalImages.length);
    String randomImage = animalImages[randomIndex];

    randomImageList = List.generate(numberOfImages, (index) => randomImage);
  }

  void checkSelections() {
    if (numberSelected && letterSelected) {
      String firstImage = randomImageList.first;
      String imageName = firstImage.split('/').last;
      String firstLetter = imageName.substring(0, 1);

      if (selectedNumber == randomImageList.length &&
          selectedLetter == firstLetter) {
        showTemporaryDialog('Parabéns, você acertou!');
        generateRandomImages();
        counter = counter + 20;
      } else {
        showTemporaryDialog('Você errou. Tente novamente!');
        counter = counter - 10;
      }
      setState(() {
        selectedNumber = -1;
        selectedLetter = '';
        numberSelected = false;
        letterSelected = false;
      });
    }
  }

  void selectNumber(int number) {
    if (!numberSelected) {
      setState(() {
        numberSelected = true;
        selectedNumber = number;
      });
      checkSelections();
    }
  }

  void selectLetter(String letter) {
    if (!letterSelected) {
      setState(() {
        letterSelected = true;
        selectedLetter = letter;
      });

      checkSelections();
    }
  }

  void showTemporaryDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> randomImageWidgets = randomImageList.map((image) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x00ffffff), // transparente
            ),
            child: ClipOval(
              child: Image.asset(image, width: 100.0, height: 100.0),
            ),
          ),
        ),
      );
    }).toList();

    List<Widget> numberWidgets = numbers.map((number) {
      final bool isSelected = int.parse(number) == selectedNumber;

      return Expanded(
        child: Draggable(
          data: int.parse(number),
          feedback: Material(
            child: Container(
              width: 50.0,
              height: 50.0,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(fontSize: 10.0, fontFamily: "Chewy"),
                ),
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffff4242),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff5a5a5a),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ], // Cor branca do fundo
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: isSelected ? Colors.blue : Colors.white,
                    fontFamily: "Lilita One",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();

    List<Widget> letterWidgets = letters.map((letter) {
      final bool isSelected = letter == selectedLetter;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Draggable(
          data: letter,
          feedback: Material(
            child: Container(
              width: 50.0,
              height: 50.0,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  letter,
                  style: const TextStyle(fontSize: 10.0),
                ),
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: Container(
            width: 45.0,
            height: 45.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xfffee92a),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff5a5a5a),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ], // Cor branca do fundo
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                    fontSize: 30.0,
                    color: isSelected ? Colors.white : Colors.indigo,
                    fontFamily: "Lilita One"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0097b2),
      appBar: AppBar(
        title: const Text('Vamos contar!'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: randomImageWidgets,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numberWidgets,
          ),
          const SizedBox(height: 16.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: letterWidgets,
          ),
          const SizedBox(height: 16.0),
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DragTarget<int>(
                builder: (BuildContext context, List<int?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    width: 75.0,
                    height: 50.0,
                    color: const Color(0xffff4242),
                    child: Center(
                      child: Text(
                        selectedNumber != -1
                            ? selectedNumber.toString()
                            : 'NÚMERO',
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: "Lilita One"),
                      ),
                    ),
                  );
                },
                onAccept: (int data) {
                  setState(() {
                    selectedNumber = data;
                    numberSelected = true;
                  });
                  checkSelections();
                },
              ),
              const SizedBox(width: 16.0),
              DragTarget<String>(
                builder: (BuildContext context, List<String?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    width: 65.0,
                    height: 50.0,
                    color: const Color(0xfffee92a),
                    child: Center(
                      child: Text(
                        selectedLetter.isNotEmpty ? selectedLetter : 'LETRA',
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.indigo,
                            fontFamily: "Lilita One"),
                      ),
                    ),
                  );
                },
                onAccept: (String data) {
                  setState(() {
                    selectedLetter = data;
                    letterSelected = true;
                  });
                  checkSelections();
                },
              ),
              const SizedBox(height: 16.0),
              const Padding(padding: EdgeInsets.only(left: 20.0)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'PONTOS: $counter',
                    style: const TextStyle(fontSize: 18.0, fontFamily: "Lilita One"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}