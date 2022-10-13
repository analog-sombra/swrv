import 'package:http/http.dart' as http;
import 'dart:convert';

class CusApiReq {
  String baseUrl = "https://bluelemontech.in/websites/cs/api/api.php";
  Future<List> postReq(String jdata) async {
    try {
      var request = http.Request('POST',
          Uri.parse('https://bluelemontech.in/websites/cs/api/api.php'));

      request.body = jdata;

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString(); 
        return [json.decode(data)];
      } else {
        return [false,"api error call"];
      }
     
    } catch (e) {
      return [false, e];
    }
  }
}
