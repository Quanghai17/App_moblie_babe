import 'dart:io';

class UpdateUserModel {
  String? name;
  String? email;
  File? avatar;
  String? password;

  UpdateUserModel({
    this.name,
    this.email,
    this.avatar,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
