import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:metro/Screens/Choose.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metromax'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyWidget()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
