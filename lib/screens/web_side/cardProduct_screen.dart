import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';

class CardProductScreen extends StatelessWidget {
  const CardProductScreen({super.key});

  static const String id = "cardproducts";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("CARD PRODUCTS",style: Dresstyle.boldstyle,)),
    );
  }
}