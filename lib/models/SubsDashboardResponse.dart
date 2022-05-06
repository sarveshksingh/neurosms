// To parse this JSON data, do
//
//     final subsDashboardResponse = subsDashboardResponseFromJson(jsonString);

import 'dart:convert';

SubsDashboardResponse subsDashboardResponseFromJson(String str) =>
    SubsDashboardResponse.fromJson(json.decode(str));

String subsDashboardResponseToJson(SubsDashboardResponse data) =>
    json.encode(data.toJson());

class SubsDashboardResponse {
  SubsDashboardResponse({
    required this.status,
    required this.msg,
    required this.logoPath,
    required this.dashboardinfo,
  });

  int status;
  String msg, logoPath;
  Dashboardinfo dashboardinfo;

  factory SubsDashboardResponse.fromJson(Map<String, dynamic> json) =>
      SubsDashboardResponse(
        status: json["status"],
        msg: json["msg"],
        logoPath: json["logoPath"],
        dashboardinfo: Dashboardinfo.fromJson(json["dashboardinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "logoPath": logoPath,
        "dashboardinfo": dashboardinfo.toJson(),
      };
}

class Dashboardinfo {
  Dashboardinfo({
    required this.subscriberProfile,
    required this.hardwareDetailsList,
    required this.subscriptionList,
    required this.userDetail,
  });

  SubscriberProfile subscriberProfile;
  List<HardwareDetailsList> hardwareDetailsList;
  List<SubscriptionList> subscriptionList;
  UserDetail userDetail;

  factory Dashboardinfo.fromJson(Map<String, dynamic> json) => Dashboardinfo(
        subscriberProfile:
            SubscriberProfile.fromJson(json["subscriberProfile"]),
        hardwareDetailsList: List<HardwareDetailsList>.from(
            json["hardwareDetailsList"]
                .map((x) => HardwareDetailsList.fromJson(x))),
        subscriptionList: List<SubscriptionList>.from(
            json["subscriptionList"].map((x) => SubscriptionList.fromJson(x))),
        userDetail: UserDetail.fromJson(json["userDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "subscriberProfile": subscriberProfile.toJson(),
        "hardwareDetailsList":
            List<dynamic>.from(hardwareDetailsList.map((x) => x.toJson())),
        "subscriptionList":
            List<dynamic>.from(subscriptionList.map((x) => x.toJson())),
        "userDetail": userDetail.toJson(),
      };
}

class HardwareDetailsList {
  HardwareDetailsList({
    required this.subscriberId,
    required this.subscriberDeviceMapId,
    required this.encDvcMapId,
    required this.stbVcNo,
    required this.hardwareStatus,
    required this.hardwareStatusValue,
    required this.deviceContactPerson,
    required this.hardwareInstallationAddress,
    required this.associatedFranchiseeDetails,
    required this.hardsubscriptionList,
    required this.vcNumber,
  });

  String subscriberId;
  int subscriberDeviceMapId;
  String encDvcMapId;
  String stbVcNo;
  int hardwareStatus;
  String hardwareStatusValue;
  String deviceContactPerson;
  Address hardwareInstallationAddress;
  AssociatedFranchiseeDetails associatedFranchiseeDetails;
  List<SubscriptionList> hardsubscriptionList;
  String vcNumber;

  factory HardwareDetailsList.fromJson(Map<String, dynamic> json) =>
      HardwareDetailsList(
        subscriberId: json["subscriberId"],
        subscriberDeviceMapId: json["subscriberDeviceMapId"],
        encDvcMapId: json["encDvcMapId"],
        stbVcNo: json["stbVCNo"],
        hardwareStatus: json["hardwareStatus"],
        hardwareStatusValue: json["hardwareStatusValue"],
        deviceContactPerson: json["deviceContactPerson"],
        hardwareInstallationAddress:
            Address.fromJson(json["hardwareInstallationAddress"]),
        associatedFranchiseeDetails: AssociatedFranchiseeDetails.fromJson(
            json["associatedFranchiseeDetails"]),
        hardsubscriptionList: List<SubscriptionList>.from(
            json["hardsubscriptionList"]
                .map((x) => SubscriptionList.fromJson(x))),
        vcNumber: json["vcNumber"],
      );

  Map<String, dynamic> toJson() => {
        "subscriberId": subscriberAccountNoValues.reverse[subscriberId],
        "subscriberDeviceMapId": subscriberDeviceMapId,
        "encDvcMapId": encDvcMapId,
        "stbVCNo": stbVcNo,
        "hardwareStatus": hardwareStatus,
        "hardwareStatusValue": hardwareStatusValue,
        "deviceContactPerson": deviceContactPerson,
        "hardwareInstallationAddress": hardwareInstallationAddress.toJson(),
        "associatedFranchiseeDetails": associatedFranchiseeDetails.toJson(),
        "hardsubscriptionList":
            List<dynamic>.from(hardsubscriptionList.map((x) => x.toJson())),
        "vcNumber": vcNumber,
      };
}

class AssociatedFranchiseeDetails {
  AssociatedFranchiseeDetails({
    required this.franchiseeId,
    required this.lcoId,
    required this.lcoBusinessName,
    required this.franName,
    required this.franchiseeAddress,
  });

  int franchiseeId;
  dynamic lcoId;
  String lcoBusinessName;
  String franName;
  Address franchiseeAddress;

  factory AssociatedFranchiseeDetails.fromJson(Map<String, dynamic> json) =>
      AssociatedFranchiseeDetails(
        franchiseeId: json["franchiseeId"],
        lcoId: json["lcoId"],
        lcoBusinessName: json["lcoBusinessName"],
        franName: json["franName"],
        franchiseeAddress: Address.fromJson(json["franchiseeAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "franchiseeId": franchiseeId,
        "lcoId": lcoId,
        "lcoBusinessName": lcoBusinessName,
        "franName": franName,
        "franchiseeAddress": franchiseeAddress.toJson(),
      };
}

class Address {
  Address({
    required this.address1,
    required this.address2,
    required this.address3,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.areaName,
    required this.pincode,
    required this.phoneNo,
  });

  String? address1;
  String? address2;
  String? address3;
  String? countryName;
  String? stateName;
  String? cityName;
  String? areaName;
  String? pincode;
  String? phoneNo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        address3: json["address3"] == null ? null : json["address3"],
        countryName: json["countryName"] == null ? null : json["countryName"],
        stateName: json["stateName"] == null ? null : json["stateName"],
        cityName: json["cityName"],
        areaName: json["areaName"] == null ? null : json["areaName"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        phoneNo: json["phoneNo"] == null ? null : json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "address3": address3 == null ? null : address3,
        "countryName": countryName == null ? null : countryName,
        "stateName": stateName == null ? null : stateName,
        "cityName": cityName,
        "areaName": areaName == null ? null : areaName,
        "pincode": pincode == null ? null : pincode,
        "phoneNo": phoneNo,
      };
}

class SubscriptionList {
  SubscriptionList({
    required this.msoId,
    required this.subscriberDvcMapId,
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
    required this.taxPrice,
    required this.logo,
    required this.isActive,
    required this.taxIncluded,
    required this.promotionId,
    required this.promotionType,
    required this.promotionText,
  });

  SubscriberAccountNo? msoId;
  int subscriberDvcMapId;
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
  SubscriptionTypeName? subscriptionTypeName;
  double price;
  double monthlyPrice;
  double taxPrice;
  String logo;
  bool isActive;
  bool taxIncluded;
  int promotionId;
  String promotionType;
  String promotionText;

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      SubscriptionList(
        msoId: subscriberAccountNoValues.map[json["msoId"]],
        subscriberDvcMapId: json["subscriberDvcMapId"],
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
        subscriptionTypeName:
            subscriptionTypeNameValues.map[json["subscriptionTypeName"]],
        price: json["price"].toDouble(),
        monthlyPrice: json["monthlyPrice"].toDouble(),
        taxPrice: json["taxPrice"].toDouble(),
        logo: json["logo"],
        isActive: json["isActive"],
        taxIncluded: json["taxIncluded"],
        promotionId: json["promotionId"],
        promotionType: json["promotionType"],
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toJson() => {
        "msoId": subscriberAccountNoValues.reverse[msoId],
        "subscriberDvcMapId": subscriberDvcMapId,
        "productSubscriptionId": productSubscriptionId,
        "productId": productId,
        "productName": productName,
        "broadcasterName": broadcasterName,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "packageType": packageType,
        "channelCount": channelCount,
        "subsTypeId": subsTypeId,
        "subsVal": subsVal,
        "subscriptionTypeName":
            subscriptionTypeNameValues.reverse[subscriptionTypeName],
        "price": price,
        "monthlyPrice": monthlyPrice,
        "taxPrice": taxPrice,
        "logo": logoValues.reverse[logo],
        "isActive": isActive,
        "taxIncluded": taxIncluded,
        "promotionId": promotionId,
        "promotionType": promotionType,
        "promotionText": promotionText,
      };
}

enum Logo { EMPTY, CNBCTV18_JPG }

final logoValues =
    EnumValues({"CNBCTV18.jpg": Logo.CNBCTV18_JPG, "": Logo.EMPTY});

enum SubscriberAccountNo { THE_00090017001500094 }

final subscriberAccountNoValues = EnumValues(
    {"0009-0017-0015-00094": SubscriberAccountNo.THE_00090017001500094});

enum SubscriptionTypeName { MONTHLY }

final subscriptionTypeNameValues =
    EnumValues({"Monthly": SubscriptionTypeName.MONTHLY});

class SubscriberProfile {
  SubscriberProfile({
    required this.subscriberId,
    required this.mainAccountName,
    required this.subscriberAccountNo,
    required this.subscriberName,
    required this.subscriberEmail,
    required this.subscriberProfileAddress,
    required this.subscriberProfileStatus,
    required this.subscriberTotalWalletBalance,
    required this.walletId,
    required this.addAmount,
  });

  SubscriberAccountNo? subscriberId;
  String mainAccountName;
  SubscriberAccountNo? subscriberAccountNo;
  String subscriberName;
  String subscriberEmail;
  Address subscriberProfileAddress;
  int subscriberProfileStatus;
  double subscriberTotalWalletBalance;
  String walletId;
  AddAmount addAmount;

  factory SubscriberProfile.fromJson(Map<String, dynamic> json) =>
      SubscriberProfile(
        subscriberId: subscriberAccountNoValues.map[json["subscriberId"]],
        mainAccountName: json["mainAccountName"],
        subscriberAccountNo:
            subscriberAccountNoValues.map[json["subscriberAccountNo"]],
        subscriberName: json["subscriberName"],
        subscriberEmail: json["subscriberEmail"],
        subscriberProfileAddress:
            Address.fromJson(json["subscriberProfileAddress"]),
        subscriberProfileStatus: json["subscriberProfileStatus"],
        subscriberTotalWalletBalance:
            json["subscriberTotalWalletBalance"].toDouble(),
        walletId: json["walletID"],
        addAmount: AddAmount.fromJson(json["addAmount"]),
      );

  Map<String, dynamic> toJson() => {
        "subscriberId": subscriberAccountNoValues.reverse[subscriberId],
        "mainAccountName": mainAccountName,
        "subscriberAccountNo":
            subscriberAccountNoValues.reverse[subscriberAccountNo],
        "subscriberName": subscriberName,
        "subscriberEmail": subscriberEmail,
        "subscriberProfileAddress": subscriberProfileAddress.toJson(),
        "subscriberProfileStatus": subscriberProfileStatus,
        "subscriberTotalWalletBalance": subscriberTotalWalletBalance,
        "walletID": walletId,
        "addAmount": addAmount.toJson(),
      };
}

class AddAmount {
  AddAmount({
    required this.userId,
    required this.loggedInUserId,
    required this.transactionInitiatorUserId,
    required this.walletId,
    required this.transactionDate,
    required this.paymentModeId,
    required this.amount,
    required this.remark,
    required this.reference,
    required this.paymentModes,
    required this.serviceTypeId,
    required this.isAuthEnabled,
  });

  String? userId;
  String? loggedInUserId;
  String? transactionInitiatorUserId;
  String? walletId;
  String? transactionDate;
  int paymentModeId;
  int amount;
  String? remark;
  String? reference;
  List<dynamic> paymentModes;
  int serviceTypeId;
  bool isAuthEnabled;

  factory AddAmount.fromJson(Map<String, dynamic> json) => AddAmount(
        userId: json["userId"],
        loggedInUserId: json["loggedInUserId"],
        transactionInitiatorUserId: json["transactionInitiatorUserId"],
        walletId: json["walletId"],
        transactionDate: json["transactionDate"],
        paymentModeId: json["paymentModeId"],
        amount: json["amount"],
        remark: json["remark"],
        reference: json["reference"],
        paymentModes: List<dynamic>.from(json["paymentModes"].map((x) => x)),
        serviceTypeId: json["serviceTypeId"],
        isAuthEnabled: json["isAuthEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "loggedInUserId": loggedInUserId,
        "transactionInitiatorUserId": transactionInitiatorUserId,
        "walletId": walletId,
        "transactionDate": transactionDate,
        "paymentModeId": paymentModeId,
        "amount": amount,
        "remark": remark,
        "reference": reference,
        "paymentModes": List<dynamic>.from(paymentModes.map((x) => x)),
        "serviceTypeId": serviceTypeId,
        "isAuthEnabled": isAuthEnabled,
      };
}

class UserDetail {
  UserDetail({
    required this.userId,
    required this.parentId,
    required this.mobileNo,
    required this.emailId,
    required this.roleId,
    required this.roleName,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.zipCode,
    required this.isActive,
    required this.businessName,
    required this.contactPerson,
    required this.profilePic,
    required this.cityName,
    required this.gstNumber,
    required this.hasEmail,
    required this.prevId,
  });

  String userId;
  String parentId;
  String mobileNo;
  String emailId;
  dynamic roleId;
  dynamic roleName;
  String address1;
  String address2;
  String address3;
  String zipCode;
  bool isActive;
  String businessName;
  String contactPerson;
  String profilePic;
  String cityName;
  dynamic gstNumber;
  bool hasEmail;
  dynamic prevId;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        userId: json["userId"],
        parentId: json["parentId"],
        mobileNo: json["mobileNo"],
        emailId: json["emailId"],
        roleId: json["roleId"],
        roleName: json["roleName"],
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        zipCode: json["zipCode"],
        isActive: json["isActive"],
        businessName: json["businessName"],
        contactPerson: json["contactPerson"],
        profilePic: json["profilePic"],
        cityName: json["cityName"],
        gstNumber: json["gstNumber"],
        hasEmail: json["hasEmail"],
        prevId: json["prevId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": subscriberAccountNoValues.reverse[userId],
        "parentId": parentId,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "roleId": roleId,
        "roleName": roleName,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "zipCode": zipCode,
        "isActive": isActive,
        "businessName": businessName,
        "contactPerson": contactPerson,
        "profilePic": profilePic,
        "cityName": cityName,
        "gstNumber": gstNumber,
        "hasEmail": hasEmail,
        "prevId": prevId,
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
