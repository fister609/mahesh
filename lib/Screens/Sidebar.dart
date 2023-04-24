import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String email = "";
  String name = "";
  String? profile;
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  getdata()async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      name = (snap.data() as Map<String, dynamic>)['Name'];
      email = (snap.data() as Map<String, dynamic>)['Email'];
      profile = (snap.data() as Map<String, dynamic>)['Profile url'];
    });

  }


  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("$name"),
              accountEmail: Text("$email"),
            currentAccountPicture: profile!= null?
            CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(profile!),
              radius: 80,
            ):
            CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: AssetImage("images/profile.png"),
              radius: 80,
            )
          ),
        ],
      ),
    );
  }
}
