class Notifications {
  final int id;
  final String title;
  final String body;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String image;

  Notifications({
    required this.id,
    required this.title,
    required this.body,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  // Tạo factory constructor để khởi tạo từ JSON
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
    );
  }
}
