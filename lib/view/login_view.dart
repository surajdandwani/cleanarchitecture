import 'package:cleanarchtitecturedemo/resources/components/round_button.dart';
import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/utils/utils.dart';
import 'package:cleanarchtitecturedemo/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height *1 ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body:
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email)
              ),
              onFieldSubmitted: (value){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              }
            ),
            ValueListenableBuilder(valueListenable: _obsecurePassword, builder:
            (context,value,child){
              return
                TextFormField(
                    controller: passwordController,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: '*',
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: InkWell(
                          child: _obsecurePassword.value?
                          Icon(Icons.visibility_off_outlined):
                          Icon(Icons.visibility_outlined),
                          onTap: (){
                            _obsecurePassword.value =! _obsecurePassword.value;
                          },
                        )
                    ),
                    onFieldSubmitted: (value){
                      // Utils.fieldFocusChange(context, passwordFocusNode, emailFocusNode);
                    }
                );
            }
            ),
            SizedBox(
              height: height * .080,
            ),
            RoundButton(title: 'Login', loading: authViewModel.loading,onPress: () {
              if(emailController.text.isEmpty)
                {
                  Utils.flushBarErrorMessages('Please Enter Email', context);
                }
              else if(passwordController.text.isEmpty){
                Utils.flushBarErrorMessages('Please Enter Password', context);
              }
              else if(passwordController.text.length <6){
                Utils.flushBarErrorMessages('Please Enter Password Greater than 6', context);
              }
              else{
                // Map data = {
                //   "email": emailController.text.toString(),
                //   "password": passwordController.text.toString()
                // };
                Map data = {
                  "email": 'eve.holt@reqres.in',
                  "password": 'cityslicka'
                };
                authViewModel.loginApi(data,context);
              }
            },),
            SizedBox(
              height: height * .005,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesNames.signUp);
              },
              child: Text('Dont have an account? Sign Up'),
            )
          ],
        ),
      )
    );
  }
}
