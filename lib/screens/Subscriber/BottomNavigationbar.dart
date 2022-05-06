import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goaccount/screens/AccountScreen.dart';
import 'package:goaccount/screens/Subscriber/BillingScreen.dart';
import 'package:goaccount/screens/Subscriber/HomeScreen.dart';
import 'package:goaccount/screens/Subscriber/SupportScreen.dart';

class BottomNavigationbar extends StatefulWidget {
  int _selectedIndex = 0;
  BottomNavigationbar(int selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  @override
  _BottomNavigationbarState createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  //int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: widget._selectedIndex == 0
              ? SvgPicture.asset('assets/images/home.svg',
              color: Color(0xffDF1D3B))
              : SvgPicture.asset(
            'assets/images/home.svg',
          ),
          label: 'Home',
          //backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: widget._selectedIndex == 1
              ? SvgPicture.asset('assets/images/profile.svg',
              color: Color(0xffDF1D3B))
              : SvgPicture.asset(
            'assets/images/profile.svg',
          ),
          label: 'Billing',
          //backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: widget._selectedIndex == 2
              ? SvgPicture.asset('assets/images/user.svg',
              color: Color(0xffDF1D3B))
              : SvgPicture.asset(
            'assets/images/user.svg',
          ),
          label: 'Account',
          //backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: widget._selectedIndex == 3
              ? SvgPicture.asset('assets/images/support.svg',
              color: Color(0xffDF1D3B))
              : SvgPicture.asset('assets/images/support.svg'),
          label: 'Support',
          //backgroundColor: Colors.pink,
        ),
      ],
      currentIndex: widget._selectedIndex,
      type: BottomNavigationBarType.fixed,
      //selectedItemColor: Color(0xffDF193E),
      unselectedItemColor: Color(0xff515353),
      onTap: _onItemTapped,
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
    _onTap();
  }
  final List<Widget> _children = [
    HomeScreen(),
    BillingScreen(),
    AccountScreen(),
    SupportScreen()
  ];

  _onTap() { // this has changed
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => _children[widget._selectedIndex])); // this has changed
  }
}