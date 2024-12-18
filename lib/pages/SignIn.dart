import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  // AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Reusable Button
              buttonItem(
                'assets/google.svg',
                'Continue with Google',
                25,
                    () {
                  // Implement Google Sign-In logic here
                  print("Google sign-in tapped");
                },
              ),
              const SizedBox(height: 20),
              buttonItem(
                'assets/phone.svg',
                'Continue with Mobile',
                25,
                    () {
                  // Implement Facebook Sign-In logic here
                  print("Google sign-in tapped");
                },
              ),
              SizedBox(height: 15,),
              Text('Or',style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),),
              SizedBox(height: 18,),
              textItem("Email...", _emailController, false),
              SizedBox(height: 15,),
              textItem("Password..", _pwdController, true),
              SizedBox(height: 10,),
              colorButton(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you donot have an account?",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("SignUp",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                  )
                  //   child: Text(
                  //     "Login",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  // )
                ],
              ),
              SizedBox(height: 10,),
              Text("Forgot Password?",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          // circular = true;
        });
        //   try {
        //     firebase_auth.UserCredential userCredential =
        //     await firebaseAuth.createUserWithEmailAndPassword(
        //         email: _emailController.text, password: _pwdController.text);
        //     print(userCredential.user.email);
        //     setState(() {
        //       circular = false;
        //     });
        //     Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (builder) => HomePage()),
        //             (route) => false);
        //   } catch (e) {
        //     final snackbar = SnackBar(content: Text(e.toString()));
        //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //     setState(() {
        //       circular = false;
        //     });
        //   }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  // Reusable button widget
  Widget buttonItem(
      String imagePath, String buttonName, double size, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              const SizedBox(width: 15),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget textItem(
      String labeltext, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

