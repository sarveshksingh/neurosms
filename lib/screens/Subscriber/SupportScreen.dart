import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AppDrawer.dart';
import 'BottomNavigationbar.dart';

class SupportScreen extends StatefulWidget {
  static const String routeName = '/account';

  @override
  _SupportScreenState createState() => new _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedIndex = 3;
  final formKey = new GlobalKey<FormState>();
  late String _newpassword, _confirmpassword;
  double currentBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              brightness: Brightness.light,
              elevation: 0.0,
              title: new Text('Support'))),
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
                            'SUBSCRIBER SUPPORT',
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
                  //Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          // width: 100,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Open_Sans_Regular'),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onPressed: () {
                              print('Save button Clicked');
                            },
                            textColor: Color(0xffFFFFFF),
                            color: Color(0xffDF193E),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                    color: Colors.transparent),
                                borderRadius:
                                new BorderRadius.circular(15.0)),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          //width: 100,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Open_Sans_Regular'),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onPressed: () {
                              print('Cancel button Clicked');
                            },
                            textColor: Color(0xffFFFFFF),
                            color: Color(0xff727272),
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                    color: Colors.transparent),
                                borderRadius:
                                new BorderRadius.circular(15.0)),
                          ),
                        ),
                      ],
                    ),
                  )
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
                  height: 200,
                  margin: EdgeInsets.all(5.0),
                  child: Column(children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // gradient: LinearGradient(
                        //     colors: [
                        //       const Color(0xFFDF193E),
                        //       const Color(0xFFE33C2B),
                        //     ],
                        //     begin: const FractionalOffset(0.0, 0.0),
                        //     end: const FractionalOffset(1.0, 0.0),
                        //     stops: [0.0, 1.0],
                        //     tileMode: TileMode.clamp)
                      ),
                    ))
                  ])))));


}

