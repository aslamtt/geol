class SettingModel{
  int? productId;
  int? vendorid;

//<editor-fold desc="Data Methods">
  SettingModel({
    this.productId,
    this.vendorid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          vendorid == other.vendorid);

  @override
  int get hashCode => productId.hashCode ^ vendorid.hashCode;

  @override
  String toString() {
    return 'SettingModel{' +
        ' productId: $productId,' +
        ' vendorid: $vendorid,' +
        '}';
  }

  SettingModel copyWith({
    int? productId,
    int? vendorid,
  }) {
    return SettingModel(
      productId: productId ?? this.productId,
      vendorid: vendorid ?? this.vendorid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'vendorid': this.vendorid,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      productId: map['productId'] as int,
      vendorid: map['vendorid'] as int,
    );
  }

//</editor-fold>
}