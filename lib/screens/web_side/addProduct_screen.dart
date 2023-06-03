import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dresswind/models/productsModels.dart';
import 'package:dresswind/utils/style.dart';
import 'package:dresswind/widgets/DressTextField.dart';
import 'package:dresswind/widgets/dress_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  //const AddProductScreen({super.key});

  static const String id = "addproducts";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();

  bool onSale = false;
  bool isPopular = false;
  bool isFavourite = false;

  String? selectedValue;
  bool isSaving = false;
  bool isUploading = false;

  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imagesUrls = [];
  var uuid = Uuid();

  List Categories = [
    "GROCERY",
    "ELECTRONICS",
    "PHARMACY",
    "GERMENTS",
    "COSMETICS"
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              Text(
                "ADD PRODUCTS",
                style: Dresstyle.boldstyle,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(border: InputBorder.none),
                    hint: Center(child: Text("Choose Category")),
                    validator: (value) {
                      if (value == null) {
                        return ("categories must be Selected");
                      }
                      return null;
                    },
                    value: selectedValue,
                    items: Categories.map((e) => DropdownMenuItem<String>(
                        value: e.toString(),
                        child: Text((e.toString())))).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    }),
              ),
              dresstextField(
                controller: productNameC,
                hintText: "Enter your product Name",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "Should not be empty";
                  }
                  return null;
                },
              ),
              dresstextField(
                controller: detailC,
                maxlines: 5,
                hintText: "Products details",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              dresstextField(
                controller: priceC,
                hintText: "Enter your product Price",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "Should not be empty";
                  }
                  return null;
                },
              ),
              dresstextField(
                controller: discountPriceC,
                hintText: "Enter your product Discount price",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "Should not be empty";
                  }
                  return null;
                },
              ),
              dresstextField(
                controller: serialCodeC,
                hintText: "Enter your product Serial Code...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "Should not be empty";
                  }
                  return null;
                },
              ),
              DressButton(
                title: "Pick image",
                onPress: () {
                  pickImage();
                },
                isloginbutton: true,
              ),
              // DressButton(
              //   isLoading: isUploading,
              //   title: "Upload images",
              //   onPress: () {
              //     uploadImages();
              //   },
              // ),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Image.network(
                              File(images[index].path).path,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SwitchListTile(
                  title: Text("Is this Product on Sale?"),
                  value: onSale,
                  onChanged: (v) {
                    setState(() {
                      onSale = !onSale;
                    });
                  }),
              SwitchListTile(
                  title: Text("Is this Product Popular?"),
                  value: isPopular,
                  onChanged: (v) {
                    setState(() {
                      isPopular = !isPopular;
                    });
                  }),
              DressButton(
                title: "SAVE",
                isloginbutton: true,
                onPress: () {
                  Save();
                },
                isLoading: isSaving,
              )
            ],
          ),
        )),
      ),
    );
  }

  Save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.addproducts(Products(
            Category: selectedValue,
            id: uuid.v4(),
            productName: productNameC.text,
            details: detailC.text,
            price: int.parse(priceC.text),
            discountPrice: int.parse(discountPriceC.text),
            onSale: onSale,
            isPopular: isPopular,
            isFavourite: isFavourite,
            imagesUrls: imagesUrls,
            serialCode: serialCodeC.text))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        imagesUrls.clear();
        images.clear();
        clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ADDED SUCCESSFULLY")));
      });
    });
    //   await FirebaseFirestore.instance
    //       .collection("products")
    //       .add({"images": imagesUrls}).whenComplete(() => {
    //             setState(() {
    //               isSaving = false;
    //               images.clear();
    //               imagesUrls.clear();
    //             }),
    //           });
  }

  clearField() {
    setState(() {
      productNameC.clear();
      //selectedValue = "";
    });
  }

  pickImage() async {
    final pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("No Image selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);
    // readASBytes ya kam karta hai jo hum images ya video FirebaseStore
    //main Bahaj ta hein ya us ko byte main convert kar deta hai matlab 00.form main.
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image)
          .then((downloadUrl) => imagesUrls.add(downloadUrl));
    }
  }
}
