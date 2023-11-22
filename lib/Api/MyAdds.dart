import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fyp/model/feature/MyAdds.dart';

class AdsApi {
  Future<AllAds?> fetchads() async {
    http.Response response;

    response = await http.get(Uri.parse("http://10.0.2.2:8000/getalladds"));
    print("object Response is ${response}");
    if (response.statusCode == 200) {
      final cjson = response.body;

      AllAds ads = AllAds.fromJson(json.decode(cjson));
      return ads;
    }
  }
}
