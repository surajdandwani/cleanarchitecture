import 'package:cleanarchtitecturedemo/utils/routes/routes.dart';
import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/view/login_view.dart';
import 'package:cleanarchtitecturedemo/viewModel/auth_view_model.dart';
import 'package:cleanarchtitecturedemo/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel())
        ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesNames.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    ),);
  }
}
