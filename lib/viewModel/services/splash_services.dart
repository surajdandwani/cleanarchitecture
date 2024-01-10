import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/user_model.dart';

class SplashServices{

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async{
    getUserData().then((value) async{
      debugPrint(value.toString());
      if(value.token=='null' || value.token==''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesNames.login);
      }
      else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesNames.home);

      }
    }).onError((error, stackTrace){
      debugPrint(error.toString());
    });
  }

}