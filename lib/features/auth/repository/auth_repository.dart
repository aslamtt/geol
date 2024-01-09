import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geol/Models/authModel.dart';
import 'package:geol/core/providers/failure.dart';
import 'package:geol/core/providers/firebase_providers.dart';
import 'package:geol/core/providers/types_def.dart';

final AuthRepositoryProvider = Provider((ref)=>AuthRepository(
    firebaseFirestore: ref.watch(firestoreProvider),
    firebaseAuth: ref.watch(authProvider)));

class AuthRepository{
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
   required FirebaseFirestore  firebaseFirestore,
   required FirebaseAuth firebaseAuth
}): _firebaseFirestore = firebaseFirestore,
  _firebaseAuth = firebaseAuth;

SignUser(AuthModel authModel){
  AuthModel user;
  _firebaseAuth.createUserWithEmailAndPassword(
      email: authModel.email.trim(),
      password: authModel.password.trim()).then((value) {
        user = AuthModel(
            email: authModel.email.trim(),
            password: authModel.password.trim(),
            id: authModel.id);
        FirebaseFirestore.instance.collection("Users").add(user.toMap()).
        then((value) => value.update({"id":value.id}));
  } );




}

// SignUser(String email_controller , String password_controller){
//
//   AuthModel user;
//   _firebaseAuth.createUserWithEmailAndPassword(
//       email: email_controller,
//       password: password_controller).then((value) => {
//
//         user = AuthModel(
//             email: email_controller,
//             password: password_controller,
//             id:value.user!.uid),
//     _firebaseFirestore.collection("Users").doc(value.user!.uid).set(user.toMap())
//
//   });
//
// }

FutureVoid LoginUser(String email, String password)  async {

  try{
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
    return right(null);

  } catch(e){
    return left(Failur(e.toString()));
  }


}

}