
import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/components/round_button.dart';
import '../utils/utils.dart';
import '../viewModel/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
          title: Text('Sign Up Screen'),
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
              RoundButton(title: 'Sign Up', loading: authViewModel.
                signUpLoading,onPress: () {
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
                  Map data = {
                    "email": emailController.text.toString(),
                    "password": passwordController.text.toString()
                  };
                  authViewModel.signUpApi(data,context);
                }
              },),
              SizedBox(
                height: height * .005,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesNames.login);
                },
                child: Text('Already Have an account? Login'),
              )
            ],
          ),
        )
    );
  }
}
