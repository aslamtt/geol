
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geol/Models/productModel.dart';
import 'package:geol/features/product/repository/pro_repo.dart';

import '../../../Models/settingsModel.dart';
import '../../../core/common/product_dialog.dart';
import '../../../core/providers/utils.dart';
String? finalUserId;
final getSettingsProvider = StreamProvider.autoDispose((ref){
  return ref.watch(ProductControllerProvider.notifier).getSettings();
});

final ProductControllerProvider = StateNotifierProvider<ProductController,bool >((ref) {
  final ProductRepository = ref.watch(ProductRepositoryProvider);
  return  ProductController(
      productRepository:  ProductRepository ,
      ref: ref
  );
}
  );


class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;
  final Ref _ref;
  ProductController({
    required ProductRepository productRepository,
    required Ref ref,
  })
      : _productRepository = productRepository,
        _ref = ref,
        super(false);


  Stream<SettingModel> getSettings(){
    return _productRepository.getSettings();

  }

 void createProduct({
   required ProductModel productModel,
   required BuildContext context,
   required WidgetRef ref,
}) async{
   state = true;
   final res = await _productRepository.createProduct(productModel, ref);
   state = false;
   res.fold((l) => showSnackBar(context,l.message), (r){
     showProductDialog(context:context, status: ProductStatus.create,);
     Timer(Duration(seconds: 3), () {
       Navigator.of(context)..pop()..pop();
     });
   });

  }
  DeleteImage(ProductModel productModel){
    _productRepository.DeleteImage(productModel);
  }

}