class IncomingOrderModel {
  final String id;
  final String orderId;
  final String supplierName;
  final String orderDate;
  final String expectedDeliveryDate;
  final String orderStatus;
  final double totalAmount;

  IncomingOrderModel({
    required this.id,
    required this.orderId,
    required this.supplierName,
    required this.orderDate,
    required this.expectedDeliveryDate,
    required this.orderStatus,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'supplierName': supplierName,
      'orderDate': orderDate,
      'expectedDeliveryDate': expectedDeliveryDate,
      'orderStatus': orderStatus,
      'totalAmount': totalAmount,
    };
  }

  static IncomingOrderModel fromMap(Map<String, dynamic> map) {
    return IncomingOrderModel(
      id: map['id'],
      orderId: map['orderId'],
      supplierName: map['supplierName'],
      orderDate: map['orderDate'],
      expectedDeliveryDate: map['expectedDeliveryDate'],
      orderStatus: map['orderStatus'],
      totalAmount: map['totalAmount'],
    );
  }
}
