import 'package:dresswind/screens/landing_screen.dart';
import 'package:dresswind/screens/web_side/web_login.dart';
import 'package:dresswind/screens/web_side/web_main_screen.dart';
import 'package:flutter/material.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:  (context, constraints) {
        if(constraints.minWidth >600){
          return WebMainScreen();

        }
        else{
          return LandingScreen();
        }
        
      });
  }
}