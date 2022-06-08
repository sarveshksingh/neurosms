import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goaccount/models/BaseModel.dart';
import 'package:goaccount/models/QuickRechargeResponse.dart';
import 'package:goaccount/models/RechargeRenewResponseModel.dart';
import 'package:goaccount/models/RechargeRequestModel.dart';
import 'package:goaccount/models/ServerError.dart';
import 'package:goaccount/retrofit/api_client.dart';
import 'package:goaccount/screens/Subscriber/WebView.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common.dart';

class QuickRecharge extends StatefulWidget {
  @override
  _QuickRechargeState createState() => _QuickRechargeState();
}

class _QuickRechargeState extends State<QuickRecharge> {
  var checkBoxValue;

  List<MostRecentQuickRechargeSubscriptionList>
  mostRecentQuickRechargeSubscriptionList = [];
  List<MostRecentQuickRechargeSubscriptionList>
  productInfoQuickRechargeSubscription = [];
  List<MostRecentQuickRechargeSubscriptionList> basicList = [];
  List<MostRecentQuickRechargeSubscriptionList> addOnList = [];
  List<MostRecentQuickRechargeSubscriptionList> alaCarteList = [];
  late String _token,
      _subsId,
      _encdvcId,
      strCgst = 'CGST',
      strCgstAmt,
      strIgstAmt,
      strSgstAmt,
      strCgstTaxAmt,
      strIgstTaxAmt,
      strSgstTaxAmt,
      strTotalAmount,
      strNetpayableAmt;
  double basicTotal = 0.0,
      addOnTotal = 0.0,
      alaCarteTotal = 0.0,
      subTotalAmount = 0.0,
      totalAmount = 0.0,
      walletBalance = 0.0,
      netPayableAmount = 0.0,
      igstAmount = 0.0,
      cgstAmount = 0.0,
      sgstAmount = 0.0,
      cgstTax = 0.0,
      igstTax = 0.0,
      sgstTax = 0.0;

  bool sgstVisible = true;

