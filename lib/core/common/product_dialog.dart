import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Models/productModel.dart';
import '../../main.dart';
import '../../theme/pellet.dart';

/// Show a dialog with a success message based on the given [status].
///
/// [context] is the build context.
/// [status] represents the status of the product operation.
///   - [ProductStatus.delete] for delete operation.
///   - [ProductStatus.update] for update operation.
///   - [ProductStatus.create] for create operation.
showProductDialog({
  required BuildContext context,
  required ProductStatus status,
}) {
  String message;

  switch (status) {
    case ProductStatus.delete:
      message = 'Product Successfully Deleted!';
      break;
    case ProductStatus.update:
      message = 'Product Successfully Updated!';
      break;
    case ProductStatus.create:
      message = 'Product Successfully Added!';
      break;
    case ProductStatus.clone:
      message = 'Product Successfully Cloned!';
      break;
  }
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        backgroundColor: Palette.mainColor,
        content: SizedBox(
          height: h * 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/new_icons/ready_to_pickup.svg",
                height: h * 0.1,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.02,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    },
  );
}
