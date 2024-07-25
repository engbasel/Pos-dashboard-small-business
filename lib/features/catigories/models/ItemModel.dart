class ItemModel {
  final int? id;
  final int? categoryId;
  late final String name;
  late final String description;
  late final String? sku;
  late final String? barcode;
  late final double? purchasePrice;
  late final double? salePrice;
  late final double? wholesalePrice;
  late final double? taxRate;
  late final int? quantity;
  late final int? alertQuantity;
  late final String? image;
  late final String? brand;
  late final String? size;
  late final double? weight;
  late final String? color;
  late final String? material;
  late final String? warranty;
  late final int? supplierId;
  late final String? itemStatus;
  final DateTime? dateAdded;
  final DateTime? dateModified;

  ItemModel({
    this.id,
    this.categoryId,
    required this.name,
    this.description = '',
    this.sku,
    this.barcode,
    this.purchasePrice,
    this.salePrice,
    this.wholesalePrice,
    this.taxRate,
    this.quantity,
    this.alertQuantity,
    this.image,
    this.brand,
    this.size,
    this.weight,
    this.color,
    this.material,
    this.warranty,
    this.supplierId,
    this.itemStatus,
    this.dateAdded,
    this.dateModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'sku': sku,
      'barcode': barcode,
      'purchasePrice': purchasePrice,
      'salePrice': salePrice,
      'wholesalePrice': wholesalePrice,
      'taxRate': taxRate,
      'quantity': quantity,
      'alertQuantity': alertQuantity,
      'image': image,
      'brand': brand,
      'size': size,
      'weight': weight,
      'color': color,
      'material': material,
      'warranty': warranty,
      'supplierId': supplierId,
      'itemStatus': itemStatus,
      'dateAdded': dateAdded?.toIso8601String(),
      'dateModified': dateModified?.toIso8601String(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      description: map['description'],
      sku: map['sku'],
      barcode: map['barcode'],
      purchasePrice: map['purchasePrice'],
      salePrice: map['salePrice'],
      wholesalePrice: map['wholesalePrice'],
      taxRate: map['taxRate'],
      quantity: map['quantity'],
      alertQuantity: map['alertQuantity'],
      image: map['image'],
      brand: map['brand'],
      size: map['size'],
      weight: map['weight'],
      color: map['color'],
      material: map['material'],
      warranty: map['warranty'],
      supplierId: map['supplierId'],
      itemStatus: map['itemStatus'],
      dateAdded:
          map['dateAdded'] != null ? DateTime.parse(map['dateAdded']) : null,
      dateModified: map['dateModified'] != null
          ? DateTime.parse(map['dateModified'])
          : null,
    );
  }
}
