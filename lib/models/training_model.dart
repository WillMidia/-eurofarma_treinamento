class Training {
  final int id;
  final String title;
  final String description;
  final String icon;

  Training({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      icon: map['icon'],
    );
  }
}
