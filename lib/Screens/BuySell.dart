import 'package:flutter/material.dart';
import 'Buy.dart';
import 'Sell.dart';


class BuySell extends StatefulWidget {
  const BuySell({Key? key}) : super(key: key);

  @override
  State<BuySell> createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "Sell",
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Buy()));
            },
            child: Text("Buy") ,),
            SizedBox(width: 40,),
            FloatingActionButton(
              heroTag:"buy",
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Sell()));
            },
            child:Text("Sell"),)

          ],
        ),
      ),
    );
  }
}
