import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:metro/Screens/homescreen.dart';
import 'package:metro/Screens/signup.dart';
import 'package:metro/utils/colos.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  bool loading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  signInWithEmailAndPassword() async {
    try {
      setState(() {
        loading = true;
      });
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _email.text,
        password: _pass.text,
      )
          .then(
        (value) {
          setState(() {});
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homescreen()));
        },
      ).onError(
        (error, stackTrace) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21)),
                  title: Text("Error"),
                  content: Text('Invalid Credentials'),
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
              });
        },
      );
      setState(() {
        loading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for the email')));
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong password')));
      }
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
                  height: 360,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 18),
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Lottie.asset('Assets/Ani/login.json',
                          fit: BoxFit.cover))),
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
                      'Welcome Back!',
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
                      'You were missed.',
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
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please Enter Email';
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
                            obscureText: true,
                            controller: _pass,
                            validator: (Text) {
                              if (Text == null || Text.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: colors.shade_one,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Password'),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 222, 221, 221)),
                                ),
                              ),
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
                                  signInWithEmailAndPassword();
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
                                              Color.fromARGB(255, 66, 124, 157),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 45,
                                      child: Text(
                                        'SignIn',
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
                                  'Dont hace an account? ',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 222, 221, 221)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                },
                                child: Container(
                                  child: Text(
                                    'SignUp ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 147, 62, 62)),
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
    path.lineTo(0, size.height * 0.65);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    //
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.80);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
