class ItemModel {
  final int? id;
  final int categoryId;
  final String name;
  final String description; // Optional field for more details

  ItemModel(
      {this.id,
      required this.categoryId,
      required this.name,
      this.description = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      description: map['description'],
    );
  }
}
