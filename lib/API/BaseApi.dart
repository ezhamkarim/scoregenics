import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseApi {
  http.Response response;
  String numberRequest;
  var reqeustData;
  Future getProfile() async {
    try {
      response = await http.get('https://api.football-data.org/v2/players/2000',
          headers: {'X-Auth-Token': '4f1c1276d9c44781887a13f808bac067'});

      if (response.statusCode == 200) {
        numberRequest = response.headers['x-requests-available-minute'];
        reqeustData = json.decode(response.body);
      } else {
        throw "Error";
      }
      return reqeustData;
    } catch (e) {
      print('Error : $e');
    }
  }

  String get getRequestAvailable => numberRequest;
}
