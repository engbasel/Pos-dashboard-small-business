// ignore: file_names
import 'package:pos_dashboard_v1/features/customers/models/transaction_model.dart';

class CustomerModel {
  String id;
  String name;
  String phoneNumber;
  String? email;
  String? address;
  DateTime creationDate;
  String? notes;
  double balance;
  DateTime lastTransactionDate;
  String? birthDate;
  String? gender;
  String? occupation;
  String? status;
  String? alternativePhone;
  String? socialMedia;
  String? fax;
  double? creditLimit;
  double? totalOutstandingAmount;
  String? creditRating;
  String? preferredPaymentMethod;
  String? secondaryAddress;
  String? postalCode;
  String? deliveryPreferences;
  DateTime? lastContactDate;
  String? customerInterests;
  String? customerSatisfactionLevel;
  double? annualPurchaseVolume;
  int? complaintCount;
  String? complaintResolutionHistory;
  String? supportRating;
  double? customerDiscount;
  List<String>? activeOffers;
  DateTime? discountExpirationDate;
  List<String>? documentImages;
  List<String>? contracts;
  List<String>? activityLog;
  String? responsibleEmployee;

  List<TransactionModel> transactions;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.address,
    required this.creationDate,
    this.notes,
    required this.balance,
    required this.lastTransactionDate,
    this.birthDate,
    this.gender,
    this.occupation,
    this.status,
    this.alternativePhone,
    this.socialMedia,
    this.fax,
    this.creditLimit,
    this.totalOutstandingAmount,
    this.creditRating,
    this.preferredPaymentMethod,
    this.secondaryAddress,
    this.postalCode,
    this.deliveryPreferences,
    this.lastContactDate,
    this.customerInterests,
    this.customerSatisfactionLevel,
    this.annualPurchaseVolume,
    this.complaintCount,
    this.complaintResolutionHistory,
    this.supportRating,
    this.customerDiscount,
    this.activeOffers,
    this.discountExpirationDate,
    this.documentImages,
    this.contracts,
    this.activityLog,
    this.responsibleEmployee,
    this.transactions = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'creationDate': creationDate.toIso8601String(),
      'notes': notes,
      'balance': balance,
      'lastTransactionDate': lastTransactionDate.toIso8601String(),
      'birthDate': birthDate,
      'gender': gender,
      'occupation': occupation,
      'status': status,
      'alternativePhone': alternativePhone,
      'socialMedia': socialMedia,
      'fax': fax,
      'creditLimit': creditLimit,
      'totalOutstandingAmount': totalOutstandingAmount,
      'creditRating': creditRating,
      'preferredPaymentMethod': preferredPaymentMethod,
      'secondaryAddress': secondaryAddress,
      'postalCode': postalCode,
      'deliveryPreferences': deliveryPreferences,
      'lastContactDate': lastContactDate?.toIso8601String(),
      'customerInterests': customerInterests,
      'customerSatisfactionLevel': customerSatisfactionLevel,
      'annualPurchaseVolume': annualPurchaseVolume,
      'complaintCount': complaintCount,
      'complaintResolutionHistory': complaintResolutionHistory,
      'supportRating': supportRating,
      'customerDiscount': customerDiscount,
      'activeOffers': activeOffers,
      'discountExpirationDate': discountExpirationDate?.toIso8601String(),
      'documentImages': documentImages,
      'contracts': contracts,
      'activityLog': activityLog,
      'responsibleEmployee': responsibleEmployee,
      'transactions': transactions.map((t) => t.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'],
      address: map['address'],
      creationDate: DateTime.parse(map['creationDate']),
      notes: map['notes'],
      balance: map['balance']?.toDouble() ?? 0.0,
      lastTransactionDate: DateTime.parse(map['lastTransactionDate']),
      birthDate: map['birthDate'],
      gender: map['gender'],
      occupation: map['occupation'],
      status: map['status'],
      alternativePhone: map['alternativePhone'],
      socialMedia: map['socialMedia'],
      fax: map['fax'],
      creditLimit: map['creditLimit']?.toDouble(),
      totalOutstandingAmount: map['totalOutstandingAmount']?.toDouble(),
      creditRating: map['creditRating'],
      preferredPaymentMethod: map['preferredPaymentMethod'],
      secondaryAddress: map['secondaryAddress'],
      postalCode: map['postalCode'],
      deliveryPreferences: map['deliveryPreferences'],
      lastContactDate: map['lastContactDate'] != null
          ? DateTime.parse(map['lastContactDate'])
          : null,
      customerInterests: map['customerInterests'],
      customerSatisfactionLevel: map['customerSatisfactionLevel'],
      annualPurchaseVolume: map['annualPurchaseVolume']?.toDouble(),
      complaintCount: map['complaintCount']?.toInt(),
      complaintResolutionHistory: map['complaintResolutionHistory'],
      supportRating: map['supportRating'],
      customerDiscount: map['customerDiscount']?.toDouble(),
      activeOffers: List<String>.from(map['activeOffers'] ?? []),
      discountExpirationDate: map['discountExpirationDate'] != null
          ? DateTime.parse(map['discountExpirationDate'])
          : null,
      documentImages: List<String>.from(map['documentImages'] ?? []),
      contracts: List<String>.from(map['contracts'] ?? []),
      activityLog: List<String>.from(map['activityLog'] ?? []),
      responsibleEmployee: map['responsibleEmployee'],
      transactions: List<TransactionModel>.from(
          map['transactions']?.map((t) => TransactionModel.fromMap(t)) ?? []),
    );
  }
}
