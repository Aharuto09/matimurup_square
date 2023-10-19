import 'package:flutter/material.dart';
import 'package:matimurup_square/entity/playerEntity.dart';
import 'package:matimurup_square/page/firstGame.dart';
import 'package:matimurup_square/widget/button.dart';
import 'package:matimurup_square/widget/dialog.dart';
import 'package:matimurup_square/widget/field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController ftPerson = TextEditingController();
    TextEditingController scdPerson = TextEditingController();
    TextEditingController ronde = TextEditingController();
    ronde.text = "1";
    String selectedLvl = "Gampang";
    late playerEntity player;

    void getDialog() {
      showDialog(
          context: context,
          builder: (context) => TDialog(
              title: "Peringatan",
              body:
                  "Mohon isi semua kolom dan pastikan ronde tidak lebih dari 10",
              button: "OK"));
    }

    Future<Map<String, String>> getPlayer() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString("player1")!.isNotEmpty &&
          pref.getString("player2")!.isNotEmpty) {
        return {
          "player1": pref.getString("player1").toString(),
          "player2": pref.getString("player2").toString()
        };
      } else {
        return {};
      }
    }

    Future<void> addPlayer(String player1, String player2) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("player1", player1);
      pref.setString("player2", player2);
    }

    return Scaffold(
      body: FutureBuilder(
          future: getPlayer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                ftPerson.text = snapshot.data!["player1"].toString();
                scdPerson.text = snapshot.data!["player2"].toString();
              }
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Setup Permainan",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 40),
                    TField(
                      controller: ftPerson,
                      label: "Nama Pemain #1",
                    ),
                    TField(
                      controller: scdPerson,
                      label: "Nama Pemain #2",
                    ),
                    TField(
                      controller: ronde,
                      label: "Jumlah Ronde",
                      inputNum: true,
                    ),
                    DropdownButtonFormField(
                      itemHeight: 50,
                      hint: const Text("Tingkat Kesulitan"),
                      value: selectedLvl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.deepPurple.withOpacity(0.2)),
                      elevation: 2,
                      isExpanded: false,
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      items: const [
                        DropdownMenuItem(
                          value: "Gampang",
                          child: Text("Gampang"),
                        ),
                        DropdownMenuItem(
                          value: "Sedang",
                          child: Text("Sedang"),
                        ),
                        DropdownMenuItem(
                          value: "Susah",
                          child: Text("Susah"),
                        ),
                      ],
                      onChanged: (value) {
                        selectedLvl = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
                    TButton(
                      label: "MULAI",
                      onPressed: () {
                        try {
                          if (ftPerson.value.text.isNotEmpty &&
                              scdPerson.value.text.isNotEmpty &&
                              ronde.value.text.isNotEmpty &&
                              selectedLvl.isNotEmpty) {
                            if (int.parse(ronde.value.text) <= 10 &&
                                int.parse(ronde.value.text) > 0) {
                              player = playerEntity(
                                  ftPerson.text,
                                  scdPerson.text,
                                  int.parse(ronde.value.text),
                                  selectedLvl);
                              addPlayer(ftPerson.text, scdPerson.text)
                                  .whenComplete(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FirtsGame(
                                                player: player,
                                              ))));
                            } else {
                              return Exception();
                            }
                          } else {
                            return Exception();
                          }
                        } catch (e) {
                          getDialog();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
