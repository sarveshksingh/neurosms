import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:goaccount/screens/AccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common.dart';
import 'BillingScreen.dart';
import 'SupportScreen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late SharedPreferences pref;
  String userName = '', userId = '', key = '', imgPath = '';
  double balance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();
  }

  getCredential() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('User_ID')!;
      userName = pref.getString('Name')!;
      balance = pref.getDouble('balance')!;
      // imgPath = pref.getString('Image_Path');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: 'assets/images/home.svg',
              text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.home)),
          _createDrawerItem(
            icon: 'assets/images/profile.svg',
            text: 'Billing',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BillingScreen()))
          ),
          _createDrawerItem(
              icon: 'assets/images/user.svg',
              text: 'Account',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AccountScreen()))),
          _createDrawerItem(
            icon: 'assets/images/support.svg',
            text: 'Support',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SupportScreen()))
          ),
          /*_createDrawerItem(
              icon: 'assets/images/trademark_report_nav.svg',
              text: 'Trademark Report',
              onTap: () {
                Toast.show("Coming soon", context);
              }
              // onTap: () => Navigator.pushReplacementNamed(
              //     context, Routes.trademarkreport)
              ),
          _createDrawerItem(
              icon: 'assets/images/clients_nav.svg',
              text: 'Clients',
              onTap: () {
                Toast.show("Coming soon", context);
              }),
          _createDrawerItem(
              icon: 'assets/images/retainer_invoice_nav.svg',
              text: 'Retainer Invoice',
              onTap: () {
                Toast.show("Coming soon", context);
              }),*/
          /*Divider(),
          _createDrawerItem(icon: Icons.collections_bookmark, text: 'Steps'),
          _createDrawerItem(icon: Icons.face, text: 'Authors'),
          _createDrawerItem(
              icon: Icons.account_box, text: 'Flutter Documentation'),
          _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),*/
          Divider(),
          _createDrawerItem(
              icon: 'assets/images/logout_nav.svg',
              text: 'Logout',
              onTap: () {
                Common().logoutPressed(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, Routes.login, ModalRoute.withName(Routes.login));
              }),
          /*ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),*/
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Color(0xffDF1D3B),
          // image: DecorationImage(
          //     fit: BoxFit.fill, image: AssetImage('assets/images/bank.png')
          //     //image: NetworkImage(imgPath)
          //     )
        ),
        child: Stack(children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            //color: Colors.red,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/bank.png')),
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ]),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(userName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto_Bold'))),
                    ]),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text('\u20B9 ${balance}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto_Bold'))),
                    ])
              ]

              //child: Image.asset('assets/images/bank.png')
              )
        ]));
  }

  Widget _createDrawerItem(
      {String? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: SvgPicture.asset(icon!, color: Color(0xffDF1D3B))),
          //SvgPicture.asset(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
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
