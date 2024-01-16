import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String? name;
  bool? localDelicacies;
  String? image;
  String? shortdiscription;
  String? longdiscription;
  String? productype;
  String? modeservice;
  String? productKey;
  String? skuset;
  String? varient;
  int? price;
  int? leadTime;
  int? mincount;
  int? maxcount;
  DocumentReference? reference;
  String? productId;

//<editor-fold desc="Data Methods">
  ProductModel({
    this.name,
    this.localDelicacies,
    this.image,
    this.shortdiscription,
    this.longdiscription,
    this.productype,
    this.modeservice,
    this.productKey,
    this.skuset,
    this.varient,
    this.price,
    this.leadTime,
    this.mincount,
    this.maxcount,
    this.reference,
    this.productId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          localDelicacies == other.localDelicacies &&
          image == other.image &&
          shortdiscription == other.shortdiscription &&
          longdiscription == other.longdiscription &&
          productype == other.productype &&
          modeservice == other.modeservice &&
          productKey == other.productKey &&
          skuset == other.skuset &&
          varient == other.varient &&
          price == other.price &&
          leadTime == other.leadTime &&
          mincount == other.mincount &&
          maxcount == other.maxcount &&
          reference == other.reference &&
          productId == other.productId);

  @override
  int get hashCode =>
      name.hashCode ^
      localDelicacies.hashCode ^
      image.hashCode ^
      shortdiscription.hashCode ^
      longdiscription.hashCode ^
      productype.hashCode ^
      modeservice.hashCode ^
      productKey.hashCode ^
      skuset.hashCode ^
      varient.hashCode ^
      price.hashCode ^
      leadTime.hashCode ^
      mincount.hashCode ^
      maxcount.hashCode ^
      reference.hashCode ^
      productId.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' name: $name,' +
        ' localDelicacies: $localDelicacies,' +
        ' image: $image,' +
        ' shortdiscription: $shortdiscription,' +
        ' longdiscription: $longdiscription,' +
        ' productype: $productype,' +
        ' modeservice: $modeservice,' +
        ' productKey: $productKey,' +
        ' skuset: $skuset,' +
        ' varient: $varient,' +
        ' price: $price,' +
        ' leadTime: $leadTime,' +
        ' mincount: $mincount,' +
        ' maxcount: $maxcount,' +
        ' reference: $reference,' +
        ' productId: $productId,' +
        '}';
  }

  ProductModel copyWith({
    String? name,
    bool? localDelicacies,
    String? image,
    String? shortdiscription,
    String? longdiscription,
    String? productype,
    String? modeservice,
    String? productKey,
    String? skuset,
    String? varient,
    int? price,
    int? leadTime,
    int? mincount,
    int? maxcount,
    DocumentReference? reference,
    String? productId,
  }) {
    return ProductModel(
      name: name ?? this.name,
      localDelicacies: localDelicacies ?? this.localDelicacies,
      image: image ?? this.image,
      shortdiscription: shortdiscription ?? this.shortdiscription,
      longdiscription: longdiscription ?? this.longdiscription,
      productype: productype ?? this.productype,
      modeservice: modeservice ?? this.modeservice,
      productKey: productKey ?? this.productKey,
      skuset: skuset ?? this.skuset,
      varient: varient ?? this.varient,
      price: price ?? this.price,
      leadTime: leadTime ?? this.leadTime,
      mincount: mincount ?? this.mincount,
      maxcount: maxcount ?? this.maxcount,
      reference: reference ?? this.reference,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'localDelicacies': this.localDelicacies,
      'image': this.image,
      'shortdiscription': this.shortdiscription,
      'longdiscription': this.longdiscription,
      'productype': this.productype,
      'modeservice': this.modeservice,
      'productKey': this.productKey,
      'skuset': this.skuset,
      'varient': this.varient,
      'price': this.price,
      'leadTime': this.leadTime,
      'mincount': this.mincount,
      'maxcount': this.maxcount,
      'reference': this.reference,
      'productId': this.productId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      localDelicacies: map['localDelicacies'] as bool,
      image: map['image'] as String,
      shortdiscription: map['shortdiscription'] as String,
      longdiscription: map['longdiscription'] as String,
      productype: map['productype'] as String,
      modeservice: map['modeservice'] as String,
      productKey: map['productKey'] as String,
      skuset: map['skuset'] as String,
      varient: map['varient'] as String,
      price: map['price'] as int,
      leadTime: map['leadTime'] as int,
      mincount: map['mincount'] as int,
      maxcount: map['maxcount'] as int,
      reference: map['reference'] as DocumentReference,
      productId: map['productId'] as String,
    );
  }

//</editor-fold>
}

enum ProductStatus {
  delete,
  update,
  create,
  clone,
}