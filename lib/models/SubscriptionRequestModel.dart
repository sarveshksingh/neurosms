// To parse this JSON data, do
//
//     final subscriptionRequestModel = subscriptionRequestModelFromJson(jsonString);

import 'dart:convert';

import 'SubscriptionModel.dart';

SubscriptionRequestModel subscriptionRequestModelFromJson(String str) => SubscriptionRequestModel.fromJson(json.decode(str));

String subscriptionRequestModelToJson(SubscriptionRequestModel data) => json.encode(data.toJson());

class SubscriptionRequestModel {
  SubscriptionRequestModel({
    required this.tokenId,
    required this.subsId,
    required this.encdvcId,
    required this.packageList,
    required this.channelList,
    required this.taxList,
    required this.mostRecentSubscriptionList,
    required this.newProductInfoObj,
    required this.subscriptionRechargeCalculationObj,
    required this.pageName,
  });

  String tokenId;
  String subsId;
  String encdvcId;
  List<dynamic> packageList;
  List<dynamic> channelList;
  List<dynamic> taxList;
  List<MostRecentSubscriptionList> mostRecentSubscriptionList;
  NewProductInfoReqObj newProductInfoObj;
  SubscriptionRechargeCalculationReqObj subscriptionRechargeCalculationObj;
  String pageName;

  factory SubscriptionRequestModel.fromJson(Map<String, dynamic> json) => SubscriptionRequestModel(
    tokenId: json["tokenId"],
    subsId: json["subsId"],
    encdvcId: json["encdvcId"],
    packageList: List<dynamic>.from(json["packageList"].map((x) => x)),
    channelList: List<dynamic>.from(json["channelList"].map((x) => x)),
    taxList: List<dynamic>.from(json["taxList"].map((x) => x)),
    mostRecentSubscriptionList: List<MostRecentSubscriptionList>.from(json["mostRecentSubscriptionList"].map((x) => MostRecentSubscriptionList.fromJson(x))),
    newProductInfoObj: NewProductInfoReqObj.fromJson(json["newProductInfoObj"]),
    subscriptionRechargeCalculationObj: SubscriptionRechargeCalculationReqObj.fromJson(json["subscriptionRechargeCalculationObj"]),
    pageName: json["pageName"],
  );

  Map<String, dynamic> toJson() => {
    "tokenId": tokenId,
    "subsId": subsId,
    "encdvcId": encdvcId,
    "packageList": List<dynamic>.from(packageList.map((x) => x)),
    "channelList": List<dynamic>.from(channelList.map((x) => x)),
    "taxList": List<dynamic>.from(taxList.map((x) => x)),
    "mostRecentSubscriptionList": List<dynamic>.from(mostRecentSubscriptionList.map((x) => x.toJson())),
    "newProductInfoObj": newProductInfoObj.toJson(),
    "subscriptionRechargeCalculationObj": subscriptionRechargeCalculationObj.toJson(),
    "pageName": pageName,
  };
}

class MostRecentSubscriptionReqList {
  MostRecentSubscriptionReqList({
    required this.msoId,
    required this.productSubscriptionId,
    required this.productId,
    required this.productName,
    required this.broadcasterName,
    required this.startDate,
    required this.endDate,
    required this.packageType,
    required this.channelCount,
    required this.subsTypeId,
    required this.subsVal,
    required this.subscriptionTypeName,
    required this.price,
    required this.monthlyPrice,
    required this.logo,
    required this.isActive,
    required this.taxIncluded,
    required this.isProductRefundable,
    required this.noOfDaysInMonth,
    required this.transactionId,
    required this.createdDate,
    required this.promotionId,
    required this.promotionType,
    required this.promotionText,
    required this.refundableAmount,
    required this.isDiscontinue,
  });

  String msoId;
  int productSubscriptionId;
  int productId;
  String productName;
  String broadcasterName;
  DateTime startDate;
  DateTime endDate;
  int packageType;
  int channelCount;
  int subsTypeId;
  int subsVal;
  String subscriptionTypeName;
  double price;
  int monthlyPrice;
  String logo;
  bool isActive;
  bool taxIncluded;
  bool isProductRefundable;
  int noOfDaysInMonth;
  int transactionId;
  DateTime createdDate;
  int promotionId;
  String promotionType;
  String promotionText;
  double refundableAmount;
  bool isDiscontinue;

