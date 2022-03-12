import 'dart:async';

import 'package:flappy_bird/barirers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted= false;
      time = 0;
      initialHeight = birdYaxis;
    });
  }
  void _showDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),

          ],
        );
      }
    );

  }
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });

  }

  /*void _showDialog() {
    showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
      title: Text("Accept?")
        content: Text(""),
      )
    }
    ),}*/

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      if(birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
      setState(() {
        birdYaxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      time += 0.01;
    });
  }
  bool birdIsDead(){
   // if(MyBarriers().size < birdYaxis || MyBarriers().size > birdYaxis){
     // return false;
   // }
    if(birdYaxis < -1 || birdYaxis > 1){
      return true;
    }
    else {
      return false;
    }


  }
  @override
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3, //mavi rengi  oranladı
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0,
                        birdYaxis), //virgülün solu left right ayarı(-1) olunca left yapışık
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 180.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 200.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Best',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '10',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


