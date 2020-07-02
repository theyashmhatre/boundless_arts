import 'package:flutter/material.dart';
import 'package:boundless_arts/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url, this.kAccessKey, this.query);
  final String url;
  final String kAccessKey;
  final String query;

  Future getData() async {
    print('network helper was called');
    print(url);
    print(kAccessKey);
    http.Response response =
        await http.get('$url$kAccessKey&per_page=30&page=1$query');
    print('query $query');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print('Response code : $response.statusCode');

      return decodedData;
    } else {
      print('error response code : ${response.statusCode}');
      return CircularProgressIndicator();
    }
  }
}
