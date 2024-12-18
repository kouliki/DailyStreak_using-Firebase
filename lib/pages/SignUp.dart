// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/Components/Primary_button.dart';
import 'package:project_1/Components/SecondaryButton.dart';
import 'package:project_1/Components/women_textfield.dart';
import 'package:project_1/db/shared_prefrences.dart';
// import 'package:project_1/pages/HomePage.dart';
import 'package:project_1/pages/SignIn.dart';
import 'package:project_1/pages/register/Register_admin.dart';
import 'package:project_1/pages/register/register_child.dart';
import 'package:project_1/screens/home.dart';
import 'package:project_1/utils/constants.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  // const LoginScreen({Key? key}) : super(key: key);
  bool isPasswordshown=true;
  final _formKey= GlobalKey<FormState>();
  final _formData=Map<String, Object>();
  bool isLoading = false;

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
       progressIndicator(context);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _formData['email'].toString(),
        password: _formData['password'].toString(),
      );


      if (userCredential.user != null) {
        setState(() {
          isLoading=false;
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if ( value['type'] == 'Admin') {
            MySharedPrefference.saveUserType('Admin');

            // goTo(context, ParentHomeScreen());
          } else {
            MySharedPrefference.saveUserType('User');
            goTo(context, Home());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      if (e.code == 'user-not-found') {
        // dialogueBox(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // dialogueBox(context, 'Wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? progressIndicator(context)
                :
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Top container for logo and title
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'USER LOGIN',
                            style: TextStyle(
                              fontSize: 40,
                              color: Color(0xfffc3b77),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/logo.jpg',
                            height: 100,
                            width: 100,
                          ),
                        ],
                      ),
                    ),

                    // Middle container for text fields and buttons
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomField(
                              onsave: (email) {
                                _formData['email'] = email ?? ' ';
                              },
                              hintText: "Enter email",
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              validate: (email) {
                                if (email!.isEmpty || email.length < 3 || !email.contains("@")) {
                                  return "Enter a correct email";
                                }
                                return null;
                              },

                            ),
                            CustomField(
                              hintText: "Enter password",
                              isPassword: isPasswordshown,
                              prefix: Icon(Icons.vpn_key_rounded),
                              onsave: (password) {
                                _formData['password'] = password ?? ' ';
                              },

                              validate: (password) {
                                if (password!.isEmpty || password.length < 7 ) {
                                  return "Enter correct password";
                                }
                                return null;
                              },
                              suffix: IconButton(
                                onPressed: (){
                                  setState(() {
                                     isPasswordshown=!isPasswordshown;
                                  });


                                },


                                icon: isPasswordshown? Icon(Icons.visibility_off):
                                Icon(Icons.visibility),

                              ),
                            ),
                            PrimaryButton(
                              title: "LOGIN",
                              // onPressed: _onSubmit,

                              onPressed: (){
                                progressIndicator(context);
                                if (_formKey.currentState!.validate()){
                                  _onSubmit();
                                }


                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom section for additional options
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SecondaryButton(
                          title: "Click here",
                          onPressed: () {},
                        ),
                        SecondaryButton(
                          title: "Register As Admin",
                          onPressed: () {
                            goTo(context, RegisterAdminScreen() );
                            // this part is in constants.dart
                          },
                        ),
                        SecondaryButton(
                          title: "Register As User",
                          onPressed: () {
                             goTo(context, RegisterChildScreen() );
                            // this part is in constants.dart
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
