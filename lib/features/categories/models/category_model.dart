class CategoryModel {
  final int? id;
  final String title;
  final int color;

  CategoryModel({
    this.id,
    required this.title,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      title: map['title'],
      color: map['color'],
    );
  }
}
