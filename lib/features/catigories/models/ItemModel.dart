// class ItemModel {
//   final int? id;
//   final int categoryId;
//   final String name;
//   final String description; // Optional field for more details

//   ItemModel(
//       {this.id,
//       required this.categoryId,
//       required this.name,
//       this.description = ''});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'categoryId': categoryId,
//       'name': name,
//       'description': description,
//     };
//   }

//   factory ItemModel.fromMap(Map<String, dynamic> map) {
//     return ItemModel(
//       id: map['id'],
//       categoryId: map['categoryId'],
//       name: map['name'],
//       description: map['description'],
//     );
//   }
// }

class ItemModel {
  final int? id;
  final int? categoryId;
  final String name;
  final String description;
  final String? sku;
  final String? barcode;
  final double? purchasePrice;
  final double? salePrice;
  final double? wholesalePrice;
  final double? taxRate;
  final int? quantity;
  final int? alertQuantity;
  final String? image;
  final String? brand;
  final String? size;
  final double? weight;
  final String? color;
  final String? material;
  final String? warranty;
  final int? supplierId;
  final String? itemStatus;
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
