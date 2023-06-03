import 'package:flutter/material.dart';

class dresstextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? icon;
  bool iconCheck;
  bool ispassword;
  int? maxlines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;

  dresstextField(
      {Key? key,
      this.iconCheck = false,
      this.icon,
      this.hintText,
      this.controller,
      this.validate,
      this.ispassword = false,
      this.inputAction,
      this.focusNode,
      this.maxlines})
      : super(key: key);

  @override
  State<dresstextField> createState() => _dresstextFieldState();
}

class _dresstextFieldState extends State<dresstextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        
        controller: widget.controller,
        maxLines: widget.maxlines ==1?1:widget.maxlines,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        validator: widget.validate,
        obscureText: widget.ispassword == false ? false : widget.ispassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.hintText ?? 'please fill this Field',
          suffixIcon: widget.icon,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
