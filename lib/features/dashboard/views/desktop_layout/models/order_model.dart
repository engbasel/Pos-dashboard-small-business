class Order {
  final String id;
  final String dateTime;
  final String type;
  final String employee;
  final String status;
  final String paymentStatus;
  final double amount;

  Order(
    this.id,
    this.dateTime,
    this.type,
    this.employee,
    this.status,
    this.paymentStatus,
    this.amount,
  );
}
