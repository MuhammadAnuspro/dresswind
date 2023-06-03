import 'package:dresswind/widgets/dress_buttons.dart';
import 'package:flutter/material.dart';


class dressDialogue extends StatelessWidget {

  final String? title;
  const dressDialogue({Key? key, this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
            actions: [
              DressButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
      
      
    
  }
}