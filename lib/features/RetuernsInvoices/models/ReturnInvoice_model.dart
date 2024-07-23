import '../database/database_constans.dart';

class ReturnInvoice {
  final String id;
  final String orderId;
  final String returnDate;
  final String employee;
  final String reason;
  final double amount;
  final double totalbackmony;

  ReturnInvoice({
    required this.id,
    required this.orderId,
    required this.returnDate,
    required this.employee,
    required this.reason,
    required this.amount,
    required this.totalbackmony,
  });

  Map<String, dynamic> toMap() {
    return {
      RetuernInvocmentDatabaseConstants.columnId: id,
      RetuernInvocmentDatabaseConstants.columnOrderId: orderId,
      RetuernInvocmentDatabaseConstants.columnReturnDate: returnDate,
      RetuernInvocmentDatabaseConstants.columnEmployee: employee,
      RetuernInvocmentDatabaseConstants.columnReason: reason,
      RetuernInvocmentDatabaseConstants.columnAmount: amount,
      RetuernInvocmentDatabaseConstants.columnTotalBackMoney: totalbackmony,
    };
  }

  factory ReturnInvoice.fromMap(Map<String, dynamic> map) {
    return ReturnInvoice(
      id: map[RetuernInvocmentDatabaseConstants.columnId],
      totalbackmony:
          map[RetuernInvocmentDatabaseConstants.columnTotalBackMoney],
      orderId: map[RetuernInvocmentDatabaseConstants.columnOrderId],
      returnDate: map[RetuernInvocmentDatabaseConstants.columnReturnDate],
      employee: map[RetuernInvocmentDatabaseConstants.columnEmployee],
      reason: map[RetuernInvocmentDatabaseConstants.columnReason],
      amount: map[RetuernInvocmentDatabaseConstants.columnAmount],
    );
  }
}
