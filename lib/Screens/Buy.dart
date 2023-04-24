
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Uint8List? image;
  List url = [];
  List Name = [];
  List Price = [];
  List users = [];

  getusers()async{
    CollectionReference ref = await FirebaseFirestore.instance.collection("users");
    QuerySnapshot snap =await ref.get();
    users = snap.docs.map((e) => (e.data() as Map<String, dynamic>)['uid']).toList();
    print("Users: $users");
  }


  getdata()async{
    getusers();
    for(int i =0; i<users.length; i++) {
      CollectionReference ref = FirebaseFirestore.instance.collection('users')
          .doc(users[0])
          .collection("Products");
      QuerySnapshot snap = await ref.get();

      url = snap.docs.map((doc) =>
      (doc.data() as Map<String,
          dynamic>)['Image']).toList();
      Name = snap.docs.map((e) => (e.data() as Map<String, dynamic>)['Name'])
          .toList();
      Price = snap.docs.map((e) => (e.data() as Map<String, dynamic>)['Price'])
              .toList();

    }

  }

  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      body: SafeArea(
        child: Container(
            child:Center(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: Name.length,
                  itemBuilder: (context, index){
                    getdata();
                    return Image.network(url.elementAt(index));

                  }
                ),

            )
        ),
      ),
    );
  }
}
