class Dish {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? image;
  String? content;
  int? price;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? multiimage;
  int? ownerId;
  List<Restaurants>? restaurants;

  Dish(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.image,
      this.content,
      this.price,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.multiimage,
      this.ownerId,
      this.restaurants});

  Dish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    content = json['content'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    multiimage = json['multiimage'];
    ownerId = json['owner_id'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['content'] = this.content;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['multiimage'] = this.multiimage;
    data['owner_id'] = this.ownerId;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? image;
  String? content;
  String? address;
  String? googleMap;
  int? phone;
  String? status;
  int? featured;
  String? metaDescription;
  String? metaKeywords;
  String? seoTitle;
  String? createdAt;
  String? updatedAt;
  String? multiimage;
  int? ownerId;
  String? calcRoute;
  Pivot? pivot;

  Restaurants(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.image,
      this.content,
      this.address,
      this.googleMap,
      this.phone,
      this.status,
      this.featured,
      this.metaDescription,
      this.metaKeywords,
      this.seoTitle,
      this.createdAt,
      this.updatedAt,
      this.multiimage,
      this.ownerId,
      this.calcRoute,
      this.pivot});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    content = json['content'];
    address = json['address'];
    googleMap = json['google_map'];
    phone = json['phone'];
    status = json['status'];
    featured = json['featured'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    seoTitle = json['seo_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    multiimage = json['multiimage'];
    ownerId = json['owner_id'];
    calcRoute = json['calcRoute'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['content'] = this.content;
    data['address'] = this.address;
    data['google_map'] = this.googleMap;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['seo_title'] = this.seoTitle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['multiimage'] = this.multiimage;
    data['owner_id'] = this.ownerId;
    data['calcRoute'] = this.calcRoute;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? dishId;
  int? restaurantId;

  Pivot({this.dishId, this.restaurantId});

  Pivot.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}
