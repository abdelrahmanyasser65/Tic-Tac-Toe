import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xo/game_logic.dart';
import 'package:xo/provider.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>MyProvider(),
      builder: (ctx,_){
        var provider=Provider.of<MyProvider>(ctx);
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: MediaQuery.of(context).orientation==
                Orientation.portrait?
            Column(
              children: [
                ...firstBlock(provider),
                const SizedBox(height: 30,),
                centerBlock(provider, context),
               ...lastBlock(provider, context),
                const SizedBox(height: 45,),


              ],
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...firstBlock(provider),
                    ...lastBlock(provider, context)
                  ],
                )),
                centerBlock(provider, context),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget>firstBlock(MyProvider provider){
    return [
      Padding(
        padding:const EdgeInsets.only(
          top: 40,left: 10,right: 10,bottom: 15
        ),
        child:SwitchListTile.adaptive(
          title:const Text("Turn on/off two player",style:
            TextStyle(
              fontSize: 24,fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),),
            value: provider.isSwitched,
            onChanged: (val)=>provider.changeSwitch(val)) ,
      ),
     const SizedBox(height: 20,),
      provider.result.isEmpty?
          Text(
            "It's ${provider.activePlayer} turn ",style:
           const TextStyle(
              color: Colors.white,
              fontStyle:FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 55
            ),
          ):const Text(
        ''
      ),
    ];
  }
  Expanded centerBlock(MyProvider provider, context){
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
        childAspectRatio: 1,
        children: List.generate(9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: provider.gameOver?null:
                  ()=>provider.onTap1(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                      Player.playerX.contains(index)?
                          'X':Player.playerO.contains(index)?
                          "O":'',style: TextStyle(
                        fontSize: 50,
                        color: Player.playerX.contains(index)?
                            Colors.blue:Colors.pink,
                      ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
  List<Widget>lastBlock(MyProvider provider,context){
    return[
      Text(provider.result,style:
       const TextStyle(
          color: Colors.white,
          fontSize: 35
        ),textAlign: TextAlign.center,),
      const SizedBox(height: 40,),
      ElevatedButton.icon(
        label:const Text('Repeat the game',style:
          TextStyle(
            fontSize: 18,fontWeight: FontWeight.bold
          ),),
        icon:const Icon(Icons.replay),
        onPressed: ()=>provider.repeatTheGame(),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).splashColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

        ),
         )
    ];
  }
}
