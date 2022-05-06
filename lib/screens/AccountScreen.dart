import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goaccount/models/BaseModel.dart';
import 'package:goaccount/models/ServerError.dart';
import 'package:goaccount/retrofit/api_client.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goaccount/models/ChangePasswordResponse.dart';

import 'Common.dart';
import 'Subscriber/AppDrawer.dart';
import 'Subscriber/BottomNavigationbar.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account';

  @override
  _AccountScreenState createState() => new _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 2;
  final formKey = new GlobalKey<FormState>();
  late String _newpassword, _confirmpassword;
  double currentBalance = 0;

  late String _token, _password, _confpassword;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              brightness: Brightness.light,
              elevation: 0.0,
              title: new Text('Account Settings'))),
      backgroundColor: Color(0xffffffff),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 5.0, left: 10.0),
                          child: Text(
                            'ACCOUNT SETTINGS',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 14,
                              fontFamily: 'Roboto_Bold',
                              //fontWeight: FontWeight.bold
                            ),
                          ))
                    ],
                  ),
                  _buildAccountCard(),
                  _buildSecurityCard(),
                  //_buildInactiveCard()
                ],
              ),
            )
            //),
          ],
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationbar(_selectedIndex),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = (prefs.getString('token') ?? null)!;
    //_subsId = (prefs.getString('subsId') ?? null);
    //_encdvcId = (prefs.getString('encDvcMapId') ?? '');
  }

  Widget _buildAccountCard() => new Container(
      child: new Card(
          elevation: 8.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: new InkWell(
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      //builder: (context) => TimesheetPage()
                      ),
                );*/
              },
              child: Container(
                  margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Column(children: [
                    Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(top: 18.0),
                      decoration: BoxDecoration(
                          //color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/bank.png')
                              /*image: logo == ''
                                    ? Image.asset('assets/images/bank.png')
                                    : NetworkImage(logoPath +
                                    logo), */ //NetworkImage(logoPath)
                              ),
                          borderRadius: BorderRadius.circular(65.0)),
                    ),
                    Container(
                        // width: 57,
                        // height: 57,
                        margin: EdgeInsets.only(top: 13.0),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontFamily: 'Roboto_Regular',
                            //fontWeight: FontWeight.bold
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 17.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xffFFEFEE),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: new Text(
                              'Email Notification',
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 14,
                                fontFamily: 'Roboto_Regular',
                              ),
                            )),
                            Container(child: SwitchScreen()),
                          ],
                        ))
                  ])))));

  Widget _buildSecurityCard() => new Container(
      child: new Card(
          elevation: 8.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 7.0),
                        child: Text(
                          'SECURITY',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontFamily: 'Roboto_Bold',
                            //fontWeight: FontWeight.bold
                          ),
                        ))
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 17.0),
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFFEFEE),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: new InkWell(
                        onTap: () {
                          showResetPasswordBottomSheet();
                        },
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10),
                                child: SvgPicture.asset(
                                    'assets/images/logout.svg',
                                    color: Color(0xffDF1D3B))),
                            Expanded(
                                child: new Text(
                              'Change Password',
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 14,
                                fontFamily: 'Roboto_Regular',
                              ),
                            )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color(0xffDF193E),
                                )),
                          ],
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 17.0),
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFFEFEE),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: new InkWell(
                        onTap: () {
                          show2FA1BottomSheet();
                        },
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10),
                                child: SvgPicture.asset(
                                    'assets/images/smartphone.svg',
                                    color: Color(0xffDF1D3B))),
                            Expanded(
                                child: new Text(
                              'Two-Factor Authentication (2FA)',
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 14,
                                fontFamily: 'Roboto_Regular',
                              ),
                            )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color(0xffDF193E),
                                )),
                          ],
                        )))
              ],
            ),
          )));

  void showResetPasswordBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here.
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0), topRight: Radius.circular(60.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 44.0, bottom: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: 5.0),
                  //color: Colors.red,
                  child: Text(
                    'RESET PASSWORD',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 14,
                      fontFamily: 'Roboto_Bold',
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(left: 5.0),
                  //color: Colors.red,
                  child: Text(
                    'Please Enter a New Password',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 12,
                      fontFamily: 'Open_Sans_Regular',
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                new Form(
                    key: formKey,
                    child: new Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            obscureText: true,
                            onSaved: (val) => _newpassword = val!,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter your new password';
                              }
                              if (value.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'New Password',
                                hintText: 'Enter new password'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
                            obscureText: true,
                            onSaved: (val) => _confirmpassword = val!,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter confirm password';
                              }
                              if (value.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              // Return null if the entered password is valid
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Password',
                                hintText: 'Enter confirm password'),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 80.0, bottom: 40.0),
                    //color: Colors.red,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0, left: 20),
                          child: FlatButton(
                            child: Row(
                              children: [
                                Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 12,
                                    fontFamily: 'Open_Sans_Regular',
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              print('Remove button tapped');
                              final form = formKey.currentState;

                              if (form!.validate()) {
                                setState(() =>
                                    // _isLoading =
                                    // true);
                                    form.save());
                                Navigator.pop(context);
                                _buildBody(context, _token, _newpassword,
                                    _confirmpassword);

                                // showResetPasswordConfirmBottomSheet();
                              }
                            },
                            textColor: Color(0xffF9F9FB),
                            color: Color(0xffDF193E),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                    color: Colors.transparent),
                                borderRadius: new BorderRadius.circular(15.0)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.0, bottom: 10.0, right: 50),
                          child: FlatButton(
                            child: Row(
                              children: [
                                Text(
                                  "CANCEL",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 12,
                                    fontFamily: 'Open_Sans_Regular',
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              //print('Cancel button tapped');
                              Navigator.pop(context);
                            },

                            // textColor: Color(0xF9F9FB),
                            textColor: Color(0xffF9F9FB),

                            color: Color(0xff727272),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                    color: Colors.transparent),
                                borderRadius: new BorderRadius.circular(15.0)),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  void showResetPasswordConfirmBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here.
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0), topRight: Radius.circular(60.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 44.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            //color: Colors.red,
                            image: DecorationImage(
                                //fit: BoxFit.fill,
                                image: AssetImage('assets/images/Group1414.png')
                                //image: SvgPicture.asset('assets/images/bank.svg')
                                //image: NetworkImage(imgPath)
                                ),
                            borderRadius: BorderRadius.circular(50.0)))),
                Container(
                  child: Text(
                    'Your password has been changed successfully',
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
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: new Column(
                                //mainAxisSize: MainAxisSize.min,
                                //   crossAxisAlignment:
                                //   CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Common().logoutPressed(context);
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
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
          );
        });
  }

  void show2FA1BottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here.
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0), topRight: Radius.circular(60.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 44.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                  children: [
                    Text(
                      'TWO-FACTOR\nAUTHENTICATION (2FA)',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontFamily: 'Roboto_Bold',
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'It is highly recommended that you setup a two-step verification for your account. enabling 2FA gives you more security and protection against passible phishing, social engineering and password brute-force attacks.',
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 12,
                          fontFamily: 'Open_Sans_Regular',
                          //fontWeight: FontWeight.bold
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                //color: Colors.red,
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFDF193E),
                                      const Color(0xFFE33C2B),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(20)),
                            child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        show2FA2BottomSheet();
                                      },
                                      child: Text(
                                        'ADD VERIFICATION',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Open_Sans_Regular',
                                        ),
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
          );
        });
  }

  bool value = true;

  void show2FA2BottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here.
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0), topRight: Radius.circular(60.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 44.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                  children: [
                    Text(
                      '2-STEP VERIFICATION',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontFamily: 'Roboto_Bold',
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )),
                Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Row(children: [
                      Text(
                        'When you would like to use 2-Step verification?',
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 12,
                          fontFamily: 'Open_Sans_Regular',
                          //fontWeight: FontWeight.bold
                        ),
                      )
                    ])),
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  Text(
                    'Every login',
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 12,
                      fontFamily: 'Roboto_Medium',
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ]),
                Container(
                    margin: EdgeInsets.only(top: 100.0),
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFDF193E),
                              const Color(0xFFE33C2B),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(20)),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                              child: Column(
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  show2FA3BottomSheet();
                                },
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Open_Sans_Regular',
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ])),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xff727272),
                        borderRadius: BorderRadius.circular(20)),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                              child: Column(
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Open_Sans_Regular',
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ])),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 25.0),
                //       child: Text(
                //           'NEURO SMS 2021 Copyright Neuro Informstics Pvt. Ltd'),
                //     ))
              ],
            ),
          );
        });
  }

  void show2FA3BottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here.
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0), topRight: Radius.circular(60.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 44.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                  children: [
                    Text(
                      '2-STEP VERIFICATION',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontFamily: 'Roboto_Bold',
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )),
                Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Row(children: [
                      Text(
                        '1. Install an Authenticator App from your phone\'s such as a google Authenticator App.',
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 12,
                          fontFamily: 'Open_Sans_Regular',
                          //fontWeight: FontWeight.bold
                        ),
                      )
                    ])),
                Row(children: [
                  Text(
                    '2. Open the Authenticator App.',
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 12,
                      fontFamily: 'Open_Sans_Regular',
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ]),
                Row(children: [
                  Text(
                    '3. Tap the Add icon or begain startup button.',
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 12,
                      fontFamily: 'Open_Sans_Regular',
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ]),
                Row(children: [
                  Text(
                    '4. Choose scan a Barcode and scan using your phone:',
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 12,
                      fontFamily: 'Open_Sans_Regular',
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ]),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          image: DecorationImage(
                              //fit: BoxFit.fill,
                              image: AssetImage('assets/images/Group1414.png')
                              //image: SvgPicture.asset('assets/images/bank.svg')
                              //image: NetworkImage(imgPath)
                              ),
                        ))),
                Container(
                  child: Text(
                    'Unable to scan the barcode?',
                    style: TextStyle(
                      color: Color(0xff00BE0D),
                      fontSize: 12,
                      fontFamily: 'Open_Sans_Regular',
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 26.0),
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFDF193E),
                              const Color(0xFFE33C2B),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(20)),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Open_Sans_Regular',
                                ),
                              ),
                            ),
                          )
                        ])),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xff727272),
                        borderRadius: BorderRadius.circular(20)),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Open_Sans_Regular',
                                ),
                              ),
                            ),
                          )
                        ])),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 25.0),
                //       child: Text(
                //           'NEURO SMS 2021 Copyright Neuro Informstics Pvt. Ltd'),
                //     ))
              ],
            ),
          );
        });
  }

  Future<BaseModel<ChangePasswordResponse>> _buildBody(BuildContext context,
      String token, String password, String confirmpassword) async {
    ChangePasswordResponse response;
    final apiClient =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      //Sarvesh 26=03-2022
      response =
          await apiClient.getChangePassword(token, password, confirmpassword);
      setState(() async {
        if (response.status == 1) {
          //loadProgress();
          showResetPasswordConfirmBottomSheet();

          /*pref.setString("Branch", respose.Branch);
            pref.setString("Name", respose.Name);
            pref.setString("Image_Path", respose.Image_Path);
            pref.setString("User_ID", respose.User_ID);
            pref.setString("Deligated_ByName", respose.Deligated_ByName);
            pref.setString("Deligated_By", respose.Deligated_By);
            pref.setString("Department", respose.Department);
            pref.setString("M_app_key", respose.M_App_Key);*/
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.home, ModalRoute.withName(Routes.home));
          //return _buildPosts(context, respose);
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

  Future<bool?> _logoutPressed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('Login', false);
    pref.setString("token", "");
    pref.setString("Name", "");
    // pref.setString("Image_Path", null);
    pref.setString("User_ID", "");
    // pref.setString("Deligated_ByName", null);
    // pref.setString("Deligated_By", null);
    // pref.setString("Department", null);
    // pref.setString("M_app_key", null);
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Color(0xffDF1D3B),
            activeTrackColor: Colors.black,
            inactiveThumbColor: Color(0xffDF1D3B),
            inactiveTrackColor: Colors.black,
          )),
      // Text(
      //   '$textValue',
      //   style: TextStyle(fontSize: 20),
      // )
    ]);
  }
}
