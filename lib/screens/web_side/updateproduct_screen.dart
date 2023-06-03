import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});

  static const String id = "updateproducts";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("UPDATE PRODUCTS",style: Dresstyle.boldstyle,)),
    );
  }
}