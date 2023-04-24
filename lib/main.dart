import 'package:firebase_auth/firebase_auth.dart';
import 'package:fister/Responsive/responsive.dart';
import 'package:fister/Screens/HomeScreen.dart';
import 'package:fister/Screens/LoginScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC_jAFEYKjFMlVkOToUm-66AiNFc7jy_Jc",
          appId:"1:588795725751:web:635ccfa2cd281b461bca32"  ,
          messagingSenderId: "588795725751",
          projectId: "fister-14c86")
    );
  }
  else{
  await Firebase.initializeApp();
  }
  runApp(const MyApp());
}
FirebaseAuth auth = FirebaseAuth.instance;
final user = auth.currentUser;

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,

        home: user!= null?
            Responsive():
            Login()
    );
  }
}

