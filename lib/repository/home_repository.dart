import 'package:cleanarchtitecturedemo/data/model/postal_code_model.dart';
import 'package:cleanarchtitecturedemo/data/network/base_api_services.dart';
import 'package:cleanarchtitecturedemo/data/network/network_api_service.dart';
import 'package:cleanarchtitecturedemo/resources/app_urls.dart';

class HomeRepository{

  BaseApiService _apiService = NetworkApiService();
  Future<PostCodeModel> getPostalCode() async{

    try{

      dynamic response = await _apiService.getApiResponse(AppUrls.posttalGetApiUrl);
      return response = PostCodeModel.fromJson(response);
    }
    catch(exception){
      throw exception;
    }
  }
}