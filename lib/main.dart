import 'package:dresswind/screens/layout_screen.dart';
import 'package:dresswind/screens/web_side/addProduct_screen.dart';
import 'package:dresswind/screens/web_side/cardProduct_screen.dart';
import 'package:dresswind/screens/web_side/dashboard_screen.dart';
import 'package:dresswind/screens/web_side/deleteProdect_screen.dart';
import 'package:dresswind/screens/web_side/updateproduct_screen.dart';
import 'package:dresswind/screens/web_side/web_login.dart';
import 'package:dresswind/screens/web_side/web_main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCF3RxeGmSE6jjQhtS2w2Er2LkngKervaE",
          authDomain: "dresswind.firebaseapp.com",
          projectId: "dresswind",
          storageBucket: "dresswind.appspot.com",
          messagingSenderId: "350841493755",
          appId: "1:350841493755:web:6787ed58976e324f84785e",
          measurementId: "G-6HT0MPQLF3"),
    );
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dresswind',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.white,
          ),
          home: LayoutScreen(), 
          routes: {
            WebLoginScreen.id:(context) => WebLoginScreen(),
          WebMainScreen.id:(context) => WebMainScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          DeleteProductScreen.id: (context) => DeleteProductScreen(),
          UpdateProductScreen.id:(context) => UpdateProductScreen(),
          CardProductScreen.id:(context) => CardProductScreen(),



          },
          ),
          
          
    );
  }
}
