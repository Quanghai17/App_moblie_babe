class UpdatePasswordModel {
  String? password;
  String? new_password;
  String? confirm_password;

  UpdatePasswordModel({
    this.password,
    this.new_password,
    this.confirm_password,
  });

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    new_password = json['new_password'];
    confirm_password = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['new_password'] = this.new_password;
    data['confirm_password'] = this.confirm_password;
    return data;
  }
}
