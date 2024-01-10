
import 'package:cleanarchtitecturedemo/repository/auth_repository.dart';
import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/utils/utils.dart';
import 'package:cleanarchtitecturedemo/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../data/model/user_model.dart';

class AuthViewModel with ChangeNotifier{

  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async{
      setLoading(true);
    _myrepo.loginApi(data).then((value){
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context,listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString()
        )
      );
      Utils.flushBarErrorMessages('User Login Successfully', context);
      Navigator.pushNamed(context, RoutesNames.home);
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      debugPrint(error.toString());
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async{
    setSignUpLoading(true);
    _myrepo.registerApi(data).then((value){
      setSignUpLoading(false);
      Utils.flushBarErrorMessages('Sign Up Successfully', context);
      Navigator.pushNamed(context, RoutesNames.home);
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      debugPrint(error.toString());
    });
  }
}