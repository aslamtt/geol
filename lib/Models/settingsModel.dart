class SettingModel{
  int? productId;
  int? vendorid;
  List<String>? skuSet;

//<editor-fold desc="Data Methods">
  SettingModel({
    this.productId,
    this.vendorid,
    this.skuSet,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          vendorid == other.vendorid &&
          skuSet == other.skuSet);

  @override
  int get hashCode => productId.hashCode ^ vendorid.hashCode ^ skuSet.hashCode;

  @override
  String toString() {
    return 'SettingModel{' +
        ' productId: $productId,' +
        ' vendorid: $vendorid,' +
        ' skuSet: $skuSet,' +
        '}';
  }

  SettingModel copyWith({
    int? productId,
    int? vendorid,
    List<String>? skuSet,
  }) {
    return SettingModel(
      productId: productId ?? this.productId,
      vendorid: vendorid ?? this.vendorid,
      skuSet: skuSet ?? this.skuSet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'vendorid': this.vendorid,
      'skuSet': this.skuSet,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      productId: map['productId'] as int,
      vendorid: map['vendorid'] as int,
      skuSet:List<String>.from(map['skuSet'] ),
    );
  }
//</editor-fold>
}