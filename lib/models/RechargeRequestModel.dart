// To parse this JSON data, do
//
//     final rechargeRequest = rechargeRequestFromJson(jsonString);

import 'dart:convert';

RechargeRequest rechargeRequestFromJson(String str) => RechargeRequest.fromJson(json.decode(str));

String rechargeRequestToJson(RechargeRequest data) => json.encode(data.toJson());

class RechargeRequest {
  RechargeRequest({
    required this.tokenId,
    required this.productObj,
    required this.subsId,
    required this.encdvcId,
    required this.isQuickRecharge,
    required this.latestSubsTranId,
    required this.cashReceivedAmount,
    required this.walletRechargeStatus,
    required this.pageName,
  });

  String tokenId;
  late ProductObj productObj;
  String subsId;
  String encdvcId;
  bool isQuickRecharge;
  int latestSubsTranId;
  double cashReceivedAmount;
  bool walletRechargeStatus;
  String pageName;

  factory RechargeRequest.fromJson(Map<String, dynamic> json) => RechargeRequest(
    tokenId: json["tokenId"],
    productObj: ProductObj.fromJson(json["productObj"]),
    subsId: json["subsId"],
    encdvcId: json["encdvcId"],
    isQuickRecharge: json["isQuickRecharge"],
    latestSubsTranId: json["latestSubsTranId"],
    cashReceivedAmount: json["cashReceivedAmount"],
    walletRechargeStatus: json["walletRechargeStatus"],
    pageName: json["pageName"],
  );

  Map<String, dynamic> toJson() => {
    "tokenId": tokenId,
    "productObj": productObj.toJson(),
    "subsId": subsId,
    "encdvcId": encdvcId,
    "isQuickRecharge": isQuickRecharge,
    "latestSubsTranId": latestSubsTranId,
    "cashReceivedAmount": cashReceivedAmount,
    "walletRechargeStatus": walletRechargeStatus,
    "pageName": pageName,
  };
}

class ProductObj {
  ProductObj({
    required this.basicPacks,
    required this.addOnPacks,
    required this.channelPacks,
    required this.discontinuedPacks,
    required this.isCreditLimitUsed,
    required this.isBulkRecharge,
    required this.cashReceived,
  });

  List<BasicPack> basicPacks;
  List<BasicPack> addOnPacks;
  List<BasicPack> channelPacks;
  List<BasicPack> discontinuedPacks;
  bool isCreditLimitUsed;
  bool isBulkRecharge;
  double cashReceived;

  factory ProductObj.fromJson(Map<String, dynamic> json) => ProductObj(
    basicPacks: List<BasicPack>.from(json["basicPacks"].map((x) => BasicPack.fromJson(x))),
    addOnPacks: List<BasicPack>.from(json["addOnPacks"].map((x) => x)),
    channelPacks: List<BasicPack>.from(json["channelPacks"].map((x) => x)),
    discontinuedPacks: List<BasicPack>.from(json["discontinuedPacks"].map((x) => x)),
    isCreditLimitUsed: json["isCreditLimitUsed"],
    isBulkRecharge: json["isBulkRecharge"],
    cashReceived: json["cashReceived"],
  );

  Map<String, dynamic> toJson() => {
    "basicPacks": List<dynamic>.from(basicPacks.map((x) => x.toJson())),
    "addOnPacks": List<dynamic>.from(addOnPacks.map((x) => x)),
    "channelPacks": List<dynamic>.from(channelPacks.map((x) => x)),
    "discontinuedPacks": List<dynamic>.from(discontinuedPacks.map((x) => x)),
    "isCreditLimitUsed": isCreditLimitUsed,
    "isBulkRecharge": isBulkRecharge,
    "cashReceived": cashReceived,
  };
}

class BasicPack {
  BasicPack({
    required this.productId,
    required this.startDate,
    required this.endDate,
    required this.subsTypeId,
    required this.subsVal,
    required this.packageType,
    required this.isDiscontinued,
    required this.prdSubscriptionId,
    required this.promotionId,
  });

  int productId;
  String startDate;
  String endDate;
  int subsTypeId;
  int subsVal;
  int packageType;
  bool isDiscontinued;
  int prdSubscriptionId;
  int promotionId;

  factory BasicPack.fromJson(Map<String, dynamic> json) => BasicPack(
    productId: json["productId"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    subsTypeId: json["subsTypeId"],
    subsVal: json["subsVal"],
    packageType: json["packageType"],
    isDiscontinued: json["isDiscontinued"],
    prdSubscriptionId: json["prdSubscriptionId"],
    promotionId: json["promotionId"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "startDate": startDate,
    "endDate": endDate,
    "subsTypeId": subsTypeId,
    "subsVal": subsVal,
    "packageType": packageType,
    "isDiscontinued": isDiscontinued,
    "prdSubscriptionId": prdSubscriptionId,
    "promotionId": promotionId,
  };
}
