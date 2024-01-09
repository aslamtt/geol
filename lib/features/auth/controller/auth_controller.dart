import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/authModel.dart';
import 'package:geol/features/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home.dart';
import '../../../core/providers/utils.dart';
import '../../../nav.dart';

final AuthControllerProvider = StateProvider((ref)=>AuthController(authRepository: ref.watch(AuthRepositoryProvider)));

class AuthController{
  
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository
}): _authRepository = authRepository;

  SignUser(AuthModel authModel , String text){
    _authRepository.SignUser(authModel);

  }
// SignUser(email_controller , password_controller){
//   _authRepository.SignUser(email_controller, password_controller);
//   return AuthModel(email: email_controller, password: password_controller, id: "");
//
// }
LoginUser(String email,String password,BuildContext context) async {
  var result=await _authRepository.LoginUser(email, password);
  result.fold(
          (l) => showSnackBar(context,l.message),
          (r) async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("email", email);
            prefs.setString("password", password);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  navbar(),));

          }

  );
}

  // LoginUser(email_controller,password_controller,BuildContext context) async {
  //   var res = await _authRepository.LoginUser(email_controller, password_controller);
  //   res.fold(
  //           (l) => showSnackBar(context, l.message),
  //           (r) => Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage())));
  // }


}