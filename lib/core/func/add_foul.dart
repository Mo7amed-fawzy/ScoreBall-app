library game_utils;

import 'package:flutter/material.dart';

void addFoul({
  required String team,
  required void Function(VoidCallback fn) setState,
  required void Function(int) updateFoulsA,
  required void Function(int) updateFoulsB,
  required void Function(String) addToHistory,
  required int foulsA,
  required int foulsB,
}) {
  setState(() {
    if (team == 'A') {
      updateFoulsA(foulsA + 1);
    } else {
      updateFoulsB(foulsB + 1);
    }
    final now = DateTime.now();
    addToHistory(
      "[${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}] "
      "Team $team Foul → $foulsA - $foulsB",
    );
  });
}
