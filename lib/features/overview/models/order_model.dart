class Order {
  final String id;
  final String dateTime;
  final String type;
  final String employee;
  final String status;
  final String paymentStatus;
  final double amount;

  Order(this.id, this.dateTime, this.type, this.employee, this.status,
      this.paymentStatus, this.amount);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'type': type,
      'employee': employee,
      'status': status,
      'paymentStatus': paymentStatus,
      'amount': amount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      map['id'],
      map['dateTime'],
      map['type'],
      map['employee'],
      map['status'],
      map['paymentStatus'],
      map['amount'],
    );
  }
}
