import 'dart:convert';

RechargeRenewResponseModel rechargeRenewResponseModelFromJson(String str) => RechargeRenewResponseModel.fromJson(json.decode(str));

String rechargeRenewResponseModelToJson(RechargeRenewResponseModel data) => json.encode(data.toJson());

class RechargeRenewResponseModel {
  RechargeRenewResponseModel({
    required this.status,
    required this.message,
    required this.returnUrl,
  });

  int status;
  String message;
  String returnUrl;

  factory RechargeRenewResponseModel.fromJson(Map<String, dynamic> json) => RechargeRenewResponseModel(
    status: json["status"],
    message: json["message"],
    returnUrl: json["returnUrl"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "returnUrl": returnUrl,
  };
}
