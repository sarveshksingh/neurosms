import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:goaccount/screens/Subscriber/MSOScreen.dart';
import 'package:goaccount/screens/login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Splash> {
  bool _mso = false, _login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Group7534.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 150.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Text(
                          'NEUROSMS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        //child: Image.asset('asset/images/flutter-logo.png')
                      ),
                    ),
                  )))
                ])));
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _loadUserInfo());
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mso = (prefs.getBool('MSO') ?? false);
    _login = (prefs.getBool('Login') ?? false);
    if (!_mso) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.mso, ModalRoute.withName(Routes.mso));
      Navigator.push(context, MaterialPageRoute(builder: (_) => MSOScreen(onSignedIn: () {  },)));
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.login, ModalRoute.withName(Routes.login));
    } else if (!_login) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.mso, ModalRoute.withName(Routes.mso));
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen( onSignedIn: () {  },)));
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.login, ModalRoute.withName(Routes.login));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.home, ModalRoute.withName(Routes.home));
    }
  }

/* @override
  Widget build(BuildContext context) {
    //return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: Center(child: Text('Splash Screen!')));
    */ /*return new SplashScreen(
      title: new Text(
        'Welcome to Splash Screen',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );*/ /*
  }*/
}
