import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goaccount/models/BaseModel.dart';
import 'package:goaccount/models/MSOResponse.dart';
import 'package:goaccount/models/ServerError.dart';
import 'package:goaccount/retrofit/api_client.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common.dart';

class MSOScreen extends StatefulWidget {
  static const String routeName = '/mso';

  const MSOScreen({required this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  _MSOScreenState createState() => new _MSOScreenState();
}

class _MSOScreenState extends State<MSOScreen> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _msoname;

  bool visible = true;

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
                                          top: 32.0,
                                          bottom: 0),
                                      child: TextFormField(
                                        onSaved: (val) => _msoname = val!,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Please enter MSO Name';
                                          }
                                          // Return null if the entered email is valid
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            //border: OutlineInputBorder(),
                                            labelText: 'Enter MSO Name',
                                            hintText: 'Enter valid MSO Name'),
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
                                                            /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            HomeScreen()));*/
                                                            loadProgress();
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

  Future<BaseModel<MsoResponse>> _buildBody(
      BuildContext context, String subDomain) async {
    MsoResponse response;
    final apiClient =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      response = await apiClient.msoDetails(subDomain);
      setState(() async {
        if (response.status == 1) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('MSO', true);
          pref.setString("logoPath", response.logoPath);
          pref.setString(
              "msologo", response.logoPath + response.msoDetails.profilePic);
          /*pref.setString("Image_Path", respose.Image_Path);
            pref.setString("User_ID", respose.User_ID);
            pref.setString("Deligated_ByName", respose.Deligated_ByName);
            pref.setString("Deligated_By", respose.Deligated_By);
            pref.setString("Department", respose.Department);
            pref.setString("M_app_key", respose.M_App_Key);*/
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, ModalRoute.withName(Routes.login));
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // Toast.show("Token expired", context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.pop(context);
      Common().logoutPressed(context);
      return BaseModel()..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()..data = response;
  }
}
