import 'package:flutter/material.dart';
import 'package:matimurup_square/entity/playerEntity.dart';
import 'package:matimurup_square/page/firstGame.dart';
import 'package:matimurup_square/page/setup.dart';
import 'package:matimurup_square/widget/button.dart';

class ScorePage extends StatelessWidget {
  ScorePage({super.key, required this.player});
  playerEntity player;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            Text(
              "Hasil Permainan",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "${player.player1} vs ${player.player2}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 300),
              child: Container(
                // height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 12, color: Colors.black26)
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Colors.black38))),
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Ronde",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text("Hasil",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      ),
                      for (var i = 0; i < player.history.length; i++)
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: (i + 1 < player.history.length)
                                          ? Colors.black26
                                          : Colors.transparent))),
                          child: Row(
                            children: [
                              Container(
                                  width: 100,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("${i + 1}")),
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text((player.history[i]
                                                  [player.player1] ==
                                              player.history[i][player.player2])
                                          ? "Seimbang"
                                          : player.history.last.keys.firstWhere(
                                              (element) =>
                                                  player
                                                      .history.last[element] ==
                                                  true,
                                              orElse: () => "")))),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: TButton(
                        isWhite: true,
                        label: "MAIN LAGI",
                        onPressed: () {
                          player.history.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FirtsGame(player: player)));
                        })),
                SizedBox(width: 10),
                Expanded(
                    child: TButton(
                        label: "MENU UTAMA",
                        onPressed: () {
                          Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetupPage()))
                              .whenComplete(() => null);
                        })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
