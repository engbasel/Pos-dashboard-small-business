// // // class Order {
// // //   final String id;
// // //   final String dateTime;
// // //   final String type;
// // //   final String employee;
// // //   final String status;
// // //   final String paymentStatus;
// // //   final double amount;

// // //   Order(this.id, this.dateTime, this.type, this.employee, this.status,
// // //       this.paymentStatus, this.amount);

// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'id': id,
// // //       'dateTime': dateTime,
// // //       'type': type,
// // //       'employee': employee,
// // //       'status': status,
// // //       'paymentStatus': paymentStatus,
// // //       'amount': amount,
// // //     };
// // //   }

// // //   factory Order.fromMap(Map<String, dynamic> map) {
// // //     return Order(
// // //       map['id'],
// // //       map['dateTime'],
// // //       map['type'],
// // //       map['employee'],
// // //       map['status'],
// // //       map['paymentStatus'],
// // //       map['amount'],
// // //     );
// // //   }
// // // }

// // class Order {
// //   final String id;
// //   final String dateTime;
// //   final String type;
// //   final String employee;
// //   final String status;
// //   final String paymentStatus;
// //   final double amount;
// //   final int numberOfItems; // New fields
// //   final String entryDate;
// //   final String exitDate;
// //   final double wholesalePrice;
// //   final double retailPrice;
// //   final String productStatus;
// //   final String productDetails;
// //   final String productModel;

// //   Order({
// //     required this.id,
// //     required this.dateTime,
// //     required this.type,
// //     required this.employee,
// //     required this.status,
// //     required this.paymentStatus,
// //     required this.amount,
// //     required this.numberOfItems,
// //     required this.entryDate,
// //     required this.exitDate,
// //     required this.wholesalePrice,
// //     required this.retailPrice,
// //     required this.productStatus,
// //     required this.productDetails,
// //     required this.productModel,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'dateTime': dateTime,
// //       'type': type,
// //       'employee': employee,
// //       'status': status,
// //       'paymentStatus': paymentStatus,
// //       'amount': amount,
// //       'numberOfItems': numberOfItems,
// //       'entryDate': entryDate,
// //       'exitDate': exitDate,
// //       'wholesalePrice': wholesalePrice,
// //       'retailPrice': retailPrice,
// //       'productStatus': productStatus,
// //       'productDetails': productDetails,
// //       'productModel': productModel,
// //     };
// //   }

// //   static Order fromMap(Map<String, dynamic> map) {
// //     return Order(
// //       id: map['id'],
// //       dateTime: map['dateTime'],
// //       type: map['type'],
// //       employee: map['employee'],
// //       status: map['status'],
// //       paymentStatus: map['paymentStatus'],
// //       amount: map['amount'],
// //       numberOfItems: map['numberOfItems'],
// //       entryDate: map['entryDate'],
// //       exitDate: map['exitDate'],
// //       wholesalePrice: map['wholesalePrice'],
// //       retailPrice: map['retailPrice'],
// //       productStatus: map['productStatus'],
// //       productDetails: map['productDetails'],
// //       productModel: map['productModel'],
// //     );
// //   }
// // }

// class Order {
//   final String id;
//   final String dateTime;
//   final String type;
//   final String employee;
//   final String status;
//   final String paymentStatus;
//   final double amount;
//   final int numberOfItems;
//   final String entryDate;
//   final String exitDate;
//   final double wholesalePrice;
//   final double retailPrice;
//   final String productStatus;
//   final String productDetails;
//   final String productModel;

//   Order({
//     required this.id,
//     required this.dateTime,
//     required this.type,
//     required this.employee,
//     required this.status,
//     required this.paymentStatus,
//     required this.amount,
//     required this.numberOfItems,
//     required this.entryDate,
//     required this.exitDate,
//     required this.wholesalePrice,
//     required this.retailPrice,
//     required this.productStatus,
//     required this.productDetails,
//     required this.productModel,
//   });

//   // Factory method to create an Order from a Map
//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       id: map['id'] ?? '',
//       dateTime: map['dateTime'] ?? '',
//       type: map['type'] ?? '',
//       employee: map['employee'] ?? '',
//       status: map['status'] ?? '',
//       paymentStatus: map['paymentStatus'] ?? '',
//       amount: (map['amount'] ?? 0).toDouble(),
//       numberOfItems: map['numberOfItems'] ?? 0,
//       entryDate: map['entryDate'] ?? '',
//       exitDate: map['exitDate'] ?? '',
//       wholesalePrice: (map['wholesalePrice'] ?? 0).toDouble(),
//       retailPrice: (map['retailPrice'] ?? 0).toDouble(),
//       productStatus: map['productStatus'] ?? '',
//       productDetails: map['productDetails'] ?? '',
//       productModel: map['productModel'] ?? '',
//     );
//   }

//   // Method to convert Order to a Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'dateTime': dateTime,
//       'type': type,
//       'employee': employee,
//       'status': status,
//       'paymentStatus': paymentStatus,
//       'amount': amount,
//       'numberOfItems': numberOfItems,
//       'entryDate': entryDate,
//       'exitDate': exitDate,
//       'wholesalePrice': wholesalePrice,
//       'retailPrice': retailPrice,
//       'productStatus': productStatus,
//       'productDetails': productDetails,
//       'productModel': productModel,
//     };
//   }
// }

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
    };
  }
}
