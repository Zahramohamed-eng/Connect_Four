import 'package:flutter/material.dart';
import 'main.dart';
import'dart:math';

bool CheckWinAI(List<List<int>>board,int player) {
  for (int row = 0; row < 5; row++) {
    for (int col = 0; col < 3; col++) {
      if(board[row][col]==player
          &&board[row][col+1]==player
          &&board[row][col+2]==player&&
          board[row][col+3]==player )
        {
          return true;
        }
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 7; col++) {
          if (board[row][col] == player && board[row + 1][col] == player &&
              board[row + 2][col] == player && board[row + 3][col] == player) {
            return true;
          }
        }}

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

          }}}

    }


    }
  return false;
  }

  bool IsFull(List<List<int>>board) //terminal state
  {
    for(int col=0;col<7;col++)
      {
        if (board[0][col]==0)
          {
            return false;

      }}
    return  true;
  }

  int get_Drop_row (List<List<int>>board,col)
  {
    for(int row=5;row>=0;row--)
      {
        if (board[row][col]==0)
          {
            return row;
          }

      }



    return -1;


  }

  List<int> get_moves_AI(List<List<int>>board)
  {
    List<int> moves =[];
    for(int col=0;col<7;col++)
      {
        if (board[0][col]==0)
          {
            moves.add( col);
          }
      }
    return moves;
  }

   int mini_max(List<List<int>>board,int depth,bool IsMax)            //   note:      is max هنا هعملها للاتنين  لو الai هترجع ترو لو ال playerتبقي ترجع فولس وتبقي ال ةهى
   {
     if(CheckWinAI(board,2))
       {
         return 1;
       }

     if(CheckWinAI(board,1))
     {
       return -1;
     }
     if (IsFull(board))
       {
         return 0;
       }

     if (depth==0)
       {
         return 0;
       }
     if(IsMax) {
       int bestscore = -100;
       for (int col in get_moves_AI(board)) {
         int row = get_Drop_row(board, col);
         board[row][col] = 2;
         int score = mini_max(board, depth - 1, false);
         board[row][col] = 0;
         if (score > bestscore) {
           bestscore = score;

         }}return bestscore;}
         else {
           int bestscore = 100;
           for (int col in get_moves_AI(board)) {
             int row = get_Drop_row(board, col);
             board[row][col] = 1;
             int score = mini_max(board, depth - 1, true);
             board[row][col] = 0;
             if (score < bestscore) {
               bestscore = score;
             }
           }
           return bestscore;
         }
       }


        int best_move(List<List<int>>board)
        {
          int bestscore=-100;
          List<int> bestMoves=[];
          
          for(int col in get_moves_AI(board))
            {
              int row=get_Drop_row(board, col);
              board[row][col]=2;
              int score =mini_max(board,  3,  false);
              board[row][col]=0;
              if(score>bestscore)
                {
                  bestscore=score;
                  bestMoves=[col];
                   
                }else if (score ==bestscore)
                  {
                    bestMoves.add(col);
                  }
            }
          return  bestMoves[Random().nextInt( bestMoves.length)];
        }