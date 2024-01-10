import 'package:cleanarchtitecturedemo/data/network/base_api_services.dart';
import 'package:cleanarchtitecturedemo/data/network/network_api_service.dart';
import 'package:cleanarchtitecturedemo/resources/app_urls.dart';

class AuthRepository{

  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async{

    try{

      dynamic response = await _apiService.postApiResponse(AppUrls.loginUrl, data);
      return response;
    }
    catch(exception){
      throw exception;
    }
  }

  Future<dynamic> registerApi(dynamic data) async{

    try{

      dynamic response = await _apiService.postApiResponse(AppUrls.registerUrl, data);
      return response;
    }
    catch(exception){
      throw exception;
    }
  }
}