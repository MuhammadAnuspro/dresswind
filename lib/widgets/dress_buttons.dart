import 'package:flutter/material.dart';

class DressButton extends StatefulWidget {
  bool isloginbutton;
  String? title;
  VoidCallback? onPress;
  bool? isLoading;
  

   DressButton({Key? key,
   this.isLoading =false,
   this.title,this.isloginbutton=false,  this.onPress,}) : super(key: key);

  @override
  State<DressButton> createState() => _DressButtonState();
}

class _DressButtonState extends State<DressButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: widget.isloginbutton == false ?Colors.white:Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.isloginbutton == false ?Colors.black:Colors.black),
        ),

        child: Stack(
          children: [
             Visibility(
              visible: widget.isLoading ! ? false:true,
               child: Center(
                       child: Text(widget.title ?? "Button",
                       style: TextStyle( color: widget.isloginbutton == false ?Colors.black:Colors.white,fontWeight: FontWeight.normal,fontSize: 20),
                       
                       ),
                       
                     ),
             ),
             Visibility(
              visible: widget.isLoading!,
               child: Center(
                       child: CircularProgressIndicator(),
                       
                     ),
             ),
      

          ],
        )
        
        
        
      ),
      
    );
  }
}