  factory MostRecentSubscriptionReqList.fromJson(Map<String, dynamic> json) => MostRecentSubscriptionReqList(
    msoId: json["msoId"],
    productSubscriptionId: json["productSubscriptionId"],
    productId: json["productId"],
    productName: json["productName"],
    broadcasterName: json["broadcasterName"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    packageType: json["packageType"],
    channelCount: json["channelCount"],
    subsTypeId: json["subsTypeId"],
    subsVal: json["subsVal"],
    subscriptionTypeName: json["subscriptionTypeName"],
    price: json["price"].toDouble(),
    monthlyPrice: json["monthlyPrice"],
    logo: json["logo"],
    isActive: json["isActive"],
    taxIncluded: json["taxIncluded"],
    isProductRefundable: json["isProductRefundable"],
    noOfDaysInMonth: json["noOfDaysInMonth"],
    transactionId: json["transactionId"],
    createdDate: DateTime.parse(json["createdDate"]),
    promotionId: json["promotionId"],
    promotionType: json["promotionType"],
    promotionText: json["promotionText"],
    refundableAmount: json["refundableAmount"].toDouble(),
    isDiscontinue: json["isDiscontinue"],
  );

  Map<String, dynamic> toJson() => {
    "msoId": msoId,
    "productSubscriptionId": productSubscriptionId,
    "productId": productId,
    "productName": productName,
    "broadcasterName": broadcasterName,
    "startDate": startDate,
    "endDate": endDate,
    "packageType": packageType,
    "channelCount": channelCount,
    "subsTypeId": subsTypeId,
    "subsVal": subsVal,
    "subscriptionTypeName": subscriptionTypeName,
    "price": price,
    "monthlyPrice": monthlyPrice,
    "logo": logo,
    "isActive": isActive,
    "taxIncluded": taxIncluded,
    "isProductRefundable": isProductRefundable,
    "noOfDaysInMonth": noOfDaysInMonth,
    "transactionId": transactionId,
    "createdDate": createdDate.toIso8601String(),
    "promotionId": promotionId,
    "promotionType": promotionType,
    "promotionText": promotionText,
    "refundableAmount": refundableAmount,
    "isDiscontinue": isDiscontinue,
  };
}

class NewProductInfoReqObj {
  NewProductInfoReqObj({
    required this.basicpackageSubscriptionList,
    required this.addOnpackageSubscriptionList,
    required this.channelSubscriptionList,
  });

  List<PackageList> basicpackageSubscriptionList;
  List<PackageList> addOnpackageSubscriptionList;
  List<ChannelList> channelSubscriptionList;

