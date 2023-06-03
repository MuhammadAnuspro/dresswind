import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? Category;
  String? id;
  String? productName;
  String? details;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<String>? imagesUrls;
  bool? onSale;
  bool? isPopular;
  bool? isFavourite;

  Products({
    required this.Category,
    required this.id,
    required this.productName,
    required this.details,
    required this.price,
    required this.discountPrice,
    required this.onSale,
    required this.isPopular,
    required this.isFavourite,
    required this.imagesUrls,
    required this.serialCode,
  });

  static Future<void> addproducts(Products product) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": product.Category,
      "productName": product.productName,
      "id": product.id,
      "details": product.details,
      "price": product.price,
      "discountPrice": product.discountPrice,
      "isFavourite": product.isFavourite,
      "isPopular": product.isPopular,
      "onSale": product.onSale,
      "imagesUrls": product.imagesUrls,
      "serialCode": product.serialCode,
    };
    await db.add({data});
  }

  static Future<void> updateproducts(String id, Products updateproduct) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": updateproduct.Category,
      "productName": updateproduct.productName,
      "id": updateproduct.id,
      "details": updateproduct.details,
      "price": updateproduct.price,
      "discountPrice": updateproduct.discountPrice,
      "isFavourite": updateproduct.isFavourite,
      "isPopular": updateproduct.isPopular,
      "onSale": updateproduct.onSale,
      "imagesUrls": updateproduct.imagesUrls,
      "serialCode": updateproduct.serialCode,
    };
    await db.doc(id).update(data);
  }

  Future<void> deleteproduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
