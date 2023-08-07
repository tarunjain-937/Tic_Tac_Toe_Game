import 'package:flutter/material.dart';

class GamePad extends StatefulWidget {
  const GamePad({Key? key}) : super(key: key);

  @override
  State<GamePad> createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> {
  int playerX_Score=0;
  int playerO_Score=0;
  int filledBoxes=0;
  String playerTurn="O";
  bool oTurn =true;//first player is "o"
List<String> displayXorO=["","","","","","","","",""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5,
        title: Text("Tic Tac Toe", style: TextStyle(fontSize: 38,color: Colors.redAccent,fontWeight: FontWeight.bold),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Score Board",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
            Container(
              color: Colors.yellow,
              height: 80, width: double.infinity,
            child:Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Player X",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
                      SizedBox(height: 6),
                      Text(playerX_Score.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Player O",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
                      SizedBox(height: 6),
                      Text(playerO_Score.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                    ],
                  )
                ],
              ),
            ),
            ),
            SizedBox(height: 15,),
            Text("Player $playerTurn's Turn",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        tapped(index);
                      },
                      child: Container(
                        height: 100, width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          border: Border.all(color: Colors.white)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Center(child: Text(displayXorO[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),)),
                        ),
                      ),
                    );
                  },),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              resetGame();
            }, child: Text("Reset Game",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void tapped(int index){
    setState(() {
     if(oTurn && displayXorO[index]==""){
       displayXorO[index] = "O";
       filledBoxes++;
       playerTurn="X";
     }
     else if(!oTurn && displayXorO[index]==""){
       displayXorO[index] = "X";
       filledBoxes++;
     playerTurn="O";}
     oTurn=!oTurn;// second player is "X"
      checkWinner();
    });
  }

  void checkWinner(){
    // check row 1
    if(displayXorO[0] == displayXorO[1] && displayXorO[0]==displayXorO[2] && displayXorO[0]!=""){ showWinDialog(displayXorO[0].toString());}
    // check row 2
    if(displayXorO[3] == displayXorO[4] && displayXorO[3]==displayXorO[5] && displayXorO[3]!=""){ showWinDialog(displayXorO[3].toString());}
    //check row 3
    if(displayXorO[6] == displayXorO[7] && displayXorO[6]==displayXorO[8] && displayXorO[6]!=""){ showWinDialog(displayXorO[6].toString());}
    //check column 1
    if(displayXorO[0] == displayXorO[3] && displayXorO[0]==displayXorO[6] && displayXorO[0]!=""){ showWinDialog(displayXorO[0].toString());}
    //check column 2
    if(displayXorO[1] == displayXorO[4] && displayXorO[1]==displayXorO[7] && displayXorO[1]!=""){ showWinDialog(displayXorO[1].toString());}
    //check column 3
    if(displayXorO[2] == displayXorO[5] && displayXorO[2]==displayXorO[8] && displayXorO[2]!=""){ showWinDialog(displayXorO[2].toString());}
    //check Right Diagonal
    if(displayXorO[0] == displayXorO[4] && displayXorO[0]==displayXorO[8] && displayXorO[0]!=""){ showWinDialog(displayXorO[0].toString());}
    //check Left Diagonal
    if(displayXorO[2] == displayXorO[4] && displayXorO[2]==displayXorO[6] && displayXorO[2]!=""){ showWinDialog(displayXorO[2].toString());}

    else if(filledBoxes==9){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Draw Game",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              actions: [
                TextButton(onPressed:(){
                  clearBoard();
                  Navigator.pop(context);
                }, child:Text("Play again",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),

                TextButton(onPressed:(){
                  resetGame();
                  Navigator.pop(context);
                }, child:Text("Reset",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),
              ],
            );
          });}
  }


  void showWinDialog(String winner){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Winner is : $winner",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            actions: [
              TextButton(onPressed:(){
                clearBoard();
                Navigator.pop(context);
              }, child:Text("Play again",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),

              TextButton(onPressed:(){
                resetGame();
                Navigator.pop(context);
              }, child:Text("Reset",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),
            ],
          );
        });

    if(winner=="O"){
      setState(() {
        playerO_Score++;
      });
    }else{
      setState(() {
        playerX_Score++;
      });
    }
  }

  void clearBoard() {
    setState(() {
      for(int i = 0; i < 9; i++)
        displayXorO[i] = "";
      playerTurn="O";
    });
    oTurn=true;// o's turn
    filledBoxes=0;
  }

  void resetGame(){
    setState(() {
      playerX_Score=0;
      playerO_Score=0;
      clearBoard();
      playerTurn="O";
    });
    oTurn=true;// o's turn
    filledBoxes=0;
  }

}
