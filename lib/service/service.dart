import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:covid/model/covid_data.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<CovidData> fetchData() async {
    var connectResult = await (Connectivity().checkConnectivity());
    if (connectResult != ConnectivityResult.none) {
      final response = await http
          .get("https://hpb.health.gov.lk/api/get-current-statistical");
      if (response.statusCode == 200) {
        print(CovidData.fromJson(jsonDecode(response.body)));
        return CovidData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to album');
      }
    } else {
      return null;
    }
  }
}
