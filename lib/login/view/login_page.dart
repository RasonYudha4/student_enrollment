import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_enrollment/model/user.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF283F61),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/President_University_Logo.png',
                height: 140,
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(1, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 30,
                    bottom: 15,
                    right: 30,
                  ),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      // textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                        //Do something with the user input.
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
                      )),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(1, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 30,
                    bottom: 15,
                    right: 30,
                  ),
                  child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password',
                      )),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Check if the user is not null
                    if (userCredential.user != null) {
                      String userId =
                          userCredential.user!.uid; // Get the user ID
                      String email =
                          userCredential.user!.email!; // Get the user email
                      context.read<UserModel>().setUserData(userId, email);
                      Navigator.pushNamed(context, '/home');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: const Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
