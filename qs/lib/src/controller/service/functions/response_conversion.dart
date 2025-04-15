import 'package:http/http.dart' as http;

extension HttpResponseJson on http.Response {

  Map<String, dynamic> get customToJson {
    return {
      'statusCode': this.statusCode,
      'body': this.body,
     
    };
  }
}

extension MapExtension on Map<String, dynamic> {
  http.Response get customToHttpResponse {
    return http.Response(
      (this['body'] ?? "").toString(),
      int.tryParse((this['statusCode'] ?? "").toString()) ?? 0,
      // headers: Map<String, String>.from(this['headers'] ?? {}),
    );
  }
}
