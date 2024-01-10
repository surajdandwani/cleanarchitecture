import 'package:cleanarchtitecturedemo/data/model/postal_code_model.dart';
import 'package:cleanarchtitecturedemo/data/response/api_response.dart';
import 'package:cleanarchtitecturedemo/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel with ChangeNotifier{

  final _myRepo = HomeRepository();

  ApiResponse<PostCodeModel> postalList = ApiResponse.loading();

  setPostalCode(ApiResponse<PostCodeModel> response){
      postalList = response;
      notifyListeners();
  }

  Future<void> fetchPostalCodeAPi()async{
    
    setPostalCode(ApiResponse.loading());
    _myRepo.getPostalCode().then((value){
      setPostalCode(ApiResponse.completed(value));
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setPostalCode(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }


}