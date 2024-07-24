class ItemDatabaseConstants {
  static const String itemsTable = 'items';
  static const String databaseFileName = 'items.db';
  static const int versionDatabase = 1;

  // Column Names
  static const String columnId = 'id';
  static const String columnCategoryId = 'categoryId';
  static const String columnName = 'name';
  static const String columnDescription = 'description';
  static const String columnSKU = 'sku';
  static const String columnBarcode = 'barcode';
  static const String columnPurchasePrice = 'purchasePrice';
  static const String columnSalePrice = 'salePrice';
  static const String columnWholesalePrice = 'wholesalePrice';
  static const String columnTaxRate = 'taxRate';
  static const String columnQuantity = 'quantity';
  static const String columnAlertQuantity = 'alertQuantity';
  static const String columnImage = 'image';
  static const String columnBrand = 'brand';
  static const String columnSize = 'size';
  static const String columnWeight = 'weight';
  static const String columnColor = 'color';
  static const String columnMaterial = 'material';
  static const String columnWarranty = 'warranty';
  static const String columnSupplierId = 'supplierId';
  static const String columnItemStatus = 'itemStatus';
  static const String columnDateAdded = 'dateAdded';
  static const String columnDateModified = 'dateModified';
}
