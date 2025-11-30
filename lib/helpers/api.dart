import 'dart:io';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:tokokita/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    print("-------------------------------------------");
    print("POST Request ke: $url");
    print("Data Mentah: $data"); 
    print("Token: $token");

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(data), 
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.contentTypeHeader: "application/json"
          });

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("-------------------------------------------");

      responseJson = _returnResponse(response);
    } on SocketException {
      print("Error: No Internet Connection");
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("Error Lainnya: $e");
      rethrow; 
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    print("-------------------------------------------");
    print("GET Request ke: $url");

    try {
      final response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("-------------------------------------------");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    print("-------------------------------------------");
    print("PUT Request ke: $url");
    print("Data Mentah: $data");

    try {
      final response = await http.put(Uri.parse(url),
          body: jsonEncode(data), 
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.contentTypeHeader: "application/json"
          });

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("-------------------------------------------");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    print("-------------------------------------------");
    print("DELETE Request ke: $url");

    try {
      final response = await http.delete(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("-------------------------------------------");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}