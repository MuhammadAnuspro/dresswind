import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  static const String id = "dashboard";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("DASHBOARD",style: Dresstyle.boldstyle,)),
    );
  }
}