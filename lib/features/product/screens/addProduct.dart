import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geol/Models/productModel.dart';
import 'package:geol/features/product/controller/pro_contro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils.dart';
import '../../../main.dart';
import '../../../order/repository/order_repository.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  Duration _duration = Duration(hours: 0, minutes: 0);
  final shortDescription = TextEditingController(text: '');
  final price_controller = TextEditingController(text: '0');
  final leadingTimeController = TextEditingController(text: "");
  final skuController = TextEditingController();
  int leadingTime = 0;
  TextEditingController name_controller = TextEditingController();
  TextEditingController longDis_controller = TextEditingController();
  TextEditingController productype_controller = TextEditingController();
  TextEditingController mode_controller = TextEditingController();
  TextEditingController keyword_controller = TextEditingController();
 final TextEditingController searchSkuSet = TextEditingController();
  TextEditingController varient_controller = TextEditingController();

  final min_controller = TextEditingController(text: "");
  final max_controller = TextEditingController(text: "");
  DeleteImage(ProductModel productModel) {
    ref.read(ProductControllerProvider.notifier).DeleteImage(productModel);
  }

  List<String> filteredSkuSet = [];
  bool isUploading = false;
  final int maxWordLimit = 5;
  String? validateShortDescription(String value) {
    if (value.isEmpty) {
      return 'Short Description is required';
    }

    // Split the input text into words
    final words = value.split(' ');

    // Check if the word count exceeds 35
    if (words.length > 5) {
      return 'Short Description should not exceed 35 words';
    }

    return null; // Return null if the input is valid
  }

  String ImageUrl = "";
  var file;
  Future<void> pickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
        fileUpload();
      });
    }
  }

  fileUpload() async {
    int i = 0;
    var uploadImage = await FirebaseStorage.instance
        .ref()
        .child("images/${DateTime.now().toString()}")
        .putFile(file!, SettableMetadata(contentType: "image/jpeg"));
    var getUrl = await uploadImage.ref.getDownloadURL();
    ImageUrl = getUrl;
    print("---------------------");
    print(ImageUrl);
    print("************");
    setState(() {});
  }

  // List<File> uploadedImages = [];
  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(
  //       sourcePath: imageFile.path,
  //       // aspectRatioPresets:[CropAspectRatioPreset.ratio4x3]
  //       aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3));
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }
  bool localDelicacies = false;
  String groupValue = 'No';
  createProduct(ProductModel productModel) {
    ProductModel productModel = ProductModel(
        name: name_controller.text,
        price: int.parse(price_controller.text),
        leadTime: int.tryParse(leadingTime.toString()),
        localDelicacies: localDelicacies,
        maxcount: int.tryParse(max_controller.text),
        mincount: int.tryParse(min_controller.text),
        varient: varient_controller.text,
        skuset: skuController.text,
        shortdiscription: shortDescription.text,
        longdiscription: longDis_controller.text,
        productKey: keyword_controller.text,
        productype: productype_controller.text,
        modeservice: mode_controller.text,
        image: ImageUrl,
        productId: "GZA" + Id.toString());
    ref
        .read(ProductControllerProvider.notifier)
        .createProduct(productModel: productModel, context: context, ref: ref);
  }

  @override
  Widget build(BuildContext alertContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: w * 0.04,
                right: w * 0.04,
                top: h * 0.02,
                bottom: h * 0.02),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 0.6,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Local Delicacies"),
                            SizedBox(
                              width: w * 0.08,
                            ),
                            Text("Yes"),
                            Radio(
                              activeColor: Colors.pink,
                              value: "Yes",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value.toString();
                                  localDelicacies = true;
                                });
                              },
                            ),
                            Text("No"),
                            Radio(
                              activeColor: Colors.pink,
                              value: "No",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value.toString();
                                  localDelicacies = false;
                                });
                              },
                            )
                          ],
                        ),
                        Text(
                          "Product Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: name_controller,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              label: Text(
                                "Product Name",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.8),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Text(
                          "Product Image",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Stack(children: [
                          InkWell(
                            onTap: () async {
                              pickFile(ImageSource.gallery);
                              // var img = await pickImg(context);
                              // if (img != null) {
                              //   File? file = File(img.path);
                              //   file = await _cropImage(imageFile: file);
                              //   setState(() {
                              //     isUploading = true;
                              //     // lastUploadTime =
                              //     //     DateTime.now();
                              //   });
                              //
                              //   // await uploadImageToFirebase(
                              //   // alertContext, file!);
                              //
                              //   setState(() {
                              //     isUploading = false;
                              //     // uploadedImages.add(file!);
                              //   });
                              // }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(ImageUrl),
                            ),
                          ),
                          Positioned(
                            child: InkWell(
                              onTap: () {
                                DeleteImage(ProductModel(image: ImageUrl));
                              },
                              child: CircleAvatar(
                                radius: 10,
                                child: Center(child: Icon(Icons.close)),
                              ),
                            ),
                            bottom: 40,
                            right: 1,
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "* Upload minimum 1 or maximum 3 photos",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Max image size 500KB",
                          style: TextStyle(color: Colors.grey),
                        ),
                        // SizedBox(
                        //   width: w * 0.9,
                        //   child: TextFormField(
                        //       onChanged: (value) {
                        //         final words =
                        //         value.trim().split(RegExp(r'\s+'));
                        //         if (words.length > maxWordLimit) {
                        //           setState(() {
                        //             shortDescription.text = words
                        //                 .take(maxWordLimit)
                        //                 .join(' ');
                        //           });
                        //           ScaffoldMessenger.of(context)
                        //               .showSnackBar(
                        //             const SnackBar(
                        //               content: Text(
                        //                   'Maximum word limit reached (35 words)'),
                        //             ),
                        //           );
                        //         }
                        //       },
                        //
                        //       // autovalidateMode: AutovalidateMode.always,
                        //       controller: shortDescription,
                        //       obscureText: false,
                        //       maxLines: null,
                        //       cursorColor: Colors.grey,
                        //       decoration: InputDecoration(
                        //         hintText:
                        //         'Short Description (Max 35 words)',
                        //         hintStyle: GoogleFonts.poppins(
                        //           color: Colors.grey,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //         // labelStyle: GoogleFonts.poppins(
                        //         //   color: Colors.grey,
                        //         //   fontSize: 14,
                        //         //   fontWeight: FontWeight.normal,
                        //         // ),
                        //         // hintText: 'Enter your user name...',
                        //         // hintStyle: GoogleFonts.poppins(
                        //         //   color: Palette.mainColor,
                        //         //   fontSize: 14,
                        //         //   fontWeight: FontWeight.normal,
                        //         // ),
                        //         enabledBorder: UnderlineInputBorder(
                        //           borderSide: const BorderSide(
                        //             color: Colors.black,
                        //             width: 0.3,
                        //           ),
                        //           borderRadius:
                        //           BorderRadius.circular(8),
                        //         ),
                        //
                        //         focusedBorder: UnderlineInputBorder(
                        //           borderSide: const BorderSide(
                        //             color: Colors.black,
                        //             width: 0.3,
                        //           ),
                        //           borderRadius:
                        //           BorderRadius.circular(8),
                        //         ),
                        //         filled: false,
                        //         fillColor: Colors.white,
                        //         // contentPadding: EdgeInsets.fromLTRB(10, 24, 20, 20),
                        //       ),
                        //       style: GoogleFonts.poppins(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.normal,
                        //       )),
                        // ),
                        TextFormField(
                          maxLength: 5,
                          controller: shortDescription,
                          decoration: InputDecoration(
                            hintText: "Short Description (Max words 35)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        Text("Long Description",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Container(
                          color: Colors.white,
                          width: w * 0.9,
                          height: h * 0.15,
                          child: DottedBorder(
                              dashPattern: [7],
                              child: TextFormField(
                                controller: longDis_controller,
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8)),
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: productype_controller,
                          decoration: InputDecoration(
                              hintText: "Select Product type",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: mode_controller,
                          decoration: InputDecoration(
                              hintText: "Select Mode of service",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: w * 0.9,
                          height: h * 0.25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Enter Product Keywords",
                                      style: TextStyle(color: Colors.grey)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: keyword_controller,
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade300,
                                        filled: true,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "Please Enter Keywords",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            var Data = ref.watch(getSettingsProvider);
                            return Data.when(data: (catdata) {
                              filteredSkuSet = [];
                              filteredSkuSet.addAll(catdata.skuSet!);
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: StatefulBuilder(
                                          builder:(
                                           BuildContext context,
                                           StateSetter setStatemat,
                                           ) {
                                            return   Container(
                                            height: h * 1,
                                            width: w * 1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: h * 0.06,
                                                  width: w * 0.9,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey.shade300,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0.1)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        filteredSkuSet.clear();
                                                        if (searchSkuSet.text
                                                            .trim() ==
                                                            "") {
                                                          filteredSkuSet.addAll(
                                                              catdata.skuSet!);
                                                          setStatemat(
                                                                  () {});
                                                        } else {
                                                          filteredSkuSet = [];
                                                          for (int i = 0;
                                                          i <
                                                              catdata.skuSet!
                                                                  .length;
                                                          i++) {
                                                            String name = catdata
                                                                .skuSet?[i] ??
                                                                "";
                                                            if (name
                                                                .toLowerCase()
                                                                .contains(searchSkuSet
                                                                .text
                                                                .toLowerCase()
                                                                .trim())) {
                                                              filteredSkuSet.add(
                                                                  catdata.skuSet![
                                                                  i]);
                                                            }
                                                          }
                                                          setStatemat(
                                                                  () {});
                                                        }
                                                      },
                                                      controller: searchSkuSet,
                                                      decoration: InputDecoration(
                                                          prefixIcon:
                                                          Icon(Icons.search),
                                                          hintText:
                                                          "Search Product SKU Set",
                                                          hintStyle: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14),
                                                          focusedBorder:
                                                          InputBorder.none,
                                                          enabledBorder:
                                                          InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount:
                                                    filteredSkuSet.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final isSelected =
                                                          skuController.text ==
                                                              filteredSkuSet[
                                                              index];
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            skuController.text =
                                                            filteredSkuSet[
                                                            index];
                                                            searchSkuSet.clear();
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              bottom: 10),
                                                          height: h * 0.06,
                                                          width: w * 0.9,
                                                          color: isSelected
                                                              ? Colors
                                                              .grey.shade300
                                                              : Colors
                                                              .transparent,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child: Text(
                                                                    filteredSkuSet[
                                                                    index]
                                                                        .toString()),
                                                              ),
                                                              if (isSelected)
                                                                Icon(Icons.check)
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ); }

                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.018,
                                                    bottom: h * 0.018),
                                                child: skuController
                                                        .text.isEmpty
                                                    ? Text(
                                                        "Select Product SKU Set",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .grey),
                                                      )
                                                    : Text(
                                                        skuController.text,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_sharp,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }, error: (error, stackTrace) {
                              return Text(error.toString());
                            }, loading: () {
                              return CircularProgressIndicator();
                            });
                          },
                        ),
                        Divider(),

                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: varient_controller,
                          decoration: InputDecoration(
                              hintText: "Select Varient",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 0.41,
                              height: w * 0.15,
                              child: TextFormField(
                                controller: price_controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: "Price",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: alertContext,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DurationPicker(
                                              duration: _duration,
                                              onChange: (value) {
                                                leadingTimeController.text =
                                                    leadingTimeFormat(
                                                        value.inMinutes);
                                                leadingTime = value.inMinutes;
                                                setState(() {
                                                  _duration = value;
                                                });
                                              },
                                              snapToMins: 5.0,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Done"))
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                );
                              },
                              child: AbsorbPointer(
                                absorbing: true,
                                child: SizedBox(
                                  width: w * 0.41,
                                  height: w * 0.15,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+')),
                                    ],
                                    controller: leadingTimeController,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      hintText: "Lead Time",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 0.41,
                              height: w * 0.15,
                              child: TextFormField(
                                controller: min_controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: "Min Count",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                            ),
                            SizedBox(
                              width: w * 0.41,
                              height: w * 0.15,
                              child: TextFormField(
                                controller: max_controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: "Max Count",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: h * 0.06,
                                width: w * 0.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.pink,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.pink),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                createProduct(ProductModel());
                              },
                              child: Container(
                                height: h * 0.06,
                                width: w * 0.33,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.pink),
                                child: Center(
                                    child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
