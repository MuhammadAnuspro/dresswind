import 'package:dresswind/utils/style.dart';
import 'package:flutter/material.dart';


class HomeCards extends StatelessWidget {

  final String? title;
  const HomeCards({
    Key? key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [ Colors.lightGreenAccent.withOpacity(0.5),
                    Color.fromRGBO(137, 45, 207, 1).withOpacity(0.5),
                     Colors.lightGreenAccent.withOpacity(0.5),
                     
                    ]
                    ),
                    ),
                   child: Padding(padding: EdgeInsets.all(15.0),
                   child: Text( title??"TITLE:",
                   style: Dresstyle.boldstyle.copyWith(
                    color: Colors.white,
                   )),
                   ),
                   

                  ),
    );
  }
}
