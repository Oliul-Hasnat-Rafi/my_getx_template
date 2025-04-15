import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:photos/src/controller/service/api/http_call.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';

import '../../../../components.dart';
import '../../../model/response_model/photo_screen_response_model.dart';

class ApiServices extends GetxController {
  late final HttpCall _httpCall;
  ApiServices() : _httpCall = HttpCall();

  Future<List<PhotoScreenResponseModel>> getPhotos({required int perPage, required int currentPage}) async {
    String httpLink = "photos/?client_id=$apiKey&per_page=$perPage&page=$currentPage";
    http.Response res = await _httpCall.get(httpLink);
    if (res.statusCode != 200) throw res;
    devPrint(res.body);

    final decode = jsonDecode(res.body);
    final List<PhotoScreenResponseModel> photos = List<PhotoScreenResponseModel>.from(decode.map((model) => PhotoScreenResponseModel.fromJson(model))).toList();

    return photos;
  }

   Future<Uint8List?> getPhotoDownload( String url) async {
    
    String httpLink = url;

    http.Response res = await _httpCall.get(
      httpLink,
      isImageUrl: true,
    );
    if (res.statusCode != 200) throw res;
    return res.bodyBytes;
  }
}
