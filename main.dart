import 'package:flutter/material.dart';
//import 'dart:math';
import 'Mini_max.dart';

void main ()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  final int col=7;
  final int rol=6;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:ConnectFour()
    );
  }

}

class ConnectFour extends StatefulWidget {
  const ConnectFour({super.key});

  @override
  State<ConnectFour> createState() => ConnectFour_State();
}
class ConnectFour_State extends State<ConnectFour>
{
  bool vsAI=false;
  bool game_over=false;
  Color board_color=Colors.blue.shade400;
  @override
  List<List<int>>board=
  [
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
  ];
  int current_player=1;
  String status="Player 1 Turn";




  bool drop_piece (int col)
  {
    for(int row=5;row>=0;row--)
    {
      if(board[row][col]==0)
      {
        board[row][col]=current_player;
        return true;
      }
    }return false;
  }





  void move_handle(int col)
  { if(game_over==true){return;}

  if (vsAI==true&& current_player==2){
    return;
  }
  bool move =drop_piece(col);
  if (move==false)
  {
    return;
  }

  setState(() {
    if(check_win(current_player)) {
      status =vsAI? " Player Wins🥳":"Player $current_player Wins🥳";
      game_over = true;
    }else{
      if (vsAI == true) {
        current_player = 2;
        status = "AI Thinking...";
      }
      else {
        if (current_player == 1) {
          current_player = 2;
          status = vsAI?"AI Turn":"Player 2 Turn";
        } else {
          current_player = 1;
          status =   status = vsAI?" Player Turn":"Player $current_player Turn";
        }}
    }
  });
  if(vsAI==true && game_over==false)
  {
    Future.delayed( Duration(milliseconds:500),()
    {

      Ai_move();
    }


    );

  }

  }






  void Ai_move()
  { if(game_over==true)
  {
    return;
  }
  int ai_col=best_move(board);
  if(ai_col==-1)
  {
    return;
  }
  current_player=2;
  bool move =drop_piece( ai_col);
  if(move== false) {return;}
  setState(() {
    if(check_win( 2)){
      status= "AI Wins 🧠";
      game_over=true;}
    else
    {
      current_player=1;
      status="Player Turn";}});

  }





  void resetGame()
  {
    board=[
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0],

    ];
    setState(() {
      current_player=1;
      status=vsAI?"Player Turn":"Player 1 Turn";
      game_over=false;
    });
  }

  Color getcolor(int value)
  {
    if( value==0)
    {
      return Colors.white;
    }
    else if(value == 1)
    {
      return Colors.redAccent;
    }
    else
    {
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
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              width: double.infinity,
              height: 270,
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              margin: EdgeInsets.only(
                  top: 50, left: 12, right: 12, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blueGrey[900],
              ),
              child: Column(
                children: [
                  Text("Connect Four🤯", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.white, blurRadius: 16)
                      ]), textAlign: TextAlign.center,),
                  SizedBox(height: 7,),
                  Text(status,
                    style: TextStyle(fontSize: 17, color: Colors.white60,),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: ElevatedButton(onPressed: () {


                          setState(() {
                            board_color=Colors.green.shade500;
                            vsAI=false;
                            resetGame();
                          });
                        }  ,
                          child: Text("2 Players 🎮", style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, shadows: [
                            Shadow(color: Colors.white, blurRadius: 5)])),
                          style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 17),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                                , side: BorderSide(color: Colors.white38),)
                          ),




                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(onPressed: () {

                          setState(() {
                            board_color=Colors.blue.shade400;
                            vsAI=true;
                            resetGame();
                          });


                        },
                          child: Text("Play Vs AI 🤖", style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, shadows: [
                            Shadow(color: Colors.white, blurRadius: 5)]),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent[400],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 17),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                                , side: BorderSide(color: Colors.white38),)
                          ),),

                      ),


                    ],)
                  , SizedBox(height: 12,)
                  , ElevatedButton(onPressed: () {
                    resetGame();
                  },
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, size: 20,),
                          SizedBox(width: 10,),
                          Text("Reset", style: TextStyle(fontSize: 15, shadows: [
                            Shadow(color: Colors.white, blurRadius: 5)]))
                        ]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[900],
                      foregroundColor: Colors.white,
                      shadowColor: Colors.white60,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white60)),

                    ),),

                  Row(children: [
                  ],


                  )


                ],
              ),


            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    children: [
                      SizedBox(width: 40,),
                      Container(
                        width: 20,
                        height: 20,
                        decoration:
                        BoxDecoration(color: Colors.redAccent,
                          shape: BoxShape.circle,
                        )
                        ,
                      )
                      ,
                      SizedBox(width: 6,)
                      ,
                      Text( vsAI?"Player":"Player 1  ", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ),
                ),
                SizedBox(width: 40,),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration:
                      BoxDecoration(color: Colors.yellowAccent,
                        shape: BoxShape.circle,
                      )
                      ,
                    )
                    ,
                    SizedBox(width: 6,)
                    ,
                    Text(vsAI?"AI":"Player 2", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18))
                  ],
                )

                , SizedBox(width: 30,)


              ],)

            , Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20, right: 20),
                child: Row(


                  children: [
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(0);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,)

                    , Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(1);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,),
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(2);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[900],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,),
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(3);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,),
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(4);

                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,),
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(5);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )
                    , SizedBox(width: 6,),
                    Expanded(child:
                    ElevatedButton(onPressed: () {
                      move_handle(6);
                    }, child: Icon(Icons.arrow_downward_outlined,
                      size: 25,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10)
                    ),)
                      ,

                    )


                  ],

                ),
              ),
            ),
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 5),
              child: AspectRatio(
                aspectRatio: .9,
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                  padding: EdgeInsets.only(left: 6, right: 6),
                  decoration: BoxDecoration(
                    color: board_color,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 8),
                    ],
                  ),
                  child: GridView.count(
                    // shrinkWrap: false,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: .78,
                    crossAxisCount: 7,
                    crossAxisSpacing: 6,

                    children: List.generate(42, (index) {
                      int row = index ~/ 7;
                      int col = index % 7;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.5),
                        padding: EdgeInsets.only(left: 15, right: 20),
                        decoration: BoxDecoration(
                            color: getcolor(board[row][col]),


                            shape: BoxShape.circle
                        ),
                      );
                    }),


                  ),

                ),
              ),
            )
          ],

        )


    );
  }
}