// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  SubscriptionModel({
    required this.status,
    required this.msg,
    required this.returnUrl,
    required this.manualSubsObj,
  });

  num status;
  String msg;
  String returnUrl;
  ManualSubsObj manualSubsObj;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        status: json["status"],
        msg: json["msg"],
        returnUrl: json["returnUrl"],
        manualSubsObj: ManualSubsObj.fromJson(json["manualSubsObj"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "returnUrl": returnUrl,
        "manualSubsObj": manualSubsObj.toJson(),
      };
}

class ManualSubsObj {
  ManualSubsObj({
    required this.tokenId,
    required this.subsId,
    required this.encdvcId,
    required this.basicpackageList,
    required this.addOnpackageList,
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
  List<PackageList> basicpackageList;
  List<PackageList> addOnpackageList;
  List<ChannelList> channelList;
  List<dynamic> taxList;
  List<MostRecentSubscriptionList> mostRecentSubscriptionList;
  NewProductInfoObj newProductInfoObj;
  SubscriptionRechargeCalculationObj subscriptionRechargeCalculationObj;
  String pageName;

  factory ManualSubsObj.fromJson(Map<String, dynamic> json) => ManualSubsObj(
        tokenId: json["tokenId"],
        subsId: json["subsId"],
        encdvcId: json["encdvcId"],
        basicpackageList: List<PackageList>.from(
            json["basicpackageList"].map((x) => PackageList.fromJson(x))),
        addOnpackageList: List<PackageList>.from(
            json["addOnpackageList"].map((x) => PackageList.fromJson(x))),
        channelList: List<ChannelList>.from(
            json["channelList"].map((x) => ChannelList.fromJson(x))),
        taxList: List<dynamic>.from(json["taxList"].map((x) => x)),
        mostRecentSubscriptionList: List<MostRecentSubscriptionList>.from(
            json["mostRecentSubscriptionList"]
                .map((x) => MostRecentSubscriptionList.fromJson(x))),
        newProductInfoObj:
            NewProductInfoObj.fromJson(json["newProductInfoObj"]),
        subscriptionRechargeCalculationObj:
            SubscriptionRechargeCalculationObj.fromJson(
                json["subscriptionRechargeCalculationObj"]),
        pageName: json["pageName"],
      );

  Map<String, dynamic> toJson() => {
        "tokenId": tokenId,
        "subsId": subsId,
        "encdvcId": encdvcId,
        "basicpackageList":
            List<dynamic>.from(basicpackageList.map((x) => x.toJson())),
        "addOnpackageList":
            List<dynamic>.from(addOnpackageList.map((x) => x.toJson())),
        "channelList": List<dynamic>.from(channelList.map((x) => x.toJson())),
        "taxList": List<dynamic>.from(taxList.map((x) => x)),
        "mostRecentSubscriptionList": List<dynamic>.from(
            mostRecentSubscriptionList.map((x) => x.toJson())),
        "newProductInfoObj": newProductInfoObj.toJson(),
        "subscriptionRechargeCalculationObj":
            subscriptionRechargeCalculationObj.toJson(),
        "pageName": pageName,
      };
}

class PackageList {
  PackageList({
    required this.packageId,
    required this.ePackageId,
    required this.packagePriceSettingId,
    required this.packageName,
    required this.packagePrice,
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
    required this.packageList,
    required this.promotionList,
  });

  num packageId;
  String? ePackageId;
  num packagePriceSettingId;
  String? packageName;
  num packagePrice;
  num broadCasterId;
  String? broadCasterName;
  num packageType;
  num subscriptionTypeId;
  String? subscriptionTypeName;
  num subscriptionValue;
  bool packageStatus;
  String? startDate;
  String? endDate;
  num expiryInDays;
  String? message;
  num channelCount;
  bool taxIncluded;
  num choice;
  List<dynamic> packageList;
  List<dynamic> promotionList;

  factory PackageList.fromJson(Map<String, dynamic> json) => PackageList(
        packageId: json["packageId"],
        ePackageId: json["ePackageId"],
        packagePriceSettingId: json["packagePriceSettingId"],
        packageName: json["packageName"],
        packagePrice: json["packagePrice"],
        broadCasterId: json["broadCasterId"],
        broadCasterName:
            json["broadCasterName"] == null ? null : json["broadCasterName"],
        packageType: json["packageType"],
        subscriptionTypeId: json["subscriptionTypeId"],
        subscriptionTypeName: json["subscriptionTypeName"],
        subscriptionValue: json["subscriptionValue"],
        packageStatus: json["packageStatus"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        expiryInDays: json["expiryInDays"],
        message: json["message"],
        channelCount: json["channelCount"],
        taxIncluded: json["taxIncluded"],
        choice: json["choice"],
        packageList: List<dynamic>.from(json["packageList"].map((x) => x)),
        promotionList: List<dynamic>.from(json["promotionList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "ePackageId": ePackageId,
        "packagePriceSettingId": packagePriceSettingId,
        "packageName": packageName,
        "packagePrice": packagePrice,
        "broadCasterId": broadCasterId,
        "broadCasterName": broadCasterName == null ? null : broadCasterName,
        "packageType": packageType,
        "subscriptionTypeId": subscriptionTypeId,
        "subscriptionTypeName": subscriptionTypeName,
        "subscriptionValue": subscriptionValue,
        "packageStatus": packageStatus,
        "startDate": startDate,
        "endDate": endDate,
        "expiryInDays": expiryInDays,
        "message": message,
        "channelCount": channelCount,
        "taxIncluded": taxIncluded,
        "choice": choice,
        "packageList": List<dynamic>.from(packageList.map((x) => x)),
        "promotionList": List<dynamic>.from(promotionList.map((x) => x)),
      };
}

/*enum Message { EMPTY, YES }

final messageValues = EnumValues({"": Message.EMPTY, "yes": Message.YES});*/

class ChannelList {
  ChannelList({
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
    required this.channelList,
    required this.promotionList,
  });

  String? msoId;
  num channelId;
  String? eChannelId;
  num channelPriceSettingId;
  String? channelName;
  String? channelLanguage;
  num channelMonthlyPrice;
  num broadCasterId;
  String? broadCasterName;
  bool isAlaCart;
  String? logo;
  String? description;
  String? startDate;
  String? endDate;
  num subscriptionTypeId;
  String? subscriptionTypeName;
  num subscriptionValue;
  bool packageStatus;
  num expiryInDays;
  String? channelCatName;
  String? channelSignalName;
  String? message;
  bool taxIncluded;
  List<dynamic> channelList;
  List<dynamic> promotionList;

  factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
        msoId: json["msoId"] == null ? null : json["msoId"],
        channelId: json["channelId"],
        eChannelId: json["eChannelId"],
        channelPriceSettingId: json["channelPriceSettingId"],
        channelName: json["channelName"],
        channelLanguage: json["channelLanguage"],
        channelMonthlyPrice: json["channelMonthlyPrice"],
        broadCasterId: json["broadCasterId"],
        broadCasterName: json["broadCasterName"],
        isAlaCart: json["isAlaCart"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        subscriptionTypeId: json["subscriptionTypeId"],
        subscriptionTypeName: json["subscriptionTypeName"],
        subscriptionValue: json["subscriptionValue"],
        packageStatus: json["packageStatus"],
        expiryInDays: json["expiryInDays"],
        channelCatName: json["channelCatName"],
        channelSignalName: json["channelSignalName"],
        message: json["message"],
        taxIncluded: json["taxIncluded"],
        channelList: List<dynamic>.from(json["channelList"].map((x) => x)),
        promotionList: List<dynamic>.from(json["promotionList"].map((x) => x)),
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
        "broadCasterName": broadCasterName == null ? null : broadCasterName,
        "isAlaCart": isAlaCart,
        "logo": logo,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "subscriptionTypeId": subscriptionTypeId,
        "subscriptionTypeName": subscriptionTypeName,
        "subscriptionValue": subscriptionValue,
        "packageStatus": packageStatus,
        "expiryInDays": expiryInDays,
        "channelCatName": channelCatName,
        "channelSignalName": channelSignalName,
        "message": message,
        "taxIncluded": taxIncluded,
        "channelList": List<dynamic>.from(channelList.map((x) => x)),
        "promotionList": List<dynamic>.from(promotionList.map((x) => x)),
      };
}

/*enum BroadcasterName {
  ZEE_ENTERTAINMENT_ENTERPRISES_LIMITED,
  TV_TODAY_NETWORK_LTD,
  DISCOVERY_COMMUNICATIONS_INDIA,
  IN10_MEDIA_PVT_LTD,
  BENNETT_COLEMAN_COMPANY_LIMITED,
  SONY_PICTURES_NETWORKS_INDIA_PRIVATE_LIMITED,
  FREE_TO_AIR
}

final broadcasterNameValues = EnumValues({
  "Bennett, Coleman & Company Limited":
      BroadcasterName.BENNETT_COLEMAN_COMPANY_LIMITED,
  "Discovery Communications India":
      BroadcasterName.DISCOVERY_COMMUNICATIONS_INDIA,
  "Free To Air": BroadcasterName.FREE_TO_AIR,
  "IN10 MEDIA PVT.LTD": BroadcasterName.IN10_MEDIA_PVT_LTD,
  "Sony Pictures Networks India Private Limited":
      BroadcasterName.SONY_PICTURES_NETWORKS_INDIA_PRIVATE_LIMITED,
  "TV Today Network Ltd.": BroadcasterName.TV_TODAY_NETWORK_LTD,
  "Zee Entertainment Enterprises Limited":
      BroadcasterName.ZEE_ENTERTAINMENT_ENTERPRISES_LIMITED
});*/

/*enum ChannelSignalName { SD, HD }

final channelSignalNameValues =
    EnumValues({"HD": ChannelSignalName.HD, "SD": ChannelSignalName.SD});*/

/*enum MsoId { THE_00090007 }

final msoIdValues = EnumValues({
  "0009-0007": MsoId.THE_00090007
});*/

class MostRecentSubscriptionList {
  MostRecentSubscriptionList({
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

  String? msoId;
  num productSubscriptionId;
  num productId;
  String? productName;
  String? broadcasterName;
  String? startDate;
  String? endDate;
  num packageType;
  num channelCount;
  num subsTypeId;
  num subsVal;
  String? subscriptionTypeName;
  num price;
  num monthlyPrice;
  String? logo;
  bool isActive;
  bool taxIncluded;
  bool isProductRefundable;
  num noOfDaysInMonth;
  num transactionId;
  String? createdDate;
  num promotionId;
  String? promotionType;
  String? promotionText;
  num refundableAmount;
  bool isDiscontinue;

  factory MostRecentSubscriptionList.fromJson(Map<String, dynamic> json) =>
      MostRecentSubscriptionList(
        msoId: json["msoId"],
        productSubscriptionId: json["productSubscriptionId"],
        productId: json["productId"],
        productName: json["productName"],
        broadcasterName: json["broadcasterName"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        packageType: json["packageType"],
        channelCount: json["channelCount"],
        subsTypeId: json["subsTypeId"],
        subsVal: json["subsVal"],
        subscriptionTypeName: json["subscriptionTypeName"],
        price: json["price"],
        monthlyPrice: json["monthlyPrice"],
        logo: json["logo"],
        isActive: json["isActive"],
        taxIncluded: json["taxIncluded"],
        isProductRefundable: json["isProductRefundable"],
        noOfDaysInMonth: json["noOfDaysInMonth"],
        transactionId: json["transactionId"],
        createdDate: json["createdDate"],
        promotionId: json["promotionId"],
        promotionType: json["promotionType"],
        promotionText: json["promotionText"],
        refundableAmount: json["refundableAmount"],
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
        "createdDate": createdDate,
        "promotionId": promotionId,
        "promotionType": promotionType,
        "promotionText": promotionText,
        "refundableAmount": refundableAmount,
        "isDiscontinue": isDiscontinue,
      };
}

class NewProductInfoObj {
  NewProductInfoObj({
    required this.basicpackageSubscriptionList,
    required this.addOnpackageSubscriptionList,
    required this.channelSubscriptionList,
  });

  List<AddOnpackageListElement> basicpackageSubscriptionList;
  List<AddOnpackageListElement> addOnpackageSubscriptionList;
  List<NChannelSubscriptionList> channelSubscriptionList;

  /*factory NewProductInfoObj.fromJson(Map<String, dynamic> json) =>
      NewProductInfoObj(
        basicpackageSubscriptionList: List<AddOnpackageListElement>.from(
            json["basicpackageSubscriptionList"].map((x) => x)),
        addOnpackageSubscriptionList: List<AddOnpackageListElement>.from(
            json["addOnpackageSubscriptionList"].map((x) => x)),
        channelSubscriptionList: List<ChannelSubscriptionList>.from(
            json["channelSubscriptionList"].map((x) => x)),
      );*/
  factory NewProductInfoObj.fromJson(Map<String, dynamic> json) =>
      NewProductInfoObj(
        basicpackageSubscriptionList: List<AddOnpackageListElement>.from(
            json["basicpackageSubscriptionList"]
                .map((x) => AddOnpackageListElement.fromJson(x))),
        addOnpackageSubscriptionList: List<AddOnpackageListElement>.from(
            json["addOnpackageSubscriptionList"]
                .map((x) => AddOnpackageListElement.fromJson(x))),
        channelSubscriptionList: List<NChannelSubscriptionList>.from(
            json["channelSubscriptionList"]
                .map((x) => NChannelSubscriptionList.fromJson(x))),
      );

  /*Map<String, dynamic> toJson() => {
        "basicpackageSubscriptionList":
            List<dynamic>.from(basicpackageSubscriptionList.map((x) => x)),
        "addOnpackageSubscriptionList":
            List<dynamic>.from(addOnpackageSubscriptionList.map((x) => x)),
        "channelSubscriptionList":
            List<dynamic>.from(channelSubscriptionList.map((x) => x)),
      };*/
  Map<String, dynamic> toJson() => {
        "basicpackageSubscriptionList": List<dynamic>.from(
            basicpackageSubscriptionList.map((x) => x.toJson())),
        "addOnpackageSubscriptionList": List<dynamic>.from(
            addOnpackageSubscriptionList.map((x) => x.toJson())),
        "channelSubscriptionList":
            List<dynamic>.from(channelSubscriptionList.map((x) => x.toJson())),
      };
}

class AddOnpackageListElement {
  AddOnpackageListElement({
    required this.packageId,
    required this.ePackageId,
    required this.packagePriceSettingId,
    required this.packageName,
    required this.packagePrice,
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
    // required this.packageList,
    // required this.promotionList,
    required this.packageMonthlyPrice,
    required this.packageSubscriptionPrice,
  });

  num packageId;
  String? ePackageId;
  num? packagePriceSettingId;
  String? packageName;
  num? packagePrice;
  num broadCasterId;
  String? broadCasterName;
  num packageType;
  num subscriptionTypeId;
  String? subscriptionTypeName;
  num subscriptionValue;
  bool packageStatus;
  DateTime startDate;
  DateTime endDate;
  num expiryInDays;
  String? message;
  num channelCount;
  bool taxIncluded;
  num choice;
  //List<dynamic> packageList;
  //List<dynamic> promotionList;
  num packageMonthlyPrice;
  num packageSubscriptionPrice;

  factory AddOnpackageListElement.fromJson(Map<String, dynamic> json) =>
      AddOnpackageListElement(
        packageId: json["packageId"],
        ePackageId: json["ePackageId"],
        packagePriceSettingId: json["packagePriceSettingId"],
        packageName: json["packageName"],
        packagePrice: json["packagePrice"],
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
        // packageList: List<dynamic>.from(json["packageList"].map((x) => x)),
        // promotionList: List<dynamic>.from(json["promotionList"].map((x) => x)),
        packageMonthlyPrice: json["packageMonthlyPrice"],
        packageSubscriptionPrice: json["packageSubscriptionPrice"],
      );

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "ePackageId": ePackageId,
        "packagePriceSettingId": packagePriceSettingId,
        "packageName": packageName,
        "packagePrice": packagePrice,
        "broadCasterId": broadCasterId,
        "broadCasterName": broadCasterName,
        "packageType": packageType,
        "subscriptionTypeId": subscriptionTypeId,
        "subscriptionTypeName": subscriptionTypeName,
        "subscriptionValue": subscriptionValue,
        "packageStatus": packageStatus,
        "startDate": startDate,
        "endDate": endDate,
        "expiryInDays": expiryInDays,
        "message": message,
        "channelCount": channelCount,
        "taxIncluded": taxIncluded,
        "choice": choice,
        // "packageList": packageList == null
        //     ? null
        //     : List<dynamic>.from(packageList.map((x) => x)),
        // "promotionList": promotionList == null
        //     ? null
        //     : List<dynamic>.from(promotionList.map((x) => x)),
        "packageMonthlyPrice": packageMonthlyPrice,
        "packageSubscriptionPrice": packageSubscriptionPrice,
      };
}

class NChannelSubscriptionList {
  NChannelSubscriptionList({
    required this.channelId,
    required this.channelName,
    required this.channelMonthlyPrice,
    required this.channelSubscriptionPrice,
    required this.broadCasterId,
    required this.broadCasterName,
    required this.channelType,
    required this.subscriptionTypeId,
    required this.subscriptionTypeName,
    required this.subscriptionValue,
    required this.channelStatus,
    required this.startDate,
    required this.endDate,
    required this.expiryInDays,
    required this.message,
    required this.taxIncluded,
    required this.choice,
  });

  num channelId;
  String? channelName;
  num channelMonthlyPrice;
  num channelSubscriptionPrice;
  num broadCasterId;
  String? broadCasterName;
  num channelType;
  num subscriptionTypeId;
  String? subscriptionTypeName;
  num subscriptionValue;
  bool channelStatus;
  DateTime startDate;
  DateTime endDate;
  num expiryInDays;
  String? message;
  bool taxIncluded;
  num choice;

  factory NChannelSubscriptionList.fromJson(Map<String, dynamic> json) =>
      NChannelSubscriptionList(
        channelId: json["channelId"],
        channelName: json["channelName"],
        channelMonthlyPrice: json["channelMonthlyPrice"],
        channelSubscriptionPrice: json["channelSubscriptionPrice"],
        broadCasterId: json["broadCasterId"],
        broadCasterName: json["broadCasterName"],
        channelType: json["channelType"],
        subscriptionTypeId: json["subscriptionTypeId"],
        subscriptionTypeName: json["subscriptionTypeName"],
        subscriptionValue: json["subscriptionValue"],
        channelStatus: json["channelStatus"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        expiryInDays: json["expiryInDays"],
        message: json["message"],
        taxIncluded: json["taxIncluded"],
        choice: json["choice"],
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "channelName": channelName,
        "channelMonthlyPrice": channelMonthlyPrice,
        "channelSubscriptionPrice": channelSubscriptionPrice,
        "broadCasterId": broadCasterId,
        "broadCasterName": broadCasterName,
        "channelType": channelType,
        "subscriptionTypeId": subscriptionTypeId,
        "subscriptionTypeName": subscriptionTypeName,
        "subscriptionValue": subscriptionValue,
        "channelStatus": channelStatus,
        "startDate": startDate,
        "endDate": endDate,
        "expiryInDays": expiryInDays,
        "message": message,
        "taxIncluded": taxIncluded,
        "choice": choice,
      };
}

class SubscriptionRechargeCalculationObj {
  SubscriptionRechargeCalculationObj({
    required this.subTotal,
    required this.isIgst,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.refund,
    required this.total,
    required this.isCreditLimit,
    required this.creditLimitAmount,
    required this.cashReceived,
    required this.walletbalance,
    required this.netPayableAmount,
    required this.taxList,
  });

  num subTotal;
  bool isIgst;
  num igst;
  num cgst;
  num sgst;
  num refund;
  num total;
  bool isCreditLimit;
  num creditLimitAmount;
  num cashReceived;
  num walletbalance;
  num netPayableAmount;
  List<TaxList> taxList;

  factory SubscriptionRechargeCalculationObj.fromJson(
          Map<String, dynamic> json) =>
      SubscriptionRechargeCalculationObj(
        subTotal: json["subTotal"],
        isIgst: json["isIGST"],
        igst: json["igst"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        refund: json["refund"],
        total: json["total"],
        isCreditLimit: json["isCreditLimit"],
        creditLimitAmount: json["creditLimitAmount"],
        cashReceived: json["cashReceived"],
        walletbalance: json["walletbalance"],
        netPayableAmount: json["netPayableAmount"],
        taxList:
            List<TaxList>.from(json["taxList"].map((x) => TaxList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "isIGST": isIgst,
        "igst": igst,
        "cgst": cgst,
        "sgst": sgst,
        "refund": refund,
        "total": total,
        "isCreditLimit": isCreditLimit,
        "creditLimitAmount": creditLimitAmount,
        "cashReceived": cashReceived,
        "walletbalance": walletbalance,
        "netPayableAmount": netPayableAmount,
        "taxList": List<dynamic>.from(taxList.map((x) => x.toJson())),
      };
}

class TaxList {
  TaxList({
    required this.taxCatId,
    required this.taxName,
    required this.taxValue,
    required this.taxAmount,
    required this.isPercentage,
    required this.totalTaxAmount,
  });

  num taxCatId;
  String taxName;
  num taxValue;
  num taxAmount;
  bool isPercentage;
  num totalTaxAmount;

  factory TaxList.fromJson(Map<String, dynamic> json) => TaxList(
        taxCatId: json["taxCatId"],
        taxName: json["taxName"],
        taxValue: json["taxValue"],
        taxAmount: json["taxAmount"],
        isPercentage: json["isPercentage"],
        totalTaxAmount: json["totalTaxAmount"],
      );

  Map<String, dynamic> toJson() => {
        "taxCatId": taxCatId,
        "taxName": taxName,
        "taxValue": taxValue,
        "taxAmount": taxAmount,
        "isPercentage": isPercentage,
        "totalTaxAmount": totalTaxAmount,
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
