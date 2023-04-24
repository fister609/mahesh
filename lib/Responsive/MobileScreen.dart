import 'package:fister/Screens/BuySell.dart';
import 'package:fister/Screens/HomeScreen.dart';
import 'package:fister/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../Screens/RegisterScreen.dart';
import '../Screens/Sidebar.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Fister"),
      ),
      body: PageView(
        children: [
          Home(),
          BuySell(),
          Register()
        ],
        controller: controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home",backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.chrome_reader_mode), label:"Study"),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_outlined), label:"Buy/Sell"),
        ],
        onTap: (val){
          setState(() {
            index = val;
            controller.jumpToPage(index);
          });
        },
      ),
    );
  }
}
