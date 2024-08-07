import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late double horizontalDragValue = 0.0;
  late double localPosX = 0.0;

  bool getIsDraggedOver(int index, double tileSize, double horizontalValue, double localX) {
    late bool res = false;
    double lowBound = index*(tileSize+5);
    double upBound = 4*(tileSize+5);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Container(
              width: 220,
              height: 150,
              // color: Colors.green,
              child: GestureDetector(
                onHorizontalDragStart: (details) {

                },
                onHorizontalDragUpdate: (details) {
                  if (horizontalDragValue >= 0) {
                    setState(() {
                      horizontalDragValue = horizontalDragValue + details.delta.dx;
                      localPosX = localPosX + details.localPosition.dx;
                    });
                  }
                },

                onHorizontalDragEnd: (details) {
                  setState(() {
                    horizontalDragValue = 0.0;
                  });
                },
                child: Row(
                  children: [

                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}