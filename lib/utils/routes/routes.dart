import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/view/home_screen.dart';
import 'package:cleanarchtitecturedemo/view/login_view.dart';
import 'package:cleanarchtitecturedemo/view/sign_up_view.dart';
import 'package:cleanarchtitecturedemo/view/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RoutesNames.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpView());
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Text(
              'No Routes Defined'
            ),
          );
        });
    }
  }
}
