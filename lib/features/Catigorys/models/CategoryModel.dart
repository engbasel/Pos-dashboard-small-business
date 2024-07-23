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
