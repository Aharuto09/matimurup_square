import 'package:flutter/material.dart';
import 'package:matimurup_square/entity/playerEntity.dart';
import 'package:matimurup_square/page/scorePage.dart';
import 'package:matimurup_square/widget/button.dart';

import 'firstGame.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key, required this.player});
  playerEntity player;

  @override
  Widget build(BuildContext context) {
    String title = "";
    if (player.history.last[player.player1] ==
        player.history.last[player.player2]) {
      title = "SEIMBANG";
    } else {
      title = player.history.last.keys.firstWhere(
          (element) => player.history.last[element] == true,
          orElse: () => "");
      title = title.toUpperCase() + " MENANG";
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        width: double.infinity,
        child: Column(children: [
          Text("Hasil Ronde ${player.history.length} (Level: ${player.level})"),
          Text("${player.player1} vs ${player.player2}"),
          Spacer(),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          TButton(
              label: (player.rounde > player.history.length)
                  ? "LANJUT ROUNDE ${player.history.length + 1}"
                  : "SELESAI",
              onPressed: () {
                if (player.rounde > player.history.length) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirtsGame(
                                player: player,
                              )));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScorePage(
                                player: player,
                              )));
                }
              })
        ]),
      ),
    );
  }
}
