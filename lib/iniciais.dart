import 'package:flutter/material.dart';

class JogoIniciais extends StatefulWidget {
  const JogoIniciais({super.key});

  @override
  State<JogoIniciais> createState() => _JogoIniciaisState();
}

class _JogoIniciaisState extends State<JogoIniciais> {
  final Map<String, String> objectData = {
    'banana': 'B',
    'maca': 'M',
    'leao': 'L',
    'caixa': 'C',
  };

  List<String> randomizedObjectNames = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    randomizedObjectNames = generateRandomizedObjectNames();
  }

  List<String> generateRandomizedObjectNames() {
    List<String> objectNames = objectData.keys.toList();
    objectNames.shuffle(); // Embaralhar a ordem dos objetos
    return objectNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0097b2),
      appBar: AppBar(
        title: const Text('Acerte as iniciais'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 20),
          Text(
            "Letra Inicial",
            style: TextStyle(
              fontFamily: "Chewy",
              fontSize: 50,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..strokeWidth = 1
                ..color = const Color(0xffffffff),
              height: 0,
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Color(0xff3e3e3e),
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
          Text(
            'Pontuação: $score',
            style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 0),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: objectData.entries.map((entry) {
              String objectName = entry.key;
              String initialLetter = entry.value;

              return DragTarget<String>(
                builder: (BuildContext context, List<String?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: const Color(0xff42139a),
                    child: Center(
                      child: Text(
                        initialLetter,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: "Archivo Black",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                onWillAccept: (data) {
                  return data == objectName;
                },
                onAccept: (data) {
                  if (objectData[data] == initialLetter) {
                    setState(() {
                      score++; // Increase the score
                      objectData.remove(data);
                    });
                    if (score == 4) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Parabéns'),
                            content: const Text('Você acertou tudo!'),
                            actions: [
                              TextButton(
                                child: const Text('Fechar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Objeto Correspondente'),
                          content: Text(
                              'Você acertou! O objeto "$data" corresponde à letra inicial "$initialLetter".'),
                          actions: [
                            TextButton(
                              child: const Text('Fechar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Objeto Incorreto'),
                          content: Text(
                              'O objeto "$data" não corresponde à letra inicial correta.'),
                          actions: [
                            TextButton(
                              child: const Text('Fechar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: randomizedObjectNames.map((objectName) {
              return Draggable<String>(
                data: objectName,
                feedback: Image.asset(
                  'images/$objectName.png',
                  width: 80,
                  height: 80,
                ),
                childWhenDragging: Container(
                  width: 80,
                  height: 80,
                  color: Colors.transparent,
                ),
                child: Image.asset(
                  'images/$objectName.png',
                  width: 80,
                  height: 80,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xfffa627b),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.autorenew,
                color: Color(0xffffffff),
                size: 24.0,
              ),
              onPressed: () {},
            ),
            Text(
              'Reiniciar',
              style: TextStyle(
                fontSize: 18,
                foreground: Paint()
                  ..style = PaintingStyle.fill
                  ..strokeWidth = 1
                  ..color = const Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}