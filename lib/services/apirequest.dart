import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CusApiReq {
  // String baseUrl = "https://bluelemontech.in/websites/cs/api/api.php";

  String baseUrl = "http://192.168.0.133/swrv";

  Future<List> postApi(String reqdata, {String path = ""}) async {
    try {
      log(Uri.parse("$baseUrl$path").toString());
      var request = await http.post(Uri.parse("$baseUrl/$path"),
          body: jsonDecode(reqdata));

      if (request.statusCode == 200) {
        return [json.decode(request.body)];
      } else {
        return [false, "Something went wrong please try again"];
      }
    } catch (e) {
      return [false, e];
    }
  }

  Future<List> createCmp(String url, String reqdata) async {
    try {
      var request = await http.post(Uri.parse(url), body: jsonDecode(reqdata));

      if (request.statusCode == 200) {
        return [json.decode(request.body)];
      } else {
        return [false, "Something went wrong please try again"];
      }
    } catch (e) {
      return [false, e];
    }
  }
  
}
