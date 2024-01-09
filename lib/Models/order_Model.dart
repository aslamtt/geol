class OrderModel{
  String?productName;
  int? price;
  int?quandity;
  int? orderStatus;
  String?id;

//<editor-fold desc="Data Methods">
  OrderModel({
    this.productName,
    this.price,
    this.quandity,
    this.orderStatus,
    this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderModel &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          price == other.price &&
          quandity == other.quandity &&
          orderStatus == other.orderStatus &&
          id == other.id);

  @override
  int get hashCode =>
      productName.hashCode ^
      price.hashCode ^
      quandity.hashCode ^
      orderStatus.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'OrderModel{' +
        ' productName: $productName,' +
        ' price: $price,' +
        ' quandity: $quandity,' +
        ' orderStatus: $orderStatus,' +
        ' id: $id,' +
        '}';
  }

  OrderModel copyWith({
    String? productName,
    int? price,
    int? quandity,
    int? orderStatus,
    String? id,
  }) {
    return OrderModel(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quandity: quandity ?? this.quandity,
      orderStatus: orderStatus ?? this.orderStatus,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'price': this.price,
      'quandity': this.quandity,
      'orderStatus': this.orderStatus,
      'id': this.id,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productName: map['productName'] as String,
      price: map['price'] as int,
      quandity: map['quandity'] as int,
      orderStatus: map['orderStatus'] as int,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}