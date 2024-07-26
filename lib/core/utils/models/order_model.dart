class Order {
  final String id;
  final String dateTime;
  final String type;
  final String employee;
  final String status;
  final String paymentStatus;
  final double amount;
  final int numberOfItems;
  final String entryDate;
  final String exitDate;
  final double wholesalePrice;
  final double retailPrice;
  final String productStatus;
  final String productDetails;
  final String productModel;
  final String category; // Add this field

  Order({
    required this.id,
    required this.dateTime,
    required this.type,
    required this.employee,
    required this.status,
    required this.paymentStatus,
    required this.amount,
    required this.numberOfItems,
    required this.entryDate,
    required this.exitDate,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.productStatus,
    required this.productDetails,
    required this.productModel,
    required this.category, // Add this to the constructor
  });

  // Factory method to create an Order from a Map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      dateTime: map['dateTime'] ?? '',
      type: map['type'] ?? '',
      employee: map['employee'] ?? '',
      status: map['status'] ?? '',
      paymentStatus: map['paymentStatus'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      numberOfItems: int.tryParse(map['numberOfItems']?.toString() ?? '0') ?? 0,
      entryDate: map['entryDate'] ?? '',
      exitDate: map['exitDate'] ?? '',
      wholesalePrice: (map['wholesalePrice'] ?? 0).toDouble(),
      retailPrice: (map['retailPrice'] ?? 0).toDouble(),
      productStatus: map['productStatus'] ?? '',
      productDetails: map['productDetails'] ?? '',
      productModel: map['productModel'] ?? '',
      category: map['category'] ?? '', // Add this to the factory method
    );
  }

  // Method to convert Order to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'type': type,
      'employee': employee,
      'status': status,
      'paymentStatus': paymentStatus,
      'amount': amount,
      'numberOfItems': numberOfItems,
      'entryDate': entryDate,
      'exitDate': exitDate,
      'wholesalePrice': wholesalePrice,
      'retailPrice': retailPrice,
      'productStatus': productStatus,
      'productDetails': productDetails,
      'productModel': productModel,
      'category': category, // Add this to the map method
    };
  }

  toJson() {}
}
