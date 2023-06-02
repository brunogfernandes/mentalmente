import 'package:flutter/material.dart';
import 'data/data.dart';

class BaldesPage extends StatefulWidget {
  const BaldesPage({super.key});

  @override
  State<BaldesPage> createState() => _BaldesPageState();
}

class _BaldesPageState extends State<BaldesPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: buildPages(),
  );

  Widget buildPages() {
    switch (index) {
      case 0:
        return const DraggableBasicPage();
      default:
        return Container();
    }
  }
}

class DraggableBasicPage extends StatefulWidget {
  const DraggableBasicPage({super.key});

  @override
  State<DraggableBasicPage> createState() => _DraggableBasicPageState();
}

class _DraggableBasicPageState extends State<DraggableBasicPage> {
  List<Imagens> all = allImagens;
  int score = 0;
  String acerto = "";
  List<Imagens> currentImages = allImagens;
  @override
  void initState() {
    super.initState();
    currentImages = List.from(all);
    currentImages.shuffle();
    all.shuffle();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xff0097b2),
    appBar: AppBar(
      title: Text('Pontuação: $score\n      $acerto'),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Animal ou Fruta?',
            style: TextStyle(
              fontFamily: "Chewy",
              fontSize: 45,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..strokeWidth = 1
                ..color = const Color(0xffffffff),
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Color(0xff3e3e3e),
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
          buildOrigin(),
          buildTargets(context),
        ],
      ),
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
            onPressed: () {
              setState(() {
                List<Imagens> allMistura = List.from(currentImages);
                allMistura.shuffle();
                all = allMistura;
                score = 0;
                acerto = "";
              });
            },
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

  Widget buildTargets(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      buildTarget(
        context,
        text: 'Animais',
        acceptType: ImagensType.animal,
        image: "images/balde-animal.png",
      ),
      buildTarget(
        context,
        text: 'Comida',
        acceptType: ImagensType.comida,
        image: "images/balde-fruta.png",
      ),
    ],
  );

  Widget buildOrigin() => Stack(
    alignment: Alignment.center,
    children:
        all.map((imagens) => DraggableWidget(imagens: imagens)).toList(),
  );

  Widget buildTarget(
    BuildContext context, {
    required String text,
    required ImagensType acceptType,
    required String image,
  }) =>

  CircleAvatar(
    backgroundColor: const Color(0xff0097b2),
    radius: 75,
    child: DragTarget<Imagens>(
      builder: (context, candidateData, rejectedData) => Center(
        /*
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        */
        child: Image.asset(image),

        //Image.asset("images/balde-fruta.png"),
      ),
      onWillAccept: (data) => true,
      onAccept: (data) {
        if (data.type == acceptType) {
          setState(() {
            score += 50;
            acerto = "Acertou!";
            all.removeWhere((animal) => animal.imageUrl == data.imageUrl);
          });
        } else {
          setState(() => score -= 20);
          acerto = " Errou!";
        }
      },
    ),
  );
}

class DraggableWidget extends StatelessWidget {
  final Imagens imagens;

  const DraggableWidget({
    Key? key,
    required this.imagens,
  }) : super(key: key);

  static double size = 150;

  @override
  Widget build(BuildContext context) => Draggable<Imagens>(
    data: imagens,
    feedback: buildImage(),
    childWhenDragging: Container(height: size),
    child: buildImage(),
  );

  Widget buildBox() => Container(
    height: 200,
    width: 200,
    decoration: const BoxDecoration(
      color: Color(0xffffffff),
      image: DecorationImage(
          image: AssetImage('images/quadrado.png'), fit: BoxFit.fill),
    ),
  );

  Widget buildImage() => Container(
    height: size,
    width: size,
    decoration: const BoxDecoration(
      color: Color(0xff0097b2),
    ),
    child: Image.asset(imagens.imageUrl),
  );
}