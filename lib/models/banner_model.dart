class BannerModel {
  int? id;
  String? title;
  String? desc;
  String? image;
  String? status;
  String? type;
  String? link;
  String? createdAt;
  String? updatedAt;

  BannerModel(
      {this.id,
      this.title,
      this.desc,
      this.image,
      this.status,
      this.type,
      this.link,
      this.createdAt,
      this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
