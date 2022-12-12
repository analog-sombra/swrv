import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/const.dart';

class CusApiReq {
  Future<List> postApi(String reqdata, {String path = ""}) async {
    try {
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

  Future uploadFile(String filepath, {String path = ""}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/api/upload-file'));
      // request.fields.addAll({'fileAttPathTEC': path});
      request.files.add(await http.MultipartFile.fromPath('file', filepath));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        return {'status': false, 'message': response.reasonPhrase!};
      }
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  Future<bool> sendOTP(String userid) async {
    try {
      var request = await http
          .post(Uri.parse("$baseUrl/api/send-otp"), body: {"userId": userid});
      if (request.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
