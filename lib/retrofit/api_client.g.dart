// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://www.neurosms.in:9090/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MsoResponse> msoDetails(subDomain) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'subDomain': subDomain};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MsoResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/msoDetails',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MsoResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Login> loginUser(user_ID, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': user_ID, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Login>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/Login',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPassword> forgotPassword(emailId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'emailId': emailId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPassword>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/userforgotPassword',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubsDashboardResponse> getSubsDashboard(tokenId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'tokenId': tokenId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubsDashboardResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/subsDashboard',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubsDashboardResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubsTransactionHistoryResponse> getSubsTransactnHistory(
      tokenId,
      subsWalletId,
      pageid,
      submitType,
      vcNumber,
      transactionTypeId,
      serviceTypeId,
      paymentMode,
      fromDate,
      endDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'tokenId': tokenId,
      'subsWalletId': subsWalletId,
      'pageid': pageid,
      'submitType': submitType,
      'vcNumber': vcNumber,
      'transactionTypeId': transactionTypeId,
      'serviceTypeId': serviceTypeId,
      'paymentMode': paymentMode,
      'fromDate': fromDate,
      'endDate': endDate
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubsTransactionHistoryResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/subsTransactnHistory',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubsTransactionHistoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<QuickRechargeResponse> getQuickRechargeData(
      tokenId, subsId, encdvcId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'tokenId': tokenId, 'subsId': subsId, 'encdvcId': encdvcId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<QuickRechargeResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/quickRecharge',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = QuickRechargeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubscriptionModel> getSubscriptionData(dataJson) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = dataJson;
    /*final _result = await _dio.request<Map<String, dynamic>>(Apis.subscription,
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/json'),
        data: _data);*/
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubscriptionModel>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json')
            .compose(_dio.options, Apis.subscription,
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubscriptionModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RechargeRenewResponseModel> rechargeRenew(queryParameters) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = queryParameters;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RechargeRenewResponseModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Recharge/rechargeRenew',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RechargeRenewResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChangePasswordResponse> getChangePassword(
      tokenId, password, confpassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'tokenId': tokenId,
      'password': password,
      'confpassword': confpassword
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChangePasswordResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'Home/resetPassword',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChangePasswordResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
