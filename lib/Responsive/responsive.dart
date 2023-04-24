import 'package:flutter/material.dart';

import 'MobileScreen.dart';
import 'WebScreen.dart';

class Responsive extends StatefulWidget {

  const Responsive({Key? key,}) : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints){
      if(contraints.maxWidth >600){
        return WebScreen();
      }
      else{
        return MobileScreen();
      }
    });

  }
}
