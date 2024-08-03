class IncomingOrderDatabaseConstants {
  // General Section in any database SQL helper
  static const String incomingOrdersTable = 'incoming_orders';
  static const String databaseFileName = 'IncomingOrdersDatabase.db';
  static const int versionDatabase = 1;

  // Columns Name of SQL helper
  static const String columnId = 'id';
  static const String columnOrderId = 'orderId';
  static const String columnSupplierName = 'supplierName';
  static const String columnOrderDate = 'orderDate';
  static const String columnExpectedDeliveryDate = 'expectedDeliveryDate';
  static const String columnOrderStatus = 'orderStatus';
  static const String columnTotalAmount = 'totalAmount';
}
