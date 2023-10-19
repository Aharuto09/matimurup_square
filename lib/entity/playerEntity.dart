class playerEntity {
  late String player1;
  late String player2;
  late int rounde;
  late String level;
  late List<Map<String, bool>> history = [];
  playerEntity(String ply1, String ply2, int rnd, String lvl) {
    this.player1 = ply1;
    this.player2 = ply2;
    this.rounde = rnd;
    this.level = lvl;
  }
}
