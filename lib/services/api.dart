import 'dart:convert';

import 'package:http/http.dart' as http;


String apiUrl = "http://127.0.01:8000/api";
class API{


  postRequest({

    required String route,
    required Map<String, String> data,

}) async {
    String url = apiUrl + route;

    return await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: _header(),
    );
  }
  _header() => {
    'Content-Type': 'multipart/form-data',
    'Accept' : 'multipart/form-data'
  };
}