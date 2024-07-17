class ReturnInvoice {
  final String id;
  final String orderId;
  final String returnDate;
  final String employee;
  final String reason;
  final double amount;

  ReturnInvoice({
    required this.id,
    required this.orderId,
    required this.returnDate,
    required this.employee,
    required this.reason,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'returnDate': returnDate,
      'employee': employee,
      'reason': reason,
      'amount': amount,
    };
  }

  factory ReturnInvoice.fromMap(Map<String, dynamic> map) {
    return ReturnInvoice(
      id: map['id'],
      orderId: map['orderId'],
      returnDate: map['returnDate'],
      employee: map['employee'],
      reason: map['reason'],
      amount: map['amount'],
    );
  }
}
