import 'dart:convert';
import 'dart:io';

import 'package:cleanarchtitecturedemo/data/exceptions.dart';
import 'package:cleanarchtitecturedemo/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService extends BaseApiService{
  @override
  Future getApiResponse(String url) async{

    dynamic responseJson;

    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url , dynamic data) async{
    dynamic responseJson;

    try{
      Response response = await post(
        Uri.parse(url),
        body : data
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse( http.Response response)
  {
    switch (response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException('Bad Request${response.statusCode}');
      case 404:
        throw UnAuthorisedException('Unauthorised User ${response.statusCode}');
      case 502:
        throw InternalServerException('Internal Server Error${response.statusCode}');
      default:
        throw FetchDataException('Error Occurred While Communicating with Server' + 'With Status Code' +response.statusCode.toString());
    }
  }

}