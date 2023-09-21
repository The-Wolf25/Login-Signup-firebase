import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:metro/Screens/homescreen.dart';
import 'package:metro/Screens/login.dart';
import 'package:metro/utils/colos.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Signup> {
  bool loading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _user = TextEditingController();

  TextEditingController _pass = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  createUserWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email.text,
        password: _pass.text,
      )
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homescreen()));
      }).onError((error, stackTrace) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21)),
                  title: Text("Error"),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                      child: Text(
                        "Ok",
                        style:
                            TextStyle(color: Color.fromARGB(255, 188, 13, 13)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  String email = '';
  String password = '';

  String fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.shade_four,
      body: SingleChildScrollView(
        child: Container(
            child: Container(
                child: Column(
          children: [
            Stack(children: [
              SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: BezierClipper(),
                child: Container(
                  color: colors.shade_one,
                  height: 270,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 26),
                  child: Container(
                      width: 150,
                      height: 150,
                      child: Lottie.asset('Assets/Ani/hi.json'))),
              SizedBox(
                height: 320,
              ),
            ]),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Welcome There!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 34,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8)
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 42,
                    ),
                    Text(
                      ' Signup to continue.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18),
                    ),
                  ]),
                  Form(
                    key: _formkey,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 38, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          TextFormField(
                            controller: _user,
                            validator: (Text) {
                              if (Text == null || Text.isEmpty) {
                                return 'Please enter Username';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: colors.shade_one,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Enter Username'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: colors.shade_one,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Email',
                                hintStyle: TextStyle()),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _pass,
                            validator: (Text) {
                              if (Text == null || Text.isEmpty) {
                                return 'Enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: colors.shade_one,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Keep a Password'),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: InkWell(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  createUserWithEmailAndPassword();
                                }
                              },
                              child: (loading)
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: CircularProgressIndicator(),
                                    ))
                                  : Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 165, 73, 73),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 45,
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 222, 221, 221)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Container(
                                  child: Text(
                                    'SignIn ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 66, 124, 157),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ))),
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    //
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
