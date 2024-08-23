class Room {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? content;
  String? image;
  String? multiimage;
  String? utilities;
  int? numberOfBeds;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? price;
  int? ownerId;

  Room(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.content,
      this.image,
      this.multiimage,
      this.utilities,
      this.numberOfBeds,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.ownerId});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    content = json['content'];
    image = json['image'];
    multiimage = json['multiimage'];
    utilities = json['utilities'];
    numberOfBeds = json['number_of_beds'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    ownerId = json['owner_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['content'] = this.content;
    data['image'] = this.image;
    data['multiimage'] = this.multiimage;
    data['utilities'] = this.utilities;
    data['number_of_beds'] = this.numberOfBeds;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['owner_id'] = this.ownerId;
    return data;
  }
}
