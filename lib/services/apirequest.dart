import 'package:http/http.dart' as http;
import 'dart:convert';

class CusApiReq {
  String baseUrl = "https://bluelemontech.in/websites/cs/api/api.php";
  String baseUrl2 = "https://bluelemontech.in/websites/swrv/api";

  Future<List> postReq(String reqdata) async {
    try {
      var request = await http.post(Uri.parse(baseUrl), body: reqdata);

      if (request.statusCode == 200) {
        return [json.decode(request.body)];
      } else {
        return [false, "Something went wrong please try again"];
      }
    } catch (e) {
      return [false, e];
    }
  }

  Future<List> postUrlReq(String url, String reqdata) async {
    try {
      var request =
          await http.post(Uri.parse(baseUrl2 + url), body: jsonDecode(reqdata));

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
