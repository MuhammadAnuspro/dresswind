import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});

  static const String id = "deleterproducts";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("DELETE PRODUCTS",style: Dresstyle.boldstyle,)),
    );
  }
}