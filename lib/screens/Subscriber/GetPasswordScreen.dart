import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goaccount/models/BaseModel.dart';
import 'package:goaccount/models/ForgotPassword.dart';
import 'package:goaccount/models/ServerError.dart';
import 'package:goaccount/retrofit/api_client.dart';
import 'package:goaccount/routes/Routes.dart';

import '../Common.dart';

class GetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot';

  //const ForgotScreen(this.)
  @override
  _GetScreenState createState() => new _GetScreenState();
}

class _GetScreenState extends State<GetPasswordScreen> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _msoname;

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.redAccent,
        /*appBar: AppBar(
        title: Text("Login Page"),
      ),*/
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
                        Container(
                          margin: EdgeInsets.only(top: 50.0, left: 15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontFamily: 'OpenSans-Bold',
                                  //fontStyle: FontStyle.normal,
                                  //fontWeight: FontWeight.bold
                                ),
                              )),
                        ),
                        Expanded(
                            child: new Form(
                                key: formKey,
                                child: new Column(
                                  children: <Widget>[
                                    Padding(
                                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                      padding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 10.0,
                                          bottom: 0),
                                      child: TextFormField(
                                        onSaved: (val) => _msoname = val!,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Please enter User Name';
                                          }
                                          // Return null if the entered email is valid
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            //border: OutlineInputBorder(),
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      bottom: 8.0,
                                                      end: 16.0,
                                                      top: 16.0),
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
                                            labelText: 'Enter User Name',
                                            hintText: 'Enter valid User Name'),
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 50.0,
                                                    left: 15.0,
                                                    right: 15.0),
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
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder: (_) =>
                                                            //             PasswordSuccessScreen()));
                                                            final form = formKey
                                                                .currentState;

                                                            if (form!
                                                                .validate()) {
                                                              setState(() =>
                                                                  _isLoading =
                                                                      true);
                                                              form.save();
                                                              _buildBody(
                                                                  context,
                                                                  _msoname);
                                                              // Navigator.pushNamedAndRemoveUntil(
                                                              //     context, Routes.login, ModalRoute.withName(Routes.login));
                                                            }
                                                          },
                                                          child: Text(
                                                            'SUBMIT',
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
                ])));
  }

  Future<BaseModel<ForgotPassword>> _buildBody(
      BuildContext context, String subDomain) async {
    ForgotPassword response;
    final apiClient =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      //Sarvesh 26=03-2022
      response = await apiClient.forgotPassword(subDomain);
      Navigator.pop(context);
      setState(() async {
        if (response.status == 1) {
          /*SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setBool('Login', true);
            pref.setString("Branch", respose.Branch);
            pref.setString("Name", respose.Name);
            pref.setString("Image_Path", respose.Image_Path);
            pref.setString("User_ID", respose.User_ID);
            pref.setString("Deligated_ByName", respose.Deligated_ByName);
            pref.setString("Deligated_By", respose.Deligated_By);
            pref.setString("Department", respose.Department);
            pref.setString("M_app_key", respose.M_App_Key);*/
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.login, ModalRoute.withName(Routes.login));
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => PasswordSuccessScreen()));
          //return _buildPosts(context, respose);
        } else {
          // Toast.show("Oops something went wrong", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      Navigator.pop(context);
      return BaseModel()..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()..data = response;
  }
}

class PasswordSuccessScreen extends StatefulWidget {
  static const String routeName = '/forgot';

  //const ForgotScreen(this.)
  @override
  _GetSuccessScreenState createState() => new _GetSuccessScreenState();
}

class _GetSuccessScreenState extends State<PasswordSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.redAccent,
        /*appBar: AppBar(
        title: Text("Login Page"),
      ),*/
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
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
                            child: Container(
                                decoration: BoxDecoration(
                                    //color: Colors.red,
                                    image: DecorationImage(
                                        //fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/Group1414.png')
                                        //image: SvgPicture.asset('assets/images/bank.svg')
                                        //image: NetworkImage(imgPath)
                                        ),
                                    borderRadius:
                                        BorderRadius.circular(50.0)))),
                        Container(
                          child: Text(
                            'Your password has been sent to your registered email',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: new Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        Routes.login,
                                                        ModalRoute.withName(
                                                            Routes.login));
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          )
                                        ])))),
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
                ])));
  }

/*FutureBuilder<ForgotPassword> _buildBody(
      BuildContext context, String subDomain) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<ForgotPassword>(
      future: client.forgotPassword(subDomain).then((respose) {
        setState(() => _isLoading = false);
        setState(() async {
          if (respose.status == 1) {
            loadProgress();
            */ /*SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setBool('Login', true);
            pref.setString("Branch", respose.Branch);
            pref.setString("Name", respose.Name);
            pref.setString("Image_Path", respose.Image_Path);
            pref.setString("User_ID", respose.User_ID);
            pref.setString("Deligated_ByName", respose.Deligated_ByName);
            pref.setString("Deligated_By", respose.Deligated_By);
            pref.setString("Department", respose.Department);
            pref.setString("M_app_key", respose.M_App_Key);*/ /*
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.login, ModalRoute.withName(Routes.login));
            //return _buildPosts(context, respose);
          } else {
            Toast.show("Oops something went wrong", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        });
      }).catchError((err) {
        print(err);
      }),
    );
  }*/
}
