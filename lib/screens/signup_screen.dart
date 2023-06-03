import 'package:dresswind/screens/login_screen.dart';
import 'package:dresswind/services/firebase_services.dart';
import 'package:dresswind/utils/style.dart';
import 'package:dresswind/widgets/DressTextField.dart';
import 'package:dresswind/widgets/dress_buttons.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  
  const Signupscreen({
    Key? key,
    
  }) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController retypepasswordC = TextEditingController();

  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final _formkey = GlobalKey<FormState>();
  bool ispassword = true;
  bool retypepassword = true;
  bool? formStateLoading = false;
  @override
  void dispose() {
    passwordC.dispose();
    retypepasswordC.dispose();
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
      if (passwordC.text == retypepasswordC.text) {
        setState(() {
          formStateLoading = true;
        });


        
        dressDialogue("Yes password is matched");
        String? accountstatus =
         await FirbaseServices.createAccount(emailC.text, passwordC.text);
         if (accountstatus != null){
          dressDialogue(accountstatus);
          setState(() {
            formStateLoading =false;
          });

         }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Loginscreen(),));
         }
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin:  EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "WELCOME \n Please Create your Account",
                  textAlign: TextAlign.center,
                  style: Dresstyle.boldstyle,
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          dresstextField(
                            iconCheck: true,
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
                            icon: const Icon(Icons.email_outlined),
                            inputAction: TextInputAction.next,
                          ),
                          dresstextField(
                            inputAction: TextInputAction.next,
                            ispassword: ispassword,
                            controller: passwordC,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should  not  be Empty";
                              }
                              return null;
                            },
                            hintText: "Enter your password",
                            focusNode: passwordfocus,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispassword = !ispassword;
                                });
                              },
                              icon: ispassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                          ),
                          dresstextField(
                            ispassword: retypepassword,
                            controller: retypepasswordC,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should not be Empty";
                              }
                              return null;
                            },
                            hintText: "retype password",
                            inputAction: TextInputAction.next,
                            focusNode: retypepasswordfocus,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  retypepassword = !retypepassword;
                                });
                              },
                              icon: retypepassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                          ),

                          DressButton(
                            title: "SignUp",
                            isloginbutton: true,

                            onPress: () {
                              submit();
                            },
                            isLoading: formStateLoading,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox( height: MediaQuery.of(context).size.height * 0.1),
                DressButton(
                  title: "BACK TO LOGIN",
                  onPress: () {
                    Navigator.pop(context);
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
