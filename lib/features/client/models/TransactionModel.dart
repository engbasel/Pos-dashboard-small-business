// ignore: file_names
class TransactionModel {
  String id;
  DateTime date;
  String type;
  String description;
  double amount;

  TransactionModel({
    required this.id,
    required this.date,
    required this.type,
    required this.description,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
      'amount': amount,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }
}
