import 'dart:typed_data';
import 'package:fister/Authentication/AuthMethods.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../Responsive/responsive.dart';
import '../utils/utils.dart';
import 'LoginScreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  Uint8List? image;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(height: 80,),
                  Stack(
                    children: [image == null?
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("images/profile.png"),
                      ):
                    CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: MemoryImage(image!),
                    ),
                      Positioned(child: IconButton(
                        icon: Icon(Icons.edit,color: Colors.black),

                        onPressed: () async{
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                          Uint8List im = await file!.readAsBytes();
                          setState(() {
                            image = im;
                          });
                        }
                      ),
                      left: 115,
                      top: 125,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          label: const Text("Name", style: TextStyle(
                            color: Colors.black,
                          ),),
                          icon: const Icon(Icons.man),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onChanged: (val) {
                        name = val;
                      },

                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          label: Text("Email", style: TextStyle(
                            color: Colors.black,
                          ),),
                          icon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "Invalid")
                      ]),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          label: Text("Password", style: TextStyle(
                            color: Colors.black,
                          ),),
                          icon: Icon(Icons.paste_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(8, errorText: "Minimum 8 lettters"),
                        MaxLengthValidator(12, errorText: "Maximum 12 letters")
                      ]),

                    ),
                  ),
                  const SizedBox(height:10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: ElevatedButton(onPressed: (){
                     register();
                    },
                      child:Text("Register", style: TextStyle(
                          color: Colors.white
                      ),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          )
                      ), ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account? ",style: TextStyle(
                          color: Colors.black
                      ),),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Text("Login", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                        },
                      )
                    ],
                  ),
                  

                ],
              ),
            ),
          ),
        )),
    );
  }
  register()async{
    if(formkey.currentState!.validate()){
      String ref = await AuthMethods().RegisterWithEmailAndPassword(name, email, password, image!);
      if(ref == "success"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Responsive()));
      }
      else{
        Snapshot(ref, context);
      }

    }
  }
}
