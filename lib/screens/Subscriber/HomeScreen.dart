import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:goaccount/models/BaseModel.dart';
import 'package:goaccount/models/ServerError.dart';
import 'package:goaccount/models/SubsDashboardResponse.dart';
import 'package:goaccount/retrofit/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common.dart';
import 'AppDrawer.dart';
import 'BottomNavigationbar.dart';
import 'QuickRecharge.dart';
import 'Subscription.dart';
import 'TransactionHistoryScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HardwareDetailsList> _hardwareDetailsList = [];
  List<SubscriptionList> _subscriptionList = [];
  int _selectedIndex = 0;
  late String _token,
      userName = '',
      companyName = '',
      contactNumber = '',
      email = '',
      logoPath = '',
      logo;
  double currentBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              brightness: Brightness.light,
              elevation: 0.0,
              title: new Text('Dashboard'))),
      backgroundColor: Color(0xffDF1D3B),

      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Container(height: 100, color: Colors.red),
            //Expanded(
            //child:
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _buildUserCard(),
                  _buildActivtCard(),
                  //_buildInactiveCard()
                ],
              ),
            )
            //),
          ],
        ),
      ),
      //body: _homePage(),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationbar(_selectedIndex),
    );
  }

  Widget _buildUserCard() => new Container(
      child: new Card(
          elevation: 8.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: new InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       //builder: (context) => TimesheetPage()
                //       ),
                // );
              },
              child: Container(
                  margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          width: 57,
                          height: 57,
                          margin: EdgeInsets.only(right: 13.0),
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
                              borderRadius: BorderRadius.circular(57.0)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  companyName,
                                  style: TextStyle(
                                    color: Color(0xffDF1D3B),
                                    fontSize: 14,
                                    fontFamily: 'Roboto_Bold',
                                    //fontWeight: FontWeight.bold
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: new Text(
                                  contactNumber,
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Medium',
                                    //fontWeight: FontWeight.normal
                                  ),
                                )),
                            Row(children: [
                              Container(
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 10.0),
                                  child: new Text(
                                    'Email:',
                                    style: TextStyle(
                                      color: Color(0xff808080),
                                      fontSize: 12,
                                      fontFamily: 'Roboto_Regular',
                                      //fontWeight: FontWeight.normal
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, top: 5.0, bottom: 10.0),
                                  child: new Text(
                                    email,
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 12,
                                      fontFamily: 'Roboto_Medium',
                                    ),
                                  ))
                            ])
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(right: 13.0),
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/wallet.png')),
                              borderRadius: BorderRadius.circular(35.0)),
                        ),
                        Container(
                            child: Expanded(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  'Current Balance',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Light',
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 5.0),
                                child: new Text(
                                  '\u20B9 ${currentBalance}',
                                  style: TextStyle(
                                    //color: Colors.green,
                                    color: currentBalance > 0
                                        ? Color(0xff227700)
                                        : Color(0xffDF1D3B),
                                    fontSize: 14,
                                    fontFamily: 'Roboto_Bold',
                                  ),
                                )),
                          ],
                        ))),
                        Container(
                            child: new InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  /*Toast.show("Transaction Click", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);*/
                                  prefs.setString('encDvcMapId', '');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionHistoryScreen()),
                                  );
                                  /*Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.transaction,
                                      ModalRoute.withName(Routes.transaction));*/
                                },
                                child: Row(children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 40.0),
                                      padding: EdgeInsets.all(10.0),
                                      child: new Text(
                                        'VIEW TRANSACTION',
                                        style: TextStyle(
                                          color: Color(0xffDF1D3B),
                                          fontSize: 12,
                                          fontFamily: 'Lato_Regular',
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: SvgPicture.asset(
                                          'assets/images/next.svg',
                                          color: Color(0xffDF1D3B))),
                                ]))),
                      ],
                    )
                  ])))));

  Widget _buildActivtCard() => new Container(
          child: Column(
        children: [
          Container(
              //height: 550,
              margin: EdgeInsets.only(bottom: 12.0),
              /*child: _buildListView(context, _hardwareDetailsList)),*/
              child: Column(
                children: [
                  LimitedBox(
                      maxHeight: 600,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Expanded(
                            child:
                                _buildListView(context, _hardwareDetailsList))
                      ]))
                ],
              ))
        ],
      ));

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = (prefs.getString('token') ?? null)!;
    if (_token != null) {
      /*Navigator.pushNamedAndRemoveUntil(
          context, Routes.login, ModalRoute.withName(Routes.login));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.home, ModalRoute.withName(Routes.home));*/
      //_buildBody(context, _token);
      getSubsDashboardData(context, _token);
    }
  }

  Widget _buildListView(
      BuildContext context, List<HardwareDetailsList> _hardwareDetailsList) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        _subscriptionList =
            _hardwareDetailsList.elementAt(index).hardsubscriptionList;
        String statusValue =
            _hardwareDetailsList.elementAt(index).hardwareStatusValue;
        String encDvcMapId = _hardwareDetailsList.elementAt(index).encDvcMapId;
        String subsId = _hardwareDetailsList.elementAt(index).subscriberId;
        return Card(
            elevation: 8.0,
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Container(
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 12.0, top: 10.0),
                child: Row(
                  children: [
                    Flexible(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                              child: Row(children: [
                            new Text(
                              statusValue,
                              style: TextStyle(
                                color: statusValue == 'Active'
                                    ? Color(0xff227700)
                                    : Color(0xffDF1D3B),
                                fontSize: 12,
                                fontFamily: 'Roboto_Regular',
                              ),
                            )
                          ])),
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                              child: Row(children: [
                                Container(
                                    //margin: EdgeInsets.only(bottom: 10.0),
                                    child: new Text(
                                  'STB:',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Medium',
                                  ),
                                )),
                                Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: new Text(
                                      _hardwareDetailsList
                                          .elementAt(index)
                                          .stbVcNo,
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 12,
                                        fontFamily: 'Roboto_Medium',
                                      ),
                                    ))
                              ])),
                          Container(
                              child: new InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    /* Toast.show("Transaction Click", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);*/

                                    prefs.setString('encDvcMapId', encDvcMapId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionHistoryScreen()),
                                    );
                                    /*Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.transaction,
                                    ModalRoute.withName(Routes.transaction));*/
                                  },
                                  child: Row(children: [
                                    Container(
                                        //margin: EdgeInsets.only(left: 40.0),
                                        padding: EdgeInsets.all(5.0),
                                        child: new Text(
                                          'VIEW TRANSACTION',
                                          style: TextStyle(
                                            color: Color(0xffDF1D3B),
                                            fontSize: 12,
                                            fontFamily: 'Lato_Regular',
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: SvgPicture.asset(
                                            'assets/images/next.svg',
                                            color: Color(0xffDF1D3B))),
                                  ]))),
                          Container(
                              child: Row(
                            children: [
                              //Expanded(
                              // child:
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom: 10.0, top: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffDF1D3B)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: new InkWell(
                                      onTap: () async {
                                        /*Toast.show("Subscription Click", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);*/
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                            .getInstance();
                                        /* Toast.show("Transaction Click", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);*/

                                        prefs.setString(
                                            'encDvcMapId', encDvcMapId);
                                        prefs.setString('subsId', subsId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Subscription()),
                                        );
                                        /*Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.subscription,
                                        ModalRoute.withName(
                                            Routes.subscription));*/
                                      },
                                      child: Row(children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 5.0,
                                                bottom: 10.0,
                                                top: 10.0,
                                                right: 5.0),
                                            child: new Text(
                                              'SUBSCRIPTION',
                                              style: TextStyle(
                                                color: Color(0xffDF1D3B),
                                                fontSize: 12,
                                                fontFamily: 'Lato_Regular',
                                              ),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 5.0),
                                            child: SvgPicture.asset(
                                                'assets/images/group75171.svg',
                                                color: Color(0xffDF1D3B))),
                                      ]))),
                              Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffDF1D3B)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: new InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        /* Toast.show("Transaction Click", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);*/

                                        prefs.setString(
                                            'encDvcMapId', encDvcMapId);
                                        prefs.setString('subsId', subsId);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           QuickRecharge()),
                                        // );
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => QuickRecharge(),
                                        ))
                                            .then((value) {
                                          // you can do what you need here
                                          // setState etc.
                                          print(
                                              "coming from quickrecharge page");
                                          _loadUserInfo();
                                        });
                                      },
                                      child: Row(children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 5.0,
                                                bottom: 10.0,
                                                top: 10.0,
                                                right: 5.0),
                                            child: new Text(
                                              'QUICK RECHARGE',
                                              style: TextStyle(
                                                color: Color(0xffDF1D3B),
                                                fontSize: 12,
                                                fontFamily: 'Lato_Regular',
                                              ),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 5.0),
                                            child: SvgPicture.asset(
                                                'assets/images/group75171.svg',
                                                color: Color(0xffDF1D3B))),
                                      ])))
                            ],
                          )),
                          LimitedBox(
                              maxHeight: 150,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                        child: _buildSubscriptionListView(
                                            context, _subscriptionList))
                                  ]))
                        ]))
                  ],
                )));
      },
      itemCount: _hardwareDetailsList.length, //posts.data.length,
    );
  }

  Widget _buildSubscriptionListView(
      BuildContext context, List<SubscriptionList> hardsubscriptionList) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        logo = hardsubscriptionList.elementAt(index).logo;
        DateTime startDate = hardsubscriptionList.elementAt(index).startDate;
        DateTime endDate = hardsubscriptionList.elementAt(index).endDate;
        DateTime now = DateTime.now();

        String productName = hardsubscriptionList.elementAt(index).productName;
        String formattedDate = DateFormat('dd-MMM-yyyy').format(startDate);
        final difference = endDate.difference(now).inDays;
        String expire = 'Expires in ' + difference.toString() + ' days';
        bool isActive = hardsubscriptionList.elementAt(index).isActive;

        String alert = isActive ? 'Active' : 'In Active';

        return Card(
            elevation: 3.0,
            //margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10),
                        padding: EdgeInsets.all(5.0),
                        //child: Image.asset('assets/images/Group7536.png')
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                //image: AssetImage('assets/images/bank.png')
                                //image: SvgPicture.asset('assets/images/bank.svg')
                                //image: logo == ''? Image.asset('assets/images/Group7536.png') : NetworkImage(logoPath + logo), //NetworkImage(logoPath)
                                image: NetworkImage(
                                    logoPath + logo), //NetworkImage(logoPath)
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          //child: Image.asset('assets/images/bank.png')
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productName, //'BASICS',//productName
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Medium'),
                              ),
                              Text(
                                formattedDate, //'15-Aug-2021',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                expire,
                                style: TextStyle(
                                    color: Color(0xff808080),
                                    fontSize: 10,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                              Text(
                                alert,
                                style: TextStyle(
                                    color: isActive
                                        ? Color(0xff227700)
                                        : Color(0xffDF1D3B),
                                    fontSize: 12,
                                    fontFamily: 'Roboto_Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
      itemCount: hardsubscriptionList.length, //posts.data.length,
    );
  }

  Future<BaseModel<SubsDashboardResponse>> getSubsDashboardData(
      BuildContext context, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SubsDashboardResponse response;
    final apiClient =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      //Sarvesh 26=03-2022
      response = await apiClient.getSubsDashboard(token);
      Navigator.pop(context);
      setState(() {
        if (response.status == 1) {
          logoPath = response.logoPath;
          prefs.setString('User_ID', response.dashboardinfo.userDetail.userId);

          prefs.setString('subsWalletId',
              response.dashboardinfo.subscriberProfile.walletId);
          userName = response.dashboardinfo.subscriberProfile.subscriberName;
          prefs.setString('Name', userName);
          companyName =
              response.dashboardinfo.subscriberProfile.mainAccountName;
          contactNumber = response
              .dashboardinfo.subscriberProfile.subscriberProfileAddress.phoneNo!;
          email = response.dashboardinfo.subscriberProfile.subscriberEmail;
          currentBalance = response
              .dashboardinfo.subscriberProfile.subscriberTotalWalletBalance;
          prefs.setDouble('balance', currentBalance);
          // Toast.show("Get Dashboard Data successfully", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          _hardwareDetailsList = response.dashboardinfo.hardwareDetailsList;
          _buildListView(context, _hardwareDetailsList);
          //loadProgress();
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
      return BaseModel()
        ..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()..data = response;
  }
}
