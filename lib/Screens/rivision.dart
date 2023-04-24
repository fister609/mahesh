import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Rivision extends StatefulWidget {
  const Rivision({Key? key}) : super(key: key);

  @override
  State<Rivision> createState() => _RivisionState();
}

class _RivisionState extends State<Rivision> {
  List user = [];
  List urls = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getusers()async{
    CollectionReference ref = await FirebaseFirestore.instance.collection("users");
    QuerySnapshot snap =await ref.get();
    setState(() {
      user = snap.docs.map((e) => (e.data() as Map<String, dynamic>)['uid']).toList();
      print(user);
    });
  }
  getdata()async{
    getusers();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          getdata();
        },
        child: Text("Data"),),
      ),
    );
  }
}
