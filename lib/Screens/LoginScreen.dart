import 'package:fister/Authentication/AuthMethods.dart';
import 'package:fister/Screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Responsive/responsive.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("images/icon.jpg"),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        label: Text("Email", style: TextStyle(
                          color: Colors.black,
                        ),),
                        icon: Icon(Icons.man),
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
                  SizedBox(height: 20,),
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
                  SizedBox(height:20),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: ElevatedButton(onPressed: (){
                      login();
                    },
                        child:Text("Login", style: TextStyle(
                          color: Colors.white
                        ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                        )
                      ), ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account? ",style: TextStyle(
                        color: Colors.black
                      ),),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Text("Create", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                        },
                      )
                    ],
                  ),
                  Expanded(child: Container())

                ],
            ),
        ),
          )),
    );
  }
  login()async{
    if(formkey.currentState!.validate()){
      String ref = await AuthMethods().LoginWithEmailAndPassword(email, password);
      if (ref == "success"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Responsive()));
      }
      else{
        Snapshot(ref,context);
      }
    }
  }

}
