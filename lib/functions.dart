import 'package:flutter/material.dart';
import 'main.dart';
class ConnectFour_State2 extends State<ConnectFour> {

  @override
  bool vsAI = false;
  bool game_over = false;
  Color board_color = Colors.blue.shade400;
  List<List<int>>board =
  [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
  ];
  int current_player = 1;
  String status = "Player 1 Turn";

  bool drop_piece(int col) {
    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == 0) {
        board[row][col] = current_player;
        return true;
      }
    }
    return false;
  }

  void move_handle(int col) {
    if (game_over == true) {
      return;
    }
    bool move = drop_piece(col);
    if (move == true) {
      setState(() {
        if (check_win(current_player)) {
          status = "Player $current_player Wins🥳";
          game_over = true;
        } else {
          if (current_player == 1) {
            current_player = 2;
            status = "Player 1 Turn";
          } else {
            current_player = 1;
            status = "Player 2 Turn";
          }
        }
      });
    }
  }

  void resetGame() {
    board = [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],

    ];
    setState(() {
      current_player = 1;
      status = "Player 1 Turn";
      game_over = false;
    });
  }

  Color getcolor(int value) {
    if (value == 0) {
      return Colors.white;
    }
    else if (value == 1) {
      return Colors.redAccent;
    }
    else {
      return Colors.yellowAccent;
    }
  }

  bool check_win(int player) {
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        if (board[row][col] == player && board[row][col + 1] == player &&
            board[row][col + 2] == player && board[row][col + 3] == player) {
          return true;
        }
      }
    }

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 7; col++) {
        if (board[row][col] == player && board[row + 1][col] == player &&
            board[row + 2][col] == player && board[row + 3][col] == player) {
          return true;
        }
      }
    }

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 4; col++) {
        if (board[row][col] == player && board[row + 1][col + 1] == player &&
            board[row + 2][col + 2] == player &&
            board[row + 3][col + 3] == player) {
          return true;
        }
      }
    }


    for (int row = 0; row < 3; row++) {
      for (int col = 3; col < 7; col++) {
        if (board[row][col] == player && board[row + 1][col - 1] == player &&
            board[row + 2][col - 2] == player &&
            board[row + 3][col - 3] == player) {
          return true;
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      throw UnimplementedError();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}