import 'package:goaccount/screens/AccountScreen.dart';
import 'package:goaccount/screens/Subscriber/GetPasswordScreen.dart';
import 'package:goaccount/screens/Subscriber/HomeScreen.dart';
import 'package:goaccount/screens/Subscriber/MSOScreen.dart';
import 'package:goaccount/screens/Subscriber/Subscription.dart';
import 'package:goaccount/screens/Subscriber/TransactionHistoryScreen.dart';
import 'package:goaccount/screens/Subscriber/WebView.dart';
import 'package:goaccount/screens/login/LoginScreen.dart';

class Routes {
  static const String mso = MSOScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String home = HomeScreen.routeName;
  static const String forget = GetPasswordScreen.routeName;
  static const String transaction = TransactionHistoryScreen.routeName;
  static const String subscription = Subscription.routeName;
  static const String account = AccountScreen.routeName;
  static const String webview = WebView.routeName;
}