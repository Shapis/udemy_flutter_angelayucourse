import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(
      MaterialApp(
        home: BackGround(),
      ),
    );

class BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Ask me anything'),
        backgroundColor: Colors.blue[900],
      ),
      body: MagicBall(),
    );
  }
}

class MagicBall extends StatefulWidget {
  @override
  _MagicBallState createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  int magicBallState = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          setState(() {
            int temp = 0;
            int count = 0; // Just in case, so it never gets stuck in the loop.
            while (temp == magicBallState || temp == 0 || count > 10) {
              temp = Random().nextInt(5) + 1;
              count++;
            }
            magicBallState = temp;
          });
        },
        child: Image.asset('images/ball$magicBallState.png'),
      ),
    );
  }
}
