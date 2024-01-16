import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geol/Models/productModel.dart';
import 'package:geol/core/providers/failure.dart';
import 'package:geol/core/providers/firebase_providers.dart';
import 'package:geol/core/providers/types_def.dart';
import 'package:geol/features/product/controller/pro_contro.dart';

import '../../../Models/settingsModel.dart';
import '../../../core/constands/firebase_constands.dart';
var Id;
final ProductRepositoryProvider = Provider((ref)=>ProductRepository(firestore: ref.read(firestoreProvider)));

class ProductRepository{
  
  final FirebaseFirestore _firebaseFirestore;
  
  ProductRepository({required FirebaseFirestore firestore})
  : _firebaseFirestore = firestore;

  Stream<SettingModel> getSettings(){
    return _settings
        .doc(FirebaseConstands.settingsCollection)
        .snapshots()
        .map((event) {
      SettingModel settings;
      if (event.data() != null) {
        settings = SettingModel.fromMap(event.data() as Map<String, dynamic>);
        return settings;
      } else {
        settings = SettingModel.fromMap({});
        return settings;
      }
    });
  }

  FutureVoid createProduct(ProductModel productModel ,WidgetRef ref)async{
    try{
       var settings= await ref.watch(getSettingsProvider.future);
      var iddata = await FirebaseFirestore.instance.collection("settings").doc("settings").get();
      Id=iddata.get("vendorid");
      // iddata.reference.update({"vendorid":FieldValue.increment(1)});
      // FirebaseFirestore.instance.collection("order").
      _vendors.doc("GZO"+Id.toString()).set(productModel.toMap());
      int random = Random().nextInt(90)+10;
      String id = "GZP$random${settings.productId}";
      DocumentReference reference = _vendors.doc("GZO"+Id.toString()).collection(FirebaseConstands.productsCollection)
          .doc(id);
      productModel = productModel.copyWith(
          reference: reference,
          productId: id);
      ref.read(firestoreProvider).collection(FirebaseConstands.settingsCollection)
          .doc(FirebaseConstands.settingsCollection).update({"productId":FieldValue.increment(1)});
      return right(reference.set(productModel.toMap()));
    } on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
     return left(Failur(e.toString()));
    }
  }
  DeleteImage(ProductModel productModel){
    _firebaseFirestore.collection(FirebaseConstands.productsCollection).doc(productModel.productId).delete();
  }

  // Stream<List<SettingModel>> getSettings(){
  //   return _firebaseFirestore.collection(FirebaseConstands.settingsCollection).snapshots().
  //   map((event) => event.docs.map((e) => SettingModel.fromMap(e.data())).toList());
  //
  // }



  Query get _product =>
      _firebaseFirestore.collectionGroup(FirebaseConstands.productsCollection);
  CollectionReference get _vendors =>
      _firebaseFirestore.collection(FirebaseConstands.vendorCollection);
  CollectionReference get _settings => _firebaseFirestore.collection(FirebaseConstands.settingsCollection);

  CollectionReference get _order => _firebaseFirestore.collection(FirebaseConstands.orderCollcetion);






}