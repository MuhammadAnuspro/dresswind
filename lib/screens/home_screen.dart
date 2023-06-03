import 'package:carousel_slider/carousel_slider.dart';
import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:dresswind/widgets/home_cards.dart';


class Home_Screen extends StatefulWidget {
  Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final List images = [
    "https://media.istockphoto.com/photos/using-online-tools-to-choose-the-best-medication-picture-id660133278?k=20&m=660133278&s=612x612&w=0&h=6CKF0x1EFAccZE-XbVGDyPlK1MIqXlcM34mqVAT3c1o=",
    "https://media.istockphoto.com/photos/woman-shopping-at-the-grocery-store-wearing-a-facemask-picture-id1225040522?k=20&m=1225040522&s=612x612&w=0&h=f67LzLjrtAlkxS9L8pf6wiDTDpYPs9Cy-oca9xTC8o0=",
    "https://media.istockphoto.com/photos/this-one-match-perfect-with-me-picture-id1293366109?k=20&m=1293366109&s=612x612&w=0&h=sZxIOdBctJdLx71165XgRdUAQo1SPkGsRPzDR5IF4-Y="
  ];
  List Categories = [
    "GROCERY",
    "ELECTRONICS",
    "PHARMACY",
    "GERMENTS",
    "COSMETICS"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text(
                "HomeScreen",
                style: Dresstyle.boldstyle,
              ),
            ),
            CarouselSlider(
              items: images
                  .map((e) => Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              e,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: [
                                Colors.lightGreenAccent.withOpacity(0.2),
                                Color.fromRGBO(137, 45, 207, 1)
                                    .withOpacity(0.2),
                                Colors.lightGreenAccent.withOpacity(0.2),
                              ]),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            child: Text(
                              "TITLE:",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ]))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
              ),
            ),
            HomeCards(title: Categories[0]),
            HomeCards(title: Categories[1]),
            HomeCards(title: Categories[2]),
            HomeCards(title: Categories[3]),
            HomeCards(title: Categories[4]),
          ],
        ),
      ),
    );
  }
}
