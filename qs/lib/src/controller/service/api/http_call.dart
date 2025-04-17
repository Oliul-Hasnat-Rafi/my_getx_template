import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:photos/src/controller/service/functions/response_conversion.dart';
import '../../../../components.dart';
import '../../../core/values/app_strings.dart';
import '../functions/dev_print.dart';
import '../local_data/local_data_handler.dart';
import '../user_message/snackbar.dart';

class HttpCall {
  String _cookie = "";

  final int _timeout = 30;
  final Map<String, String> _header = {
    "Content-Type": "application/json",
    "TimeZone": DateTime.now().toLocal().timeZoneOffset.toString(),
    "Accept": "/",
  };

  //! Catch Cookie
  Future<T> _catchCookie<T>(Function function) async {
    T res = await function();
    if (res.runtimeType == http.Response) {
      var r = res as http.Response;
      if (r.headers['set-cookie'] != null) {
        _cookie = r.headers['set-cookie']!.split(";")[0].trim();
      }
    }
    return res;
  }

  Future<http.Response> get(String url, {String token = '', bool isImageUrl = false, Map<String, String>? headerParameter, int? timeout, bool addCookie = false}) async {
    final Map<String, String> header = {};
    header.addAll(headerParameter ?? _header);
    if (token.isNotEmpty) {
      header.addAll({
        HttpHeaders.authorizationHeader: token
      });
    }
    if (addCookie) {
      header.addAll({
        'Cookie': _cookie
      });
    }

    String sendLink = "${AppStrings.baseLink}$url";
    // devPrint("HttpCall: Requesting: Get------------------------------------------ $link");
    // var res = await _catchCookie<http.Response>(() async => await http.get(Uri.parse(isImageUrl ? url : link), headers: header).timeout(Duration(seconds: timeout ?? _timeout)));
    // devPrint("HttpCall: Response: Get------------------------------------------ $link ---- ${res.statusCode} ---- ${res.body}");

 devPrint("HttpCall: Requesting: Get------------------------------------------------------------- $sendLink");

    http.Response res = await _onCallFunction(
      link: sendLink,
      
      function: () async => await _catchCookie(() async => await http.get(Uri.parse(isImageUrl? url: sendLink), headers: header).timeout(apiCallTimeOut)),
    );
    devPrint("HttpCall: Response: GET ------------------------------------------------------------ $sendLink $_header --- Status Code: ${res.statusCode} --- Data: ${res.body}");

    return res;
  }

  Future<http.Response> post(String url, 
      {String token = '',
      Map<String, String>? headerParameter,
      Object? body,
      int? requestTimeout,
      bool addCookie = false}) async {
    final Map<String, String> header = {};
    header.addAll(headerParameter ?? _header);
    if (token.isNotEmpty) {
      header.addAll({"Authorization": token});
    }

    if (addCookie) {
      header.addAll({'Cookie': _cookie});
    }

    String link =AppStrings.baseLink + url;

    if (kDebugMode) {
      devPrint("HttpCall: Requesting: POST------------------------------------------ $link ---- $body");
      showToast(message: link);

    }

    var res = await _catchCookie<http.Response>(() async => await http.post(Uri.parse(link), headers: header, body: body).timeout(Duration(seconds: requestTimeout ?? _timeout)));
    if (kDebugMode) devPrint("HttpCall: Response: POST------------------------------------------ $link ---- ${res.statusCode} ---- ${res.body}");
    return res;
  }

  bool showOfflineToast = true;
  Future<http.Response> _onCallFunction({required Future<http.Response> Function() function, required String link, Object? body,}) async {
    final LocalDataHandler localData = Get.put(LocalDataHandler());

  
    String setUrl = "";
   

    setUrl = "${setUrl}_${link.hashCode}_${body == null ? "" : body.hashCode}";

    try {
      http.Response res = await function();
      showOfflineToast = true;

      try {
       localData.box.write(setUrl, json.encode(res.customToJson));
        devPrint("HttpCall__onCallFunction: Saving Data to $link");
      } catch (e) {
        devPrint("HttpCall__onCallFunction: Unable to write data for $link. Error: $e");
      }
      return res;
    } on SocketException {
   
      try {
        devPrint("HttpCall__onCallFunction: Reading Data from $link");
        //! Checking if I have local data
        String? temp = localData.box.read(setUrl);
        if (temp == null) rethrow;

        Map<String, dynamic> mapTemp = json.decode(temp);
        http.Response res = mapTemp.customToHttpResponse;

        if (showOfflineToast) showToast(message: "Offline mode");
        showOfflineToast = false;
        return res;
      } catch (e) {
        devPrint("HttpCall__onCallFunction: Unable to read data for $link. Error $e");
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}
