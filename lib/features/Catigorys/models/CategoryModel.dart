// class Category {
//   final int? id;
//   final String title;
//   final int color;

//   Category({this.id, required this.title, required this.color});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'color': color,
//     };
//   }

//   factory Category.fromMap(Map<String, dynamic> map) {
//     return Category(
//       id: map['id'],
//       title: map['title'],
//       color: map['color'],
//     );
//   }
// }

class Category {
  final int? id;
  final String title;
  final int color;

  Category({this.id, required this.title, required this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
      color: map['color'],
    );
  }
}

class Item {
  final int? id;
  final int categoryId;
  final String name;
  final String description; // Optional field for more details

  Item(
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

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      description: map['description'],
    );
  }
}
