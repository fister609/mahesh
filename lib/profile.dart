import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/Authenticate/AuthMethods.dart';
import 'package:first/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'About.dart';
import 'package:flutter_switch/flutter_switch.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool status = false;
  String name ="";
  String email="";
  String year="";
  String Branch="";
  String ?profile;
  Uint8List? image;

  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  getdata()async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    DocumentSnapshot pro = await FirebaseFirestore.instance.collection("profile").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      name = (snap.data() as Map<String, dynamic>)['Name'];
      email = (snap.data() as Map<String, dynamic>)['Email'];
      Branch = (snap.data() as Map<String, dynamic>)['Branch'];
      year = (snap.data() as Map<String, dynamic>)['Year'];
      profile = (pro.data() as Map<String, dynamic>)['Profile'];

    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(title: Text('PROFILE',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
            ),
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  profile == null?
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg'),
                    backgroundColor: Colors.white,
                    maxRadius: 80,
                  ):
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile!),
                    backgroundColor: Colors.white,
                    maxRadius: 80,
                  ),
                  Positioned(
                    child:IconButton(
                      onPressed: (){
                        showDialog(context: context,
                            builder: (context)=>
                                SimpleDialog(
                                  title: Text("Select source"),
                                  children: [
                                    IconButton(
                                      onPressed: ()async{
                                        Uint8List file = await pickimage(ImageSource.camera);
                                        if(file!= null){
                                          setState(() {
                                            image = file;
                                          });
                                          if(image!= null){
                                            AuthMethods().Profile(file);
                                          }
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.camera),
                                    ),
                                    IconButton(
                                        onPressed: ()async{
                                          Uint8List file = await pickimage(ImageSource.gallery);
                                          if(file!= null){
                                            setState(() {
                                              image = file;
                                            });
                                          }
                                          if(image!= null){
                                            AuthMethods().Profile(file);
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.photo)
                                    ),
                                  ],
                                )
                        );
                      },
                      icon: Icon(Icons.edit),style: IconButton.styleFrom(iconSize:20)),
                    bottom: 1,
                    right: -13,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("$name", style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.mail,weight: 25),
              title: Text('$email', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.home,weight: 25),
              title: Text('$Branch', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.date_range,weight: 25),
              title: Text('$year', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SizedBox(height: 20,),


            Row(
              children: <Widget> [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.notification_add,weight: 25),
                    title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: FlutterSwitch(
                      activeColor: Colors.deepOrangeAccent,
                      height: 30,
                      width: 55,
                      value: status,
                      onToggle: (value){
                        setState(() {
                          status = value;
                        });
                      }),
                ),
              ],
            ),



            SizedBox(height: 20,),
            // TogleButtons(children: [], isSelected:  ),
            Center(
              child: ElevatedButton(onPressed: (){
              }, child: Text("Logout",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),

              ),

            ),
            SizedBox(height: 30,),
            Center(
              child: InkWell(
                child: Text("AboutUs", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AboutPage()));
                },
              ),

            )
          ],
        ),
      ),
    );
  }
}