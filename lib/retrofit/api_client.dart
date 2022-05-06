import 'package:dio/dio.dart';
import 'package:goaccount/models/ChangePasswordResponse.dart';
import 'package:goaccount/models/ForgotPassword.dart';
import 'package:goaccount/models/Login.dart';
import 'package:goaccount/models/MSOResponse.dart';
import 'package:goaccount/models/QuickRechargeResponse.dart';
import 'package:goaccount/models/RechargeRenewResponseModel.dart';
import 'package:goaccount/models/SubsDashboardResponse.dart';
import 'package:goaccount/models/SubsTransactionHistoryResponse.dart';
import 'package:goaccount/models/SubscriptionModel.dart';
import 'package:retrofit/retrofit.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://www.neurosms.in:9090/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @FormUrlEncoded()
  @POST(Apis.msoDetails)
  Future<MsoResponse> msoDetails(@Field("subDomain") subDomain);

  @FormUrlEncoded()
  @POST(Apis.login)
  Future<Login> loginUser(@Field("email") user_ID, @Field("password") password);

@FormUrlEncoded()
  @POST(Apis.forgotPassword)
  Future<ForgotPassword> forgotPassword(@Field("emailId") emailId);

  @FormUrlEncoded()
  @POST(Apis.subsDashboard)
  Future<SubsDashboardResponse> getSubsDashboard(@Field("tokenId") tokenId);

  @FormUrlEncoded()
  @POST(Apis.subsTransactnHistory)
  Future<SubsTransactionHistoryResponse> getSubsTransactnHistory(
      @Field("tokenId") tokenId,
      @Field("subsWalletId") subsWalletId,
      @Field("pageid") pageid,
      @Field("submitType") submitType,
      @Field("vcNumber") vcNumber,
      @Field("transactionTypeId") transactionTypeId,
      @Field("serviceTypeId") serviceTypeId,
      @Field("paymentMode") paymentMode,
      @Field("fromDate") fromDate,
      @Field("endDate") endDate);

  @FormUrlEncoded()
  @POST(Apis.quickRecharge)
  Future<QuickRechargeResponse> getQuickRechargeData(
    @Field("tokenId") tokenId,
    @Field("subsId") subsId,
    @Field("encdvcId") encdvcId,
  );

  @POST(Apis.subscription)
  Future<SubscriptionModel> getSubscriptionData(
      @Body() queryParameters,
      );

  @POST(Apis.rechargeRenew)
  Future<RechargeRenewResponseModel> rechargeRenew(
    @Body() queryParameters,
  );

  @FormUrlEncoded()
  @POST(Apis.changePassword)
  Future<ChangePasswordResponse> getChangePassword(
    @Field("tokenId") tokenId,
    @Field("password") password,
    @Field("confpassword") confpassword,
  );

/*@POST(Apis.timesheetlist)
  Future<List<Timerecord>> getTimesheetList(
      @Field("UserID") user_ID, @Field("M_App_Key") app_Key);

  @POST(Apis.matterlist)
  Future<List<MatterList>> getMatterList(@Field("UserID") user_ID,
      @Field("FileNo") fileNo, @Field("M_App_Key") app_Key);

  @POST(Apis.subject)
  Future<List<Subjects>> getSubject(@Field("UserID") user_ID,
      @Field("FileNo") fileNo, @Field("M_App_Key") app_Key);

  @POST(Apis.activity)
  Future<List<Activities>> getActivity(
      @Field("UserID") user_ID,
      @Field("FileNo") fileNo,
      @Field("M_App_Key") app_Key,
      @Field("Subject") Subject);

  @POST(Apis.matter)
  Future<Matter> getMatter(@Field("UserID") user_ID, @Field("FileNo") fileNo,
      @Field("M_App_Key") app_Key);

  @POST(Apis.addUpdateMatter)
  @FormUrlEncoded()
  Future<ResponseModel> addUpdateMatterUpdate(
      @Field("Deligated_By") delegated_by,
      @Field("Client_Name") client_Name,
      @Field("Subject") subject,
      @Field("Posting_Date") posting_Date,
      @Field("Document_Date") document_Date,
      @Field("Virtual_Hours") virtual_Hours,
      @Field("Normal_Hours") normal_Hours,
      @Field("Line_No_") line_No,
      @Field("Job_Task_No_") job_Task_No,
      @Field("Court") court,
      @Field("Chargeable") chargeable,
      @Field("Job_No") job_No,
      @Field("File_Incharge") file_Incharge,
      @Field("File_InchargeName") file_InchargeName,
      @Field("Total_Time") total_Time,
      @Field("Activity") activity,
      @Field("Billable") billable,
      @Field("Remarks") remarks,
      @Field("UserID") user_ID,
      @Field("M_App_Key") app_Key);

  @POST(Apis.postTimesheet)
  Future<ResponseModel> postTimesheet(@Field("UserID") user_ID,
      @Field("M_App_Key") app_Key, @Field("LineNo") lineNo);

  @POST(Apis.deleteTimesheet)
  Future<ResponseModel> deleteTimesheet(@Field("UserID") user_ID,
      @Field("M_App_Key") app_Key, @Field("LineNo") lineNo);

  @POST(Apis.userAuthorization)
  Future<Response> getuserAuthorization(
      @Field("UserID") user_ID, @Field("M_App_Key") app_Key);*/
}
