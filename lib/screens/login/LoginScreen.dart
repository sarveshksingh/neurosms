import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goaccount/models/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/BaseModel.dart';
import '../../models/ServerError.dart';
import '../../retrofit/api_client.dart';
import '../../routes/Routes.dart';
import '../Common.dart';
import '../Subscriber/GetPasswordScreen.dart';

/*class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}*/

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  LoginScreen({required this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

/*enum FormType {
  login,
  register,
}*/

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  late bool passwordVisible;
  late bool isRememberPasswordClicked;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _username, _password, imgPath = '';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool visible = true;
  bool value = true;

  @override
  void initState() {
    passwordVisible = true;
    //isRememberPasswordClicked = false;
    super.initState();
    _loadUserInfo();
  }

  _saveValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRememberPasswordClicked', value);
    if (value) {
      prefs.setString('username', _username);
      prefs.setString('password', _password);
    } else {
      prefs.setString('username', '');
      prefs.setString('password', '');
    }
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imgPath = (prefs.getString('msologo') ?? null)!;
      value = (prefs.getBool('isRememberPasswordClicked') ?? false);
      _username = (prefs.getString('username') ?? '');
      _password = (prefs.getString('password') ?? '');
      _userNameController.text = _username;
      _passwordController.text = _password;
    });
  }

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.redAccent,
        /*appBar: AppBar(
        title: Text("Login Page"),
      ),*/
        //body:
        /*SingleChildScrollView(
            child:*/
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Group7534.png"),
                fit: BoxFit.cover,
              ),
              //color: Colors.transparent
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 200,
                        height: 100,
                        /*child: Text(
                          'NEUROSMS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),*/
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              //image: AssetImage('assets/images/bank.png')
                              //image: SvgPicture.asset('assets/images/bank.svg')
                              image: NetworkImage(imgPath)),
                          //borderRadius: BorderRadius.circular(50.0)
                        ),
                        //child: Image.asset('assets/images/bank.png')
                      ),
                    ),
                  ))),
                  Expanded(
                      child: Container(
                          child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Form(
                                key: formKey,
                                child: new Column(
                                  children: <Widget>[
                                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                    Padding(
                                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                      padding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 32.0,
                                          bottom: 0),
                                      child: TextFormField(
                                        onSaved: (val) => _username = val!,
                                        controller: _userNameController,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Please enter your email address';
                                          }
                                          // Check if the entered email has the right format
                                          /*if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }*/
                                          // Return null if the entered email is valid
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            //border: OutlineInputBorder(),
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 16.0,
                                                      end: 16.0,
                                                      top: 8.0),
                                              child: SvgPicture.asset(
                                                  'assets/images/user.svg',
                                                  color: Color(
                                                      0xffDF1D3B)), // myIcon is a 48px-wide widget.
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 16.0,
                                                      end: 16.0,
                                                      top: 8.0),
                                              child: SvgPicture.asset(
                                                  'assets/images/tick.svg',
                                                  color: Color(
                                                      0xffDF1D3B)), // myIcon is a 48px-wide widget.
                                            ),
                                            labelText: 'Email',
                                            hintText:
                                                'Enter valid email id as abc@gmail.com'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 15.0,
                                          bottom: 0),
                                      //padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: TextFormField(
                                        obscureText: passwordVisible,
                                        onSaved: (val) => _password = val!,
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          if (value.trim().length < 8) {
                                            return 'Password must be at least 8 characters in length';
                                          }
                                          // Return null if the entered password is valid
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            //border: OutlineInputBorder(),
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 16.0,
                                                      end: 16.0,
                                                      top: 8.0),
                                              child: SvgPicture.asset(
                                                  'assets/images/lock.svg',
                                                  color: Color(
                                                      0xffDF1D3B)), // myIcon is a 48px-wide widget.
                                            ),
                                            /*
                                            suffixIcon: IconButton(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 16.0,
                                                      end: 16.0,
                                                      top: 8.0),
                                              icon: SvgPicture.asset(
                                                  'assets/images/visibility.svg',
                                                  color: Color(
                                                      0xffDF1D3B)),

                                              onPressed: ()
                                              {
                                                setState(() {
                                                  passwordVisible = false;
                                                });
                                                print("eye button clicked");
                                              },
                                            ),

                                             */
                                            suffixIcon: GestureDetector(
                                              onLongPress: () {
                                                setState(() {
                                                  passwordVisible = false;
                                                });
                                              },
                                              onLongPressUp: () {
                                                setState(() {
                                                  passwordVisible = true;
                                                });
                                              },
                                              child: Icon(passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            labelText: 'Password',
                                            hintText: 'Enter secure password'),
                                      ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, top: 5.0, right: 15.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                Checkbox(
                                                  value: this.value,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      this.value = value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Remember Password',
                                                  maxLines: 4,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto_Bold',
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                )
                                              ]),
                                            ),
                                            FlatButton(
                                              padding:
                                                  EdgeInsets.only(left: 65.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Forgot Password?',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Roboto_Bold',
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            GetPasswordScreen()));
                                              },
                                            )
                                          ],
                                        )),

                                    /*

                                    FlatButton(
                                        onPressed: () {
                                          //TODO FORGOT PASSWORD SCREEN GOES HERE
                                          /*Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.forgot,
                                        ModalRoute.withName(Routes.forgot));*/
                                          // Navigator.pushNamedAndRemoveUntil(
                                          //     context, Routes.forget, ModalRoute.withName(Routes.forget));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      GetPasswordScreen()));
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )),

                                  */
                                    Expanded(
                                        child: Center(
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: new Column(
                                                    //mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Container(
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            HomeScreen()));*/
                                                            loadProgress();
                                                            final form = formKey
                                                                .currentState;

                                                            if (form
                                                                !.validate()) {
                                                              setState(() =>
                                                                  _isLoading =
                                                                      true);
                                                              form.save();
                                                              _saveValue(value);
                                                              _buildBody(
                                                                  context,
                                                                  _username,
                                                                  _password);
                                                              // Navigator.pushNamedAndRemoveUntil(
                                                              //     context, Routes.login, ModalRoute.withName(Routes.login));
                                                            }
                                                          },
                                                          child: Text(
                                                            'LOG IN',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      )
                                                    ]))))
                                  ],
                                ))),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Text(
                                  'NEURO SMS 2021 Copyright Neuro Informstics Pvt. Ltd'),
                            ))
                      ],
                    ),
                  ))),
                  /*Container(
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
                    */ /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/ /*
                    //child: Image.asset('asset/images/flutter-logo.png')
                  ),
                ),
              )),
              Container(
                  child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Form(
                          key: formKey,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 32.0,
                                    bottom: 0),
                                child: TextFormField(
                                  onSaved: (val) => _username = val,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    // Check if the entered email has the right format
                                    */ /*if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }*/ /*
                                    // Return null if the entered email is valid
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      //border: OutlineInputBorder(),
                                      labelText: 'Email',
                                      hintText:
                                          'Enter valid email id as abc@gmail.com'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 15,
                                    bottom: 0),
                                //padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  obscureText: true,
                                  onSaved: (val) => _password = val,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    if (value.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    // Return null if the entered password is valid
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      //border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'Enter secure password'),
                                ),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                                    */ /*Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.forgot,
                                        ModalRoute.withName(Routes.forgot));*/ /*
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //     context, Routes.forget, ModalRoute.withName(Routes.forget));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                GetPasswordScreen()));
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 50.0, left: 15.0, right: 15.0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: new Column(
                                      //mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          child: FlatButton(
                                            onPressed: () {
                                              */ /*Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          HomeScreen()));*/ /*
                                              loadProgress();
                                              final form = formKey.currentState;

                                              if (form.validate()) {
                                                setState(
                                                    () => _isLoading = true);
                                                form.save();
                                                _buildBody(context, _username,
                                                    _password);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (_) =>
                                                //             HomeScreen()));
                                              }
                                            },
                                            child: Text(
                                              'LOG IN',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ])),
                              SizedBox(
                                height: 130,
                              ),
                              Text(
                                  'NEURO SMS 2021 Copyright Neuro Informstics Pvt. Ltd')
                            ],
                          )))),*/
                ])));
  }

  Future<BaseModel<Login>> _buildBody(
      BuildContext context, String username, String password) async {
    Login response;
    final apiClient =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      response = await apiClient.loginUser(username, password);
      Navigator.pop(context);
      setState(() async {
        if (response.status == 1) {
          loadProgress();
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('Login', true);
          pref.setString('token', response.tokenId);
          /*pref.setString("Branch", respose.Branch);
            pref.setString("Name", respose.Name);
            pref.setString("Image_Path", respose.Image_Path);
            pref.setString("User_ID", respose.User_ID);
            pref.setString("Deligated_ByName", respose.Deligated_ByName);
            pref.setString("Deligated_By", respose.Deligated_By);
            pref.setString("Department", respose.Department);
            pref.setString("M_app_key", respose.M_App_Key);*/
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, ModalRoute.withName(Routes.home));
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()..data = response;
  }
}
