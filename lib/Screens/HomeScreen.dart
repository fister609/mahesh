import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fister/Screens/rivision.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CollectionReference ref = FirebaseFirestore.instance.collection("users");
   List users = [];
  getdata()async{
    QuerySnapshot snap =await ref.get();
    users = snap.docs.map((e) => (e.data() as Map<String, dynamic>)['uid']).toList();
    print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Rivision()));
        },
        child: Text("DATA"),
      )),
    );
  }
}
