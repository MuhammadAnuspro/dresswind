import 'package:dresswind/screens/home_screen.dart';
import 'package:dresswind/screens/signup_screen.dart';
import 'package:dresswind/utils/style.dart';
import 'package:dresswind/widgets/DressTextField.dart';
import 'package:dresswind/widgets/dress_buttons.dart';
import 'package:flutter/material.dart';
import 'package:dresswind/services/firebase_services.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();

    super.dispose();
  }

  Future<void> dressDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              DressButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });

      String? accountstatus =
          await FirbaseServices.signInAccount(emailC.text, passwordC.text);
      if (accountstatus != null) {
        dressDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home_Screen(),
            ));
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
  bool retypepassword = true;
  bool? formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WELCOME \n Please Login First",
                  textAlign: TextAlign.center,
                  style: Dresstyle.boldstyle,
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          dresstextField(
                            validate: (v) {
                              if (v!.isEmpty ||
                                  !v.contains("@") ||
                                  !v.contains(".com")) {
                                return "Email is badly formated";
                              }
                              return null;
                            },
                            controller: emailC,
                            hintText: "Enter your email",
                          ),
                          dresstextField(
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should  not  be Empty";
                              }
                              return null;
                            },
                            controller: passwordC,
                            hintText: "Enter your password",
                          ),
                          DressButton(
                            title: "Login",
                            isloginbutton: true,
                            isLoading: formStateLoading,
                            onPress: () {
                              submit();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                DressButton(
                  title: "CREATE  NEW ACCOUNT",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Signupscreen())));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
