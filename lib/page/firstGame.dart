import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matimurup_square/entity/data.dart';
import 'package:matimurup_square/entity/playerEntity.dart';
import 'package:matimurup_square/page/secondGame.dart';
import 'package:matimurup_square/widget/dialog.dart';

class FirtsGame extends StatefulWidget {
  FirtsGame({super.key, required this.player});
  playerEntity player;
  @override
  State<FirtsGame> createState() => _FirtsGameState();
}

class _FirtsGameState extends State<FirtsGame> {
  bool start = false, disableButton = true;
  int clueBox = 0, level = 1;
  List<int> key = [];
  List<int> answer = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1600), () {
      _play();
    }).whenComplete(() {
      timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
        if (start) {
          _getRandom();
          Future.delayed(Duration(milliseconds: 300), () {
            _toZero();
          });
        }
      });
      Future.delayed(
          Duration(milliseconds: (740 * stringLevel[widget.player.level]! - 1)),
          () {
        disableButton = false;
      }).whenComplete(() {
        Future.delayed(Duration(milliseconds: 300), () {
          _stop();
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void _getRandom() {
    setState(() {
      clueBox = Random().nextInt(8) + 1;
      if (key.length < stringLevel[widget.player.level]!) {
        key.add(clueBox);
      }
    });
  }

  void _play() {
    setState(() {
      start = true;
      disableButton = true;
      _getRandom();
    });
  }

  void _toZero() {
    setState(() {
      clueBox = 0;
    });
  }

  void _stop() {
    setState(() {
      start = false;
      clueBox = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthP = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.player.player1),
            Text(
              "Tekan Tombol Sesuai Urutan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 50),
            SizedBox.square(
              dimension: widthP,
              child: Container(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (int i = 1; i <= 9; i++)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: (widthP / 3) - 10,
                          height: (widthP / 3) - 10,
                          color: (clueBox == i)
                              ? Colors.deepPurple
                              : Colors.black12,
                          child: InkWell(
                            splashColor: Colors.deepPurple,
                            focusColor: Colors.deepPurple,
                            onTap: disableButton
                                ? null
                                : () {
                                    answer.add(i);

                                    if (answer.length ==
                                        stringLevel[widget.player.level]!) {
                                      if (listEquals(
                                          key,
                                          answer.sublist(
                                              0,
                                              stringLevel[
                                                  widget.player.level]!))) {
                                        widget.player.history
                                            .add({widget.player.player1: true});
                                        // widget.player.history.elementAt(0).addAll({"ma":false});
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => GDialog(
                                                title: "Urutan Benar",
                                                body:
                                                    "Selamat ${widget.player.player1}, kamu menekan urutan yang benar"));
                                      } else {
                                        widget.player.history.add(
                                            {widget.player.player1: false});
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => GDialog(
                                                title: "Urutan Salah",
                                                body:
                                                    "Sayang sekali ${widget.player.player1}, kamu menekan urutan yang salah"));
                                      }
                                      Future.delayed(Duration(seconds: 3),
                                              () => Navigator.pop(context))
                                          .whenComplete(() =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SecondGame(
                                                            player:
                                                                widget.player,
                                                          ))));
                                    }
                                  },
                            // child: Text("$i")
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Text("Ronde : " + (widget.player.history.length + 1).toString()),
            Text("Level : " + widget.player.level)
          ],
        ),
      ),
    );
  }
}
