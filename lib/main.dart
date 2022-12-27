import 'package:flutter/material.dart';
import 'package:flutter_app/signin.dart';

import 'functions.dart';
import 'home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override

  void initState(){
    super.initState();
  }

  checkUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedIn = value!;
      });
    });//Future value면 await
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: {_isLoggedIn ?? false } != null ? Home() : SignIn(),
    );
  }
}
