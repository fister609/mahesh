
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/Authenticate/LoginScree.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/assets/icon_updated.png');
}

main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: ZoomPageTransitionsBuilder(),}),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Fi-ster Project',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    String? uid;
    uid = FirebaseAuth.instance.currentUser?.uid;

    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Lottie.network('https://assets7.lottiefiles.com/private_files/lf30_nzzpyr6i.json',frameRate: FrameRate(100),delegates: LottieDelegates()),
            Text('Fi-ster',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20))
          ],
        ),
        backgroundColor: Colors.white,
        duration: 2500 ,

        nextScreen: uid!=null?HomePage():LoginScreen(),
        splashIconSize: 300,
        splashTransition: SplashTransition.scaleTransition,
    );
  }
}


