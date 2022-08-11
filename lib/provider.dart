import 'package:flutter/material.dart';

import 'game_logic.dart';

class MyProvider with ChangeNotifier{
  bool isSwitched=false;
  String activePlayer="X";
  bool gameOver=false;
  int turn=0;
  String result='';
  Game game =Game();

  changeSwitch(val){
    isSwitched=val;
    notifyListeners();
  }
  repeatTheGame(){
    activePlayer='X';
    gameOver=false;
    turn=0;
    result='';
    Player.playerX=[];
    Player.playerO=[];
    notifyListeners();
  }

  void activePlayer1(){
    activePlayer=activePlayer=='X'?'O':'X';
    turn++;
    String winnerPlayer=game.checkWinner();
    if(winnerPlayer!=''){
      gameOver=true;
      result="$winnerPlayer is the winner";
    }
    else if(!gameOver&&turn==9){
      result ="It's Draw !";
    }
    notifyListeners();
  }
  onTap1(index)async{
    if((Player.playerX.isEmpty||!Player.playerX.contains(index))&&(
    Player.playerO.isEmpty||!Player.playerO.contains(index)
    )){
      game.playGame(index, activePlayer);
      activePlayer1();
      if(!isSwitched&&!gameOver&&turn!=9){
        await game.autoPlay(activePlayer);
        activePlayer1();
      }
    }
    notifyListeners();
  }
}