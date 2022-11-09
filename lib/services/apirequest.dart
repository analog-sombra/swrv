import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/const.dart';

class CusApiReq {
  // // String baseUrl = "https://bluelemontech.in/websites/cs/api/api.php";
  // const baseurl = "http://192.168.0.133/swrv";


  // String baseUrl = "http://192.168.0.133/swrv";

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

  Future<List> uploadImage(String filepath, String userid,
      {String path = ""}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/$path'));
      request.fields.addAll({'id': userid});
      request.files.add(await http.MultipartFile.fromPath('image', filepath));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return [jsonDecode(await response.stream.bytesToString())];
      } else {
        return [false, response.reasonPhrase!];
      }
    } catch (e) {
      return [false, e];
    }
  }
}
