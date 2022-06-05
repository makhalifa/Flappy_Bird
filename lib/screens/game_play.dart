import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bird_game/models/bird_flying.dart';
import 'package:bird_game/models/bird_dead.dart';
import 'package:bird_game/models/decorated_text_2.dart';
import 'package:bird_game/models/decoreted_text.dart';
import 'package:bird_game/models/get_ready.dart';
import 'package:bird_game/models/pipe.dart';
import 'package:flutter/material.dart';

import '../models/ground.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  static int gameScore = 0;
  static int bestScore = 0;
  List<bool> pipeIsNew = [true, true];

  final audioPlayer = AudioCache();

  // bird setting
  static double birdY = 0;
  double birdWidth = 0.2;
  double birdHeight = 0.1;
  double alpha = 0;

  // jump setting
  double initPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2.8;

  // game setting
  bool gameHasStarted = false;
  bool gameIsPaused = false;

  // ground setting
  List<double> groundX = [0, 5590];

  // pipes variables
  static List<double> pipeX = [2, 2 + 1.5];
  static double pipeWidth = 0.4; // out of 2
  List<List<double>> pipeHeight = [
    // out of 2, where 2 is the entire heigth of the screen
    // [topHeight,BottomHeight]
    [0.6, 0.4],
    [0.6, 0.4],
  ];

  late Timer timer;

  // TODO Start Game
  void startGame() {
    gameHasStarted = true;
    print("Clicked!");
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // a real physical jump is the same as an upside down parabola
      // so this is a simple quadratic equation
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initPos - height;

        // TODO Moving the Pipe
        pipeX[0] -= 0.009 * 1.5;
        pipeX[1] -= 0.009 * 1.5;

        for (int i = 0; i < pipeX.length; i++) {
          if (pipeX[i] + pipeWidth <= -1) {
            pipeX[i] = 1.5;
            pipeIsNew[i] = true;
            Random random = Random();
            double x = (random.nextInt(6) + 2) / 10;
            print("random number is: $x");
            pipeHeight[i] = [x, 1 - x];
          }
        }

        // TODO  Moving the ground
        groundX[0] -= 26.5 * 1.5;
        groundX[1] -= 26.5 * 1.5;
        // reset the ground
        if (groundX[0] <= -5590) {
          groundX[0] = 5590;
        }
        if (groundX[1] <= -5590) {
          groundX[1] = 5590;
        }

        // Change the alpha
        if (alpha <= 30) {
          if (initPos < height && alpha <= 0) {
            alpha += 1;
            // } else if (initPos == height) {
            //   alpha = 0;
          } else {
            alpha += 0.7;
          }
        }
      });

      // check if bird is dead
      if (birdIsDead()) {
        timer.cancel();
        _gameOver(gameScore.toString(), bestScore.toString());
      }

      // check if bird is passed one pipe
      for (var i = 0; i < pipeX.length; i++) {
        if (birdWidth >= pipeX[i] + pipeWidth && pipeIsNew[i]) {
          pipeIsNew[i] = false;
          gameScore += 1;
          bestScore = max(bestScore, gameScore);

          // audio player
          audioPlayer.play('sounds/sfx_point.wav');
        }
      }

      // keep the time going
      time += 0.008;
    });

    // sound of jump
    audioPlayer.play('sounds/sfx_wing.wav');
  }

  // TODO reset game
  void resetGame() {
    Navigator.pop(context);
    setState(() {
      // reset bird setting
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initPos = birdY;
      alpha = 0;

      gameScore = 0;

      // reset pipe setting
      pipeX = [2, 2 + 1.5];
    });
  }

  // TODO show Game Over
  Future<void> _gameOver(String _gamescore, String _bestscore) async {
    await Future.delayed(const Duration(seconds: 1), () {
      if(bestScore <= gameScore) {
        audioPlayer.play('sounds/elwaddah.mp3');
      }else{
        audioPlayer.play('sounds/sfx_die.wav');
      }
      // audioPlayer.play('sounds/sfx_die.wav');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(children: [
            Container(
              alignment: Alignment(0, -0.35),
              child: Image.asset(
                'assets/images/gameover.png',
                // fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Image.asset(
                'assets/images/score_board.png',
                width: 325,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment(0.5, -0.07),
              child: 
              MyText2(myText: _gamescore, myFontSize: 20)
              // Text(
              //   _gamescore,
              //   // "2",
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
            ),
            Container(
              alignment: Alignment(0.5, 0.1),
              child: 
              MyText2(myText: _bestscore, myFontSize: 20)
              // Text(
              //   _bestscore,
              //   // "2",
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
            ),
            GestureDetector(
              onTap: resetGame,
              child: Container(
                alignment: Alignment(-0.65, 0.5),
                child: Image.asset(
                  'assets/images/ok_btn.png',
                  width: 125,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => print("Clicked!"),
              child: Container(
                alignment: Alignment(0.65, 0.5),
                child: Image.asset(
                  'assets/images/share_btn.png',
                  width: 125,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // AlertDialog(
            //   backgroundColor: Colors.transparent,
            //   title: const Center(
            //       child:
            //       MyText(myText: "GAME OVER", myFontSize: 20)
            //       // Text(
            //       //   "G A M E  O V E R",
            //       //   style: TextStyle(color: Colors.white),
            //       // ),
            //       ),
            //   actions: [
            //     GestureDetector(
            //       onTap: resetGame,
            //       child: ClipRRect(
            //           borderRadius: BorderRadius.circular(5),
            //           child: Container(
            //             padding: const EdgeInsets.all(7),
            //             color: Colors.white,
            //             child: const Text(
            //               'PLAY AGAIN',
            //               style: TextStyle(color: Colors.brown),
            //             ),
            //           )),
            //     )
            //   ],
            // ),
          ]);
        },
      );
    });
  }

  // TODO Jump method
  // Repeat start game
  void jump() {
    audioPlayer.play('sounds/sfx_wing.wav');
    print("Jumping...");
    setState(() {
      time = 0;
      initPos = birdY;
      alpha = -35;
    });
  }

  // TODO Bird is dead
  bool birdIsDead() {
    // check if the bird hitted the top or the bottom of the container
    if (birdY < -1 || birdY > 1) {
      audioPlayer.play('sounds/sfx_hit.wav');
      print("Hit...");
      return true;
    }
    // check if the bird hit the pipe

    // TODO check if bird is within x coordinates and y coordinates of pipe
    for (int i = 0; i < pipeX.length; i++) {
      if (pipeX[i] <= birdWidth / 2 &&
          pipeX[i] + pipeWidth >= -birdWidth / 2 &&
          (birdY <= -1 + pipeHeight[i][0] || birdY >= 1 - pipeHeight[i][1])) {
        audioPlayer.play('sounds/sfx_hit.wav');
        return true;
      }
    }

    return false;
  }

  void _PauseResumeBtn() {
    gameIsPaused = !gameIsPaused;
    print(gameIsPaused);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                      child: Stack(
                    children: [
                      // tap to play
                      GetReady(started: gameHasStarted),

                      // Top pipe 0
                      MyPipe(
                        pipeX: pipeX[0],
                        pipeWidth: pipeWidth,
                        pipeHeight: pipeHeight[0][0],
                        isThisBottomPipe: false,
                      ),

                      // Bottom pipe 0
                      MyPipe(
                        pipeX: pipeX[0],
                        pipeWidth: pipeWidth,
                        pipeHeight: pipeHeight[0][1],
                        isThisBottomPipe: true,
                      ),

                      // Top pipe 1
                      MyPipe(
                        pipeX: pipeX[1],
                        pipeWidth: pipeWidth,
                        pipeHeight: pipeHeight[1][0],
                        isThisBottomPipe: false,
                      ),

                      // Bottom pipe 1
                      MyPipe(
                        pipeX: pipeX[1],
                        pipeWidth: pipeWidth,
                        pipeHeight: pipeHeight[1][1],
                        isThisBottomPipe: true,
                      ),

                      // TODO Bird Animation Flying
                      birdIsDead()
                          ? MyDeadBird(
                              birdY: birdY,
                              birdWidth: birdWidth,
                              birdHeight: birdHeight,
                            )
                          : BirdFlying(
                              birdY: birdY,
                              birdWidth: birdWidth,
                              birdHeight: birdHeight,
                              alpha: alpha,
                            ),

                      // TODO Score
                      Container(
                        alignment: const Alignment(0, -0.85),
                        child: MyText(
                            myText: gameScore.toString(), myFontSize: 50),
                      ),

                      // TODO Pause and Resume button
                      Container(
                        alignment: const Alignment(-0.9, -0.85),
                        child: birdIsDead()
                            ? Text("")
                            : (GestureDetector(
                                onTap: () => _PauseResumeBtn(),
                                child: Container(
                                  width: 35,
                                  child: gameIsPaused
                                      ? Image.asset(
                                          "assets/images/resume_btn.png",
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          "assets/images/pause_btn.png",
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              )),
                      ),
                    ],
                  )),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.brown,
                child: Center(
                  child: Stack(
                    children: [
                      MyGround(groundX: groundX[0]),
                      MyGround(groundX: groundX[1])
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