  @override
  Widget build(BuildContext context) {
    List<String> listItem = ["Delegate", "Visitor", "Contacts", "Home"];
    return MaterialApp(
      // title: 'My Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'QuickRecharge',
            // textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Color(0xffFFFFFF),
            ),
          ),
          backgroundColor: Color(0xffDF193E),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "MOST RECENT SUBSCRIPTION",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff333333),
                          fontFamily: 'Roboto_Bold'),
                      // textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                LimitedBox(
                    maxHeight: 135,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                          child: _mostRescentSubscriptionListView(
                              context, mostRecentQuickRechargeSubscriptionList))
                    ])),
                Container(
                  //height: 490.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    color: Color(0xffFFEFEE),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(left: 15.0,right: 15.0,bottom: 0.0),

                        margin: EdgeInsets.only(
                            left: 0.0, right: 0.0, bottom: 0.0),
                        //height: 230.0,
                        color: Color(0xffFFEFEE),
                        //color: Colors.red,

                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: Colors.transparent,
                                margin: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "RECHARGE SUBSCRIPTION",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Bold'),
                                  //textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            /*Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Basic" + basicTotal.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontFamily: 'Roboto_Bold'),
                              // textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),*/
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          // margin:
                                          //     EdgeInsets.only(left: 10.0, top: 5),
                                          color: Color(0xffDADADA),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                'Basic',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff333333),
                                                    fontFamily: 'Roboto_Bold'),
                                                //textDirection: TextDirection.ltr,
                                                textAlign: TextAlign.left,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xffDADADA),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              '\u{20B9} ${basicTotal
                                                  .toString()}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff333333),
                                                  fontFamily: 'Roboto_Bold'),
                                              // textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                            )),
                                      ),
                                    ],
                                  )
                                ]),
                            LimitedBox(
                                maxHeight: 135,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: _basicRechargeSubscriptionListView(
                                              context, basicList))
                                    ])),
                            /*Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Add-On Package",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontFamily: 'Roboto_Bold'),
                              // textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),*/
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          // margin:
                                          //     EdgeInsets.only(left: 10.0, top: 5),
                                          color: Color(0xffDADADA),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                'Add-On Package',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff333333),
                                                    fontFamily: 'Roboto_Bold'),
                                                //textDirection: TextDirection.ltr,
                                                textAlign: TextAlign.left,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xffDADADA),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              '\u{20B9} ${addOnTotal
                                                  .toString()}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff333333),
                                                  fontFamily: 'Roboto_Bold'),
                                              // textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                            )),
                                      ),
                                    ],
                                  )
                                ]),
                            LimitedBox(
                                maxHeight: 135,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: _addOnRechargeSubscriptionListView(
                                              context, addOnList))
                                    ])),
                            /* Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "A-La-Carte",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontFamily: 'Roboto_Bold'),
                              // textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),*/
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          color: Color(0xffDADADA),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                'A-La-Carte',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff333333),
                                                    fontFamily: 'Roboto_Bold'),
                                                //textDirection: TextDirection.ltr,
                                                textAlign: TextAlign.left,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xffDADADA),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              '\u{20B9} ${alaCarteTotal
                                                  .toString()}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff333333),
                                                  fontFamily: 'Roboto_Bold'),
                                              // textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                            )),
                                      ),
                                    ],
                                  )
                                ]),
                            LimitedBox(
                                maxHeight: 135,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child:
                                          _aLaCarteRechargeSubscriptionListView(
                                              context, alaCarteList))
                                    ])),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.0, right: 0.0, bottom: 0.0),
                        height: 260.0,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffFBFBFB),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sub Total",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto_Medium",
                                        color: Color(0xff333333)),
                                  ),
                                  SizedBox(
                                    //width: 220.0,
                                  ),
                                  Text(
                                    '\u{20B9} ${subTotalAmount.toPrecision(3)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffFBFBFB),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    strCgst + " (" + strCgstAmt + "%)",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto_Medium",
                                        color: Color(0xff333333)),
                                  ),
                                  SizedBox(
                                    //width: 220.0,
                                  ),
                                  Text(
                                    '\u{20B9} ${cgstAmount.toPrecision(3)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffFBFBFB),

                              child: Visibility(
                                  visible: sgstVisible,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "SGST (" + strSgstAmt + "%)",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: "Roboto_Medium",
                                            color: Color(0xff333333)),
                                      ),
                                      SizedBox(
                                        //width: 220.0,
                                      ),
                                      Text(
                                        '\u{20B9} ${sgstAmount.toPrecision(3)}',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: "Roboto",
                                            color: Color(0xff333333)),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffDADADA),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto_Medium",
                                        color: Color(0xff333333)),
                                  ),
                                  SizedBox(
                                    //width: 220.0,
                                  ),
                                  Text(
                                    '\u{20B9} ${totalAmount.toPrecision(3)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffFBFBFB),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto_Medium",
                                        color: Color(0xff333333)),
                                  ),
                                  SizedBox(
                                    //width: 220.0,
                                  ),
                                  Text(
                                    '\u{20B9} ${walletBalance.toPrecision(3)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //width: 300,
                              margin:
                              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                              height: 30,
                              color: Color(0xffDADADA),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Net Payable Amount",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto_Medium",
                                        color: Color(0xff333333)),
                                  ),
                                  Text(
                                    '\u{20B9} ${netPayableAmount.toPrecision(
                                        3)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    child: FlatButton(
                                      child: Row(
                                        children: [
                                          Text(
                                            "SUBMIT",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: "Raleway"),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        print('Submit button Clicked');
                                        _rechargeRenew(
                                            context, _token, _subsId,
                                            _encdvcId);
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
                                    width: 100,
                                    child: FlatButton(
                                      child: Row(
                                        children: [
                                          Text(
                                            "CANCEL",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: "Raleway",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        print('Submit button Clicked');
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
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
    _subsId = (prefs.getString('subsId') ?? null)!;
    _encdvcId = (prefs.getString('encDvcMapId') ?? '');
    walletBalance = (prefs.getDouble('balance') ?? 0.0);
    if (_token != null) {
      _buildBody(context, _token, _subsId, _encdvcId);
    }
  }

  Future<BaseModel<QuickRechargeResponse>> _buildBody(BuildContext context,
      String token, String subsId, String encdvcId) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    QuickRechargeResponse response;
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      response = await client.getQuickRechargeData(token, subsId, encdvcId);
      Navigator.pop(context);
      setState(() {
        if (response.status == 1) {
          mostRecentQuickRechargeSubscriptionList =
              response.rechargeInfo.mostRecentQuickRechargeSubscriptionList;
          productInfoQuickRechargeSubscription =
              response.rechargeInfo.productInfoQuickRechargeSubscription;

          _mostRescentSubscriptionListView(
              context, mostRecentQuickRechargeSubscriptionList);
          for (var i = 0;
          i < productInfoQuickRechargeSubscription.length;
          i++) {
            if (productInfoQuickRechargeSubscription
                .elementAt(i)
                .productTypeId ==
                1) {
              basicList.add(productInfoQuickRechargeSubscription.elementAt(i));
              basicTotal = basicTotal +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .price!;
            } else if (productInfoQuickRechargeSubscription
                .elementAt(i)
                .productTypeId ==
                2) {
              addOnList.add(productInfoQuickRechargeSubscription.elementAt(i));
              addOnTotal = addOnTotal +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .price!;
            } else if (productInfoQuickRechargeSubscription
                .elementAt(i)
                .productTypeId ==
                3) {
              alaCarteList
                  .add(productInfoQuickRechargeSubscription.elementAt(i));
              alaCarteTotal = alaCarteTotal +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .price!;
            }
            if (productInfoQuickRechargeSubscription
                .elementAt(i)
                .isIgst!) {
              sgstVisible = false;
              strCgst = 'IGST';
              cgstAmount = cgstAmount +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .igst!;
            } else {
              sgstVisible = true;
              strCgst = 'CGST';
              cgstAmount = cgstAmount +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .cgst!;
              sgstAmount = sgstAmount +
                  productInfoQuickRechargeSubscription
                      .elementAt(i)
                      .sgst!;
            }
          }
          if (!sgstVisible)
            cgstTax = response.rechargeInfo.taxInfo
                .elementAt(0)
                .taxValue;
          else
            cgstTax = response.rechargeInfo.taxInfo
                .elementAt(1)
                .taxValue;
          sgstTax = response.rechargeInfo.taxInfo
              .elementAt(2)
              .taxValue;

          strCgstTaxAmt = cgstAmount.toString();
          strSgstTaxAmt = sgstAmount.toString();

          strCgstAmt = cgstTax.toString();
          strSgstAmt = sgstTax.toString();

          subTotalAmount = basicTotal + addOnTotal + alaCarteTotal;
          totalAmount = subTotalAmount + cgstAmount + sgstAmount;
          strTotalAmount = totalAmount.toString();
          if (totalAmount > walletBalance) {
            netPayableAmount = totalAmount - walletBalance;
          }
          strNetpayableAmt = netPayableAmount.toString();
          _basicRechargeSubscriptionListView(context, basicList);
          _addOnRechargeSubscriptionListView(context, addOnList);
          _aLaCarteRechargeSubscriptionListView(context, alaCarteList);
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      Navigator.pop(context);
      //_logoutPressed();
      return BaseModel()
        ..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()
      ..data = response;
  }

  Future<BaseModel<RechargeRenewResponseModel>> _rechargeRenew(
      BuildContext context,
      String token,
      String subsId,
      String encdvcId) async {
    RechargeRenewResponseModel response;

    //var productObject;
    //final ProductObj productObject;
    List<BasicPack> basicPackList = [];
    List<BasicPack> addOnPackList = [];
    List<BasicPack> channelPackList = [];
    List<BasicPack> discontinuedPackList = [];
    /*rechargeRequest.productObj = productObject;

    rechargeRequest.tokenId = token;
    rechargeRequest.subsId = subsId;
    rechargeRequest.encdvcId = encdvcId;
    rechargeRequest.isQuickRecharge = true;
    rechargeRequest.latestSubsTranId = 0;
    rechargeRequest.cashReceivedAmount = 0.00;
    rechargeRequest.walletRechargeStatus = false;
    rechargeRequest.pageName = "quickRecharge";*/

    for (var i = 0; i < basicList.length; i++) {
      MostRecentQuickRechargeSubscriptionList basicItem =
      basicList.elementAt(i);
      /*var basicPack;
      basicPack.productId = basicItem.productId;
      basicPack.startDate = basicItem.startDate;
      basicPack.endDate = basicItem.endDate;
      basicPack.subsTypeId = basicItem.subsTypeId;
      basicPack.subsVal = basicItem.subsVal;
      basicPack.packageType = basicItem.productTypeId;
      basicPack.isDiscontinued = false;
      basicPack.prdSubscriptionId = 18258;
      basicPack.promotionId = basicItem.promotionId;*/
      var basicPack = BasicPack(
          autoRenew: false,
          casSettingId: 0,
          casSmsProductId: null,
          originalEndDate: null,
          providerId: 0,
          providerValue: null,
          stbNumber: null,
          vcNumber: null,
          productId: basicItem.productId,
          startDate: basicItem.startDate,
          endDate: basicItem.endDate,
          subsTypeId: basicItem.subsTypeId,
          subsVal: basicItem.subsVal,
          packageType: 0,
          isDiscontinued: false,
          prdSubscriptionId: 18258,
          promotionId: basicItem.promotionId);
      basicPackList.add(basicPack);
    }
    //rechargeRequest.productObj.basicPacks = basicPackList;

    for (var i = 0; i < addOnList.length; i++) {
      MostRecentQuickRechargeSubscriptionList addOnItem =
      addOnList.elementAt(i);
      /*var addOnPack;
      addOnPack.productId = addOnItem.productId;
      addOnPack.startDate = addOnItem.startDate;
      addOnPack.endDate = addOnItem.endDate;
      addOnPack.subsTypeId = addOnItem.subsTypeId;
      addOnPack.subsVal = addOnItem.subsVal;
      addOnPack.packageType = addOnItem.productTypeId;
      addOnPack.isDiscontinued = false;
      addOnPack.prdSubscriptionId = 18258;
      addOnPack.promotionId = addOnItem.promotionId;*/
      var addOnPack = BasicPack(
          autoRenew: false,
          casSettingId: 0,
          casSmsProductId: null,
          originalEndDate: null,
          providerId: 0,
          providerValue: null,
          stbNumber: null,
          vcNumber: null,
          productId: addOnItem.productId,
          startDate: addOnItem.startDate,
          endDate: addOnItem.endDate,
          subsTypeId: addOnItem.subsTypeId,
          subsVal: addOnItem.subsVal,
          packageType: addOnItem.productTypeId,
          isDiscontinued: false,
          prdSubscriptionId: 18258,
          promotionId: addOnItem.promotionId);
      addOnPackList.add(addOnPack);
    }
    //rechargeRequest.productObj.addOnPacks = addOnPackList;

    for (var i = 0; i < alaCarteList.length; i++) {
      MostRecentQuickRechargeSubscriptionList alaCarte =
      alaCarteList.elementAt(i);
     /*var channelPack;
      channelPack.productId = alaCarte.productId;
      channelPack.startDate = alaCarte.startDate;
      channelPack.endDate = alaCarte.endDate;
      channelPack.subsTypeId = alaCarte.subsTypeId;
      channelPack.subsVal = alaCarte.subsVal;
      channelPack.packageType = alaCarte.productTypeId;
      channelPack.isDiscontinued = false;
      channelPack.prdSubscriptionId = 18258;
      channelPack.promotionId = alaCarte.promotionId;*/

      var channelPack = BasicPack(
          autoRenew: false,
          casSettingId: 0,
          casSmsProductId: null,
          originalEndDate: null,
          providerId: 0,
          providerValue: null,
          stbNumber: null,
          vcNumber: null,
          productId: alaCarte.productId,
          startDate: alaCarte.startDate,
          endDate: alaCarte.endDate,
          subsTypeId: alaCarte.subsTypeId,
          subsVal: alaCarte.subsVal,
          packageType: alaCarte.productTypeId,
          isDiscontinued: false,
          prdSubscriptionId: 18258,
          promotionId: alaCarte.promotionId);

      channelPackList.add(channelPack);
    }
    //rechargeRequest.productObj.channelPacks = channelPackList;

    // BasicPack discontinuedPack;
    /*for (var i = 0; i < basicList.length; i++) {
      MostRecentQuickRechargeSubscriptionList discontinued =
          basicList.elementAt(i);

      discontinuedPack.productId = discontinued.productId;
      discontinuedPack.startDate = discontinued.startDate;
      discontinuedPack.endDate = discontinued.endDate;
      discontinuedPack.subsTypeId = discontinued.subsTypeId;
      discontinuedPack.subsVal = discontinued.subsVal;
      discontinuedPack.packageType = discontinued.productTypeId;
      discontinuedPack.isDiscontinued = false;
      discontinuedPack.prdSubscriptionId = discontinued.productSubscriptionId;
      discontinuedPack.promotionId = discontinued.promotionId;

      discontinuedPackList.add(discontinuedPack);
    }*/
    // rechargeRequest.productObj.discontinuedPacks = discontinuedPackList;

    // rechargeRequest.productObj.basicPacks = [];
    // rechargeRequest.productObj.addOnPacks = [];
    // rechargeRequest.productObj.channelPacks = [];
    // rechargeRequest.productObj.discontinuedPacks = [];
    // rechargeRequest.productObj.isCreditLimitUsed = false;
    // rechargeRequest.productObj.isBulkRecharge = false;
    // rechargeRequest.productObj.cashReceived = 0.00;

    /*final queryParameters = {
      "tokenId": token,
      "productObj": {
        "basicPacks": [
          {
            "productId": 946,
            "startDate": "2021-09-06T00:00:00",
            "endDate": "2021-10-05T00:00:00",
            "subsTypeId": 2,
            "subsVal": 1,
            "packageType": 1,
            "isDiscontinued": false,
            "prdSubscriptionId": 18258,
            "promotionId": 0
          }
        ],
        "addOnPacks": [],
        "channelPacks": [],
        "discontinuedPacks": [],
        "isCreditLimitUsed": false,
        "isBulkRecharge": false,
        "cashReceived": 0.00
      },
      "subsId": subsId,
      "encdvcId": encdvcId,
      "isQuickRecharge": true,
      "latestSubsTranId": 0,
      "cashReceivedAmount": 0.00,
      "walletRechargeStatus": false,
      "pageName": "quickRecharge"
    };*/
    var productObject = ProductObj(basicPacks: basicPackList,
        addOnPacks: addOnPackList,
        channelPacks: channelPackList,
        discontinuedPacks: discontinuedPackList,
        isCreditLimitUsed: false,
        isBulkRecharge: false,
        cashReceived: 0.00);
    var rechargeRequest = RechargeRequest(tokenId: token,
        productObj: productObject,
        subsId: subsId,
        encdvcId: encdvcId,
        isQuickRecharge: true,
        latestSubsTranId: 0,
        cashReceivedAmount: 0.00,
        walletRechargeStatus: false,
        pageName: "subscription");
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    try {
      Common().showAlertDialog(context);
      //Sarvesh 26=03-2022
      response = await client.rechargeRenew(json.encode(rechargeRequest));
      Navigator.pop(context);
      setState(() async {
        if (response.status == 10) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          //pref.setString('paymentUrl', response.returnUrl);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      WebView(
                        url: response.returnUrl,
                      )));
        } else if (response.status == 0) {} else if (response.status == 1) {
          // Navigator.pop(context);
          showAlertDialog(context, response.message);
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      showAlertDialog(context, error.toString());
      /*
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  WebView()));
       */
      //Navigator.pop(context);
      return BaseModel()
        ..setException(ServerError.withError(error: error as DioError));
    }
    return BaseModel()
      ..data = response;
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Quick Recharge"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _mostRescentSubscriptionListView(BuildContext context,
      List<MostRecentQuickRechargeSubscriptionList>
      mostRecentQuickRechargeSubscriptionList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: mostRecentQuickRechargeSubscriptionList.length,
        itemBuilder: (BuildContext ctx, int index) {
          //return new Text(listItem[index]);

          String productName = mostRecentQuickRechargeSubscriptionList
              .elementAt(index)
              .productName!;
          String subscriptionTypeName = mostRecentQuickRechargeSubscriptionList
              .elementAt(index)
              .subscriptionTypeName!;
          bool? status =
              mostRecentQuickRechargeSubscriptionList
                  .elementAt(index)
                  .isActive;
          String statusValue = '';
          double amount = mostRecentQuickRechargeSubscriptionList
              .elementAt(index)
              .monthlyPrice!;
          // String expiryDay = mostRecentQuickRechargeSubscriptionList.elementAt(index).daysLeft as String;
          // double amount = mostRecentQuickRechargeSubscriptionList.elementAt(index).price;
          // String startDate = mostRecentQuickRechargeSubscriptionList.elementAt(index).startDate as String;
          // String endDate = mostRecentQuickRechargeSubscriptionList.elementAt(index).endDate as String;
          DateTime startDate = DateTime.parse(
              mostRecentQuickRechargeSubscriptionList
                  .elementAt(index)
                  .startDate!);
          DateTime endDate = DateTime.parse(
              mostRecentQuickRechargeSubscriptionList
                  .elementAt(index)
                  .endDate!);
          DateTime now = DateTime.now();

          String startFormattedDate =
          DateFormat('dd-MMM-yyyy').format(startDate);
          String enddtFormattedDate = DateFormat('dd-MMM-yyyy').format(endDate);
          // final difference = endDate.difference(now).inDays;
          // String expire = 'Expires in ' + difference.toString() + ' days';
          bool? isActive =
              mostRecentQuickRechargeSubscriptionList
                  .elementAt(index)
                  .isActive;
          String alert = isActive! ? 'Active' : 'In Active';

          if (status!) {
            statusValue = "Active";
          } else {
            statusValue = "InActive";
          }

          int ind = index;
          return new Card(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin:
                        EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                        child: Row(children: [
                          Container(
                            child: Icon(Icons.network_cell),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // Container(
                          //   child: Text('Hello'),
                          // )
                        ]),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 5.0),
                                child: Row(children: [
                                  Container(
                                    child: Text(
                                      productName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff333333),
                                          fontFamily: 'Roboto_Medium'),
                                      //textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 5),
                                child: Row(children: [
                                  Expanded(
                                    child: Text(
                                      statusValue,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: statusValue == 'Active'
                                              ? Color(0xff227700)
                                              : Color(0xffDF1D3B),
                                          fontFamily: 'Roboto_Regular'),
                                      // textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      '\u{20B9} ${amount}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff333333),
                                          fontFamily: 'Roboto_Regular'),
                                      // textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
                                child: Row(children: [
                                  Expanded(
                                    child: Text(
                                      startFormattedDate,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff333333),
                                          fontFamily: 'Roboto_Regular'),
                                      //textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      enddtFormattedDate,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff333333),
                                          fontFamily: 'Roboto_Regular'),
                                      //textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          )),
                    ],
                  )
                ]),

            color: Colors.white,
            shadowColor: Colors.lightBlue,
            elevation: 5.0,
            //margin: EdgeInsets.all(15.0),
            margin:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
          );
        });
  }

  Widget _basicRechargeSubscriptionListView(BuildContext context,
      List<MostRecentQuickRechargeSubscriptionList> basicList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: basicList.length,
        itemBuilder: (BuildContext ctx, int index) {
          //return new Text(listItem[index]);

          String productType = basicList
              .elementAt(index)
              .broadcasterName!;
          String productName = basicList
              .elementAt(index)
              .productName!;
          bool? status = basicList
              .elementAt(index)
              .isActive;

          double amount = basicList
              .elementAt(index)
              .price!;
          double monthlyPrice = basicList
              .elementAt(index)
              .monthlyPrice!;

          bool isTaxIncluded = basicList
              .elementAt(index)
              .isTaxIncluded!;
          String subscriptionTypeName =
          basicList
              .elementAt(index)
              .subscriptionTypeName!;
          // String strsubscriptionTypeName = subscriptionTypeName.toString();
          String taxIncludeValue = "";
          DateTime startDate =
          DateTime.parse(basicList
              .elementAt(index)
              .startDate!);
          DateTime endDate = DateTime.parse(basicList
              .elementAt(index)
              .endDate!);
          DateTime now = DateTime.now();

          String startFormattedDate =
          DateFormat('dd-MMM-yyyy').format(startDate);
          String endtFormattedDate = DateFormat('dd-MMM-yyyy').format(endDate);
          final difference = endDate
              .difference(now)
              .inDays;
          String expire = 'Expires in ' + difference.toString() + ' days';
          //bool isActive = productInfoQuickRechargeSubscription.elementAt(index).isActive;
          // String alert = isActive ? 'Active' : 'In Active';

          if (isTaxIncluded) {
            taxIncludeValue = "";
          } else {
            taxIncludeValue = "";
          }

          int ind = index;
          return new Card(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                      child: Row(children: [
                        Container(
                          child: Icon(Icons.network_cell),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Container(
                        //   child: Text('Hello'),
                        // )
                      ]),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  //color: Color(0xffDADADA),
                                  child: Text(
                                    productType,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.only(top: 5, right: 10),
                                color: Color(0xffDADADA),
                                child: Text(
                                  '\u{20B9} ${monthlyPrice}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Bold'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),*/
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  color: Colors.white,
                                  child: Text(
                                    subscriptionTypeName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  '\u{20B9} ${amount}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_regular'),
                                  //textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, top: 5, bottom: 5),
                                  color: Colors.white,
                                  child: Text(
                                    startFormattedDate,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, bottom: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  endtFormattedDate,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Regular'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])
                ]),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 5.0,
            //margin: EdgeInsets.all(15.0),
            margin:
            EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
          );
        });
  }

  Widget _addOnRechargeSubscriptionListView(BuildContext context,
      List<MostRecentQuickRechargeSubscriptionList> addOnList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: addOnList.length,
        itemBuilder: (BuildContext ctx, int index) {
          //return new Text(listItem[index]);

          String productType = addOnList
              .elementAt(index)
              .broadcasterName!;
          String productName = addOnList
              .elementAt(index)
              .productName!;
          bool? status = addOnList
              .elementAt(index)
              .isActive;

          double amount = addOnList
              .elementAt(index)
              .price!;
          double monthlyPrice = addOnList
              .elementAt(index)
              .monthlyPrice!;

          bool isTaxIncluded = addOnList
              .elementAt(index)
              .isTaxIncluded!;
          String subscriptionTypeName =
          addOnList
              .elementAt(index)
              .subscriptionTypeName!;
          // String strsubscriptionTypeName = subscriptionTypeName.toString();
          String taxIncludeValue = "";
          DateTime startDate =
          DateTime.parse(addOnList
              .elementAt(index)
              .startDate!);
          DateTime endDate = DateTime.parse(addOnList
              .elementAt(index)
              .endDate!);
          DateTime now = DateTime.now();

          String startFormattedDate =
          DateFormat('dd-MMM-yyyy').format(startDate);
          String endtFormattedDate = DateFormat('dd-MMM-yyyy').format(endDate);
          final difference = endDate
              .difference(now)
              .inDays;
          String expire = 'Expires in ' + difference.toString() + ' days';
          //bool isActive = productInfoQuickRechargeSubscription.elementAt(index).isActive;
          // String alert = isActive ? 'Active' : 'In Active';

          if (isTaxIncluded) {
            taxIncludeValue = "";
          } else {
            taxIncludeValue = "";
          }

          int ind = index;
          return new Card(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                      child: Row(children: [
                        Container(
                          child: Icon(Icons.network_cell),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Container(
                        //   child: Text('Hello'),
                        // )
                      ]),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  //color: Color(0xffDADADA),
                                  child: Text(
                                    productType,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.only(top: 5, right: 10),
                                color: Color(0xffDADADA),
                                child: Text(
                                  '\u{20B9} ${monthlyPrice}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Bold'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),*/
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  color: Colors.white,
                                  child: Text(
                                    subscriptionTypeName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  '\u{20B9} ${amount}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_regular'),
                                  //textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, top: 5, bottom: 5),
                                  color: Colors.white,
                                  child: Text(
                                    startFormattedDate,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, bottom: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  endtFormattedDate,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Regular'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])
                ]),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 5.0,
            //margin: EdgeInsets.all(15.0),
            margin:
            EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
          );
        });
  }

  Widget _aLaCarteRechargeSubscriptionListView(BuildContext context,
      List<MostRecentQuickRechargeSubscriptionList> alaCarteList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: alaCarteList.length,
        itemBuilder: (BuildContext ctx, int index) {
          //return new Text(listItem[index]);

          String productType = alaCarteList
              .elementAt(index)
              .broadcasterName!;
          String productName = alaCarteList
              .elementAt(index)
              .productName!;
          bool? status = alaCarteList
              .elementAt(index)
              .isActive;

          double amount = alaCarteList
              .elementAt(index)
              .price!;
          double monthlyPrice = alaCarteList
              .elementAt(index)
              .monthlyPrice!;

          bool isTaxIncluded = alaCarteList
              .elementAt(index)
              .isTaxIncluded!;
          String subscriptionTypeName =
          alaCarteList
              .elementAt(index)
              .subscriptionTypeName!;
          // String strsubscriptionTypeName = subscriptionTypeName.toString();
          String taxIncludeValue = "";
          DateTime startDate =
          DateTime.parse(alaCarteList
              .elementAt(index)
              .startDate!);
          DateTime endDate =
          DateTime.parse(alaCarteList
              .elementAt(index)
              .endDate!);
          DateTime now = DateTime.now();

          String startFormattedDate =
          DateFormat('dd-MMM-yyyy').format(startDate);
          String endtFormattedDate = DateFormat('dd-MMM-yyyy').format(endDate);
          final difference = endDate
              .difference(now)
              .inDays;
          String expire = 'Expires in ' + difference.toString() + ' days';
          //bool isActive = productInfoQuickRechargeSubscription.elementAt(index).isActive;
          // String alert = isActive ? 'Active' : 'In Active';

          if (isTaxIncluded) {
            taxIncludeValue = "";
          } else {
            taxIncludeValue = "";
          }

          int ind = index;
          return new Card(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                      child: Row(children: [
                        Container(
                          child: Icon(Icons.network_cell),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Container(
                        //   child: Text('Hello'),
                        // )
                      ]),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  //color: Color(0xffDADADA),
                                  child: Text(
                                    productType,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.only(top: 5, right: 10),
                                color: Color(0xffDADADA),
                                child: Text(
                                  '\u{20B9} ${monthlyPrice}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Bold'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),*/
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5),
                                  color: Colors.white,
                                  child: Text(
                                    subscriptionTypeName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  '\u{20B9} ${amount}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_regular'),
                                  //textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, top: 5, bottom: 5),
                                  color: Colors.white,
                                  child: Text(
                                    startFormattedDate,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff333333),
                                        fontFamily: 'Roboto_Regular'),
                                    //textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 5, bottom: 5, right: 10),
                                color: Colors.white,
                                child: Text(
                                  endtFormattedDate,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333),
                                      fontFamily: 'Roboto_Regular'),
                                  // textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])
                ]),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 5.0,
            //margin: EdgeInsets.all(15.0),
            margin:
            EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
          );
        });
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
