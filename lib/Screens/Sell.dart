import 'dart:async';
import 'dart:typed_data';

import 'package:fister/Authentication/StorageMethods.dart';
import 'package:fister/Screens/BuySell.dart';
import 'package:fister/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget {
  const Sell({Key? key}) : super(key: key);

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final formkey = GlobalKey<FormState>();
  String? name;
  String? price;
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Product name"),
                      icon: Icon(Icons.production_quantity_limits),
                    ),
                    validator: RequiredValidator(errorText: "Required"),
                    onChanged: (val){
                     name = val;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Price"),
                      icon: Icon(Icons.currency_rupee)
                    ),
                    validator: RequiredValidator(errorText: "Required"),
                    onChanged: (val)=> price = val,
                  )
                  ,image == null?
                      IconButton(
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
                                             Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.photo)
                                        )
                                      ],
                                    )
                            );
                          },
                          icon: Icon(Icons.upload))
                      :
                      Image.memory(image!),
                  ElevatedButton(
                      onPressed: ()async{
                        if(formkey.currentState!.validate()){
                          if(image!= null){
                            String ref = await StorageMethods().StoreProductInfo(name!, price!, image!);
                            if(ref == "success"){
                              showDialog(context: context,
                                  builder: (context)=>
                                  SimpleDialog(
                                    children: [
                                      Icon(Icons.verified_user_outlined),
                                      Text("Uploaded successfully")
                                    ],
                                  )
                              );
                              Timer(Duration(seconds: 2),(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BuySell()));
                              });
                            }else{
                              Snapshot(ref, context);
                            }
                          }
                        }
                      },
                      child: Text("Submit"))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
