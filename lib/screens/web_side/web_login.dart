import 'package:dresswind/screens/web_side/web_main_screen.dart';
import 'package:dresswind/services/firebase_services.dart';
import 'package:dresswind/utils/style.dart';
import 'package:dresswind/widgets/DressTextField.dart';
import 'package:dresswind/widgets/dress_buttons.dart';
import 'package:dresswind/widgets/dress_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class WebLoginScreen extends StatefulWidget {
  static const String id = "weblogin";
  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  // const WebLoginScreen({Key? key}) : super(key: key);
  TextEditingController userNameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirbaseServices.adminSignIn(userNameC.text).then((value) async {
        if (value['username'] == userNameC.text &&
            value['password'] == passwordC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.pushReplacementNamed(context, WebMainScreen.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            }); 
            showDialog(
                context: context,
                builder: (_) {
                  return dressDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "WELCOME ADMIN",
                      style: Dresstyle.boldstyle,
                    ),
                    const Text(
                      "Log in to your Account",
                      style: Dresstyle.boldstyle,
                    ),
                    dresstextField(
                      controller: userNameC,
                      hintText: "UserName...",
                     // maxLines: 1,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "email should not be empty";
                        }
                        return null;
                      },
                    ),
                    dresstextField(
                      controller: passwordC,
                      ispassword: true,
                      //maxLines: 1,
                      hintText: "Password...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "password should not be empty";
                        }
                        return null;
                      },
                    ),
                    DressButton(
                      isloginbutton: true,
                      isLoading: formStateLoading,
                      onPress: () {
                        submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}