  factory NewProductInfoReqObj.fromJson(Map<String, dynamic> json) => NewProductInfoReqObj(
    basicpackageSubscriptionList: List<PackageList>.from(json["basicpackageSubscriptionList"].map((x) => PackageList.fromJson(x))),
    addOnpackageSubscriptionList: List<PackageList>.from(json["addOnpackageSubscriptionList"].map((x) => x)),
    channelSubscriptionList: List<ChannelList>.from(json["channelSubscriptionList"].map((x) => ChannelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "basicpackageSubscriptionList": List<dynamic>.from(basicpackageSubscriptionList.map((x) => x.toJson())),
    "addOnpackageSubscriptionList": List<dynamic>.from(addOnpackageSubscriptionList.map((x) => x)),
    "channelSubscriptionList": List<dynamic>.from(channelSubscriptionList.map((x) => x.toJson())),
  };
}

class SBasicpackageSubscriptionList {
  SBasicpackageSubscriptionList({
    required this.packageId,
    required this.packageName,
    required this.packageMonthlyPrice,
    required this.packageSubscriptionPrice,
    required this.broadCasterId,
    required this.broadCasterName,
    required this.packageType,
    required this.subscriptionTypeId,
    required this.subscriptionTypeName,
    required this.subscriptionValue,
    required this.packageStatus,
    required this.startDate,
    required this.endDate,
    required this.expiryInDays,
    required this.message,
    required this.channelCount,
    required this.taxIncluded,
    required this.choice,
  });

  int packageId;
  String packageName;
  int packageMonthlyPrice;
  int packageSubscriptionPrice;
  int broadCasterId;
  String broadCasterName;
  int packageType;
  int subscriptionTypeId;
  String subscriptionTypeName;
  int subscriptionValue;
  bool packageStatus;
  DateTime startDate;
  DateTime endDate;
  int expiryInDays;
  String message;
  int channelCount;
  bool taxIncluded;
  int choice;

  factory SBasicpackageSubscriptionList.fromJson(Map<String, dynamic> json) => SBasicpackageSubscriptionList(
    packageId: json["packageId"],
    packageName: json["packageName"],
    packageMonthlyPrice: json["packageMonthlyPrice"],
    packageSubscriptionPrice: json["packageSubscriptionPrice"],
    broadCasterId: json["broadCasterId"],
    broadCasterName: json["broadCasterName"],
    packageType: json["packageType"],
    subscriptionTypeId: json["subscriptionTypeId"],
    subscriptionTypeName: json["subscriptionTypeName"],
    subscriptionValue: json["subscriptionValue"],
    packageStatus: json["packageStatus"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    expiryInDays: json["expiryInDays"],
    message: json["message"],
    channelCount: json["channelCount"],
    taxIncluded: json["taxIncluded"],
    choice: json["choice"],
  );

  Map<String, dynamic> toJson() => {
    "packageId": packageId,
    "packageName": packageName,
    "packageMonthlyPrice": packageMonthlyPrice,
    "packageSubscriptionPrice": packageSubscriptionPrice,
    "broadCasterId": broadCasterId,
    "broadCasterName": broadCasterName,
    "packageType": packageType,
    "subscriptionTypeId": subscriptionTypeId,
    "subscriptionTypeName": subscriptionTypeName,
    "subscriptionValue": subscriptionValue,
    "packageStatus": packageStatus,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "expiryInDays": expiryInDays,
    "message": message,
    "channelCount": channelCount,
    "taxIncluded": taxIncluded,
    "choice": choice,
  };
}

class SChannelSubscriptionList {
  SChannelSubscriptionList({
    required this.msoId,
    required this.channelId,
    required this.eChannelId,
    required this.channelPriceSettingId,
    required this.channelName,
    required this.channelLanguage,
    required this.channelMonthlyPrice,
    required this.broadCasterId,
    required this.broadCasterName,
    required this.isAlaCart,
    required this.logo,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.subscriptionTypeId,
    required this.subscriptionTypeName,
    required this.subscriptionValue,
    required this.packageStatus,
    required this.expiryInDays,
    required this.channelCatName,
    required this.channelSignalName,
    required this.message,
    required this.taxIncluded,
  });

  String msoId;
  int channelId;
  String eChannelId;
  int channelPriceSettingId;
  String channelName;
  String channelLanguage;
  int channelMonthlyPrice;
  int broadCasterId;
  String broadCasterName;
  bool isAlaCart;
  String logo;
  String description;
  DateTime startDate;
  DateTime endDate;
  int subscriptionTypeId;
  String subscriptionTypeName;
  int subscriptionValue;
  bool packageStatus;
  int expiryInDays;
  String channelCatName;
  String channelSignalName;
  String message;
  bool taxIncluded;

  factory SChannelSubscriptionList.fromJson(Map<String, dynamic> json) => SChannelSubscriptionList(
    msoId: json["msoId"],
    channelId: json["channelId"],
    eChannelId: json["eChannelId"],
    channelPriceSettingId: json["channelPriceSettingId"],
    channelName: json["channelName"],
    channelLanguage: json["channelLanguage"],
    channelMonthlyPrice: json["channelMonthlyPrice"],
    broadCasterId: json["broadCasterId"],
    broadCasterName: json["broadCasterName"],
    isAlaCart: json["isAlaCart"],
    logo: json["logo"],
    description: json["description"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    subscriptionTypeId: json["subscriptionTypeId"],
    subscriptionTypeName: json["subscriptionTypeName"],
    subscriptionValue: json["subscriptionValue"],
    packageStatus: json["packageStatus"],
    expiryInDays: json["expiryInDays"],
    channelCatName: json["channelCatName"],
    channelSignalName: json["channelSignalName"],
    message: json["message"],
    taxIncluded: json["taxIncluded"],
  );

  Map<String, dynamic> toJson() => {
    "msoId": msoId,
    "channelId": channelId,
    "eChannelId": eChannelId,
    "channelPriceSettingId": channelPriceSettingId,
    "channelName": channelName,
    "channelLanguage": channelLanguage,
    "channelMonthlyPrice": channelMonthlyPrice,
    "broadCasterId": broadCasterId,
    "broadCasterName": broadCasterName,
    "isAlaCart": isAlaCart,
    "logo": logo,
    "description": description,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "subscriptionTypeId": subscriptionTypeId,
    "subscriptionTypeName": subscriptionTypeName,
    "subscriptionValue": subscriptionValue,
    "packageStatus": packageStatus,
    "expiryInDays": expiryInDays,
    "channelCatName": channelCatName,
    "channelSignalName": channelSignalName,
    "message": message,
    "taxIncluded": taxIncluded,
  };
}

class SubscriptionRechargeCalculationReqObj {
  SubscriptionRechargeCalculationReqObj();

  factory SubscriptionRechargeCalculationReqObj.fromJson(Map<String, dynamic> json) => SubscriptionRechargeCalculationReqObj(
  );

  Map<String, dynamic> toJson() => {
  };
}
