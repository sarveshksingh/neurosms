import 'package:flutter/material.dart';
import 'package:goaccount/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 20), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<bool?> logoutPressed(BuildContext context) async {
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
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.login, ModalRoute.withName(Routes.login));
  }
}
