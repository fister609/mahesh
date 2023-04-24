

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fister/Authentication/StorageMethods.dart';

class AuthMethods{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> RegisterWithEmailAndPassword(String Name, String Email, String Password,Uint8List File)async{
    String ref =  "Errror";
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
      String Profile =await  StorageMethods().StoreImage(Name,File, true);
      _firestore.collection("users").doc(user.user!.uid).set({
        "Name": Name,
        "Email": Email,
        "Password": Password,
        "Profile url": Profile
      });
      ref = "success";
    }on FirebaseAuthException catch(e){
      return e.message!;
      }
      return ref;
  }


  Future<String> LoginWithEmailAndPassword(String email, String password)async{
    String ref = "error";
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      ref = "success";

    }on FirebaseAuthException catch(e){
      return e.message!;
    }
    return ref;
  }


}
