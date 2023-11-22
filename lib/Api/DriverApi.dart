import 'package:http/http.dart' as http;
import 'package:fyp/model/Drivers.dart';
import 'dart:convert';

import 'package:fyp/model/feature/MyAdds.dart';

class DriverApi {
  Future<Driver?> fetchdrivers(String? vehicle, String? city) async {
    print("City is $city");
    final Uri uri = Uri.parse("http://10.0.2.2:8000/getdrivers");

    final Map<String, String> queryParams = {
      'vehicle': vehicle ?? '',
      'city': city ?? '',
    };

    final Uri uriWithQuery = uri.replace(queryParameters: queryParams);

    final http.Response response = await http.get(uriWithQuery);

    if (response.statusCode == 200) {
      final cjson = response.body;
      Driver driver = Driver.fromJson(json.decode(cjson));
      return driver;
    } else {
      throw Exception('Failed to load drivers');
    }
  }
}
