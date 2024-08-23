class ContactModel {
  String name;
  String email;
  String phone;
  String message;

  ContactModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["message"] = this.message;
    return data;
  }
}
