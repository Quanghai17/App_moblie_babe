class Tour {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? image;
  String? multiimage;
  String? content;
  int? price;
  String? address;
  int? days;
  String? status;
  int? featured;
  String? metaDescription;
  String? metaKeywords;
  String? seoTitle;
  String? createdAt;
  String? updatedAt;
  String? imageMoblie;
  List<Locations>? locations;

  Tour(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.image,
      this.multiimage,
      this.content,
      this.price,
      this.address,
      this.days,
      this.status,
      this.featured,
      this.metaDescription,
      this.metaKeywords,
      this.seoTitle,
      this.createdAt,
      this.updatedAt,
      this.imageMoblie,
      this.locations});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    multiimage = json['multiimage'];
    content = json['content'];
    price = json['price'];
    address = json['address'];
    days = json['days'];
    status = json['status'];
    featured = json['featured'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    seoTitle = json['seo_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageMoblie = json['image_moblie'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['slug'] = this.slug;
  //   data['desc'] = this.desc;
  //   data['image'] = this.image;
  //   data['multiimage'] = this.multiimage;
  //   data['content'] = this.content;
  //   data['price'] = this.price;
  //   data['address'] = this.address;
  //   data['days'] = this.days;
  //   data['status'] = this.status;
  //   data['featured'] = this.featured;
  //   data['meta_description'] = this.metaDescription;
  //   data['meta_keywords'] = this.metaKeywords;
  //   data['seo_title'] = this.seoTitle;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['image_moblie'] = this.imageMoblie;
  //   if (this.locations != null) {
  //     data['locations'] = this.locations!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Locations {
  int? id;
  String? slug;
  String? desc;
  String? image;
  String? multiimage;
  String? content;
  String? address;
  String? googleMap;
  String? phone;
  String? status;
  int? featured;
  String? metaDescription;
  String? metaKeywords;
  String? seoTitle;
  String? title;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Locations(
      {this.id,
      this.slug,
      this.desc,
      this.image,
      this.multiimage,
      this.content,
      this.address,
      this.googleMap,
      this.phone,
      this.status,
      this.featured,
      this.metaDescription,
      this.metaKeywords,
      this.seoTitle,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    multiimage = json['multiimage'];
    content = json['content'];
    address = json['address'];
    googleMap = json['google_map'];
    phone = json['phone'];
    status = json['status'];
    featured = json['featured'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    seoTitle = json['seo_title'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['multiimage'] = this.multiimage;
    data['content'] = this.content;
    data['address'] = this.address;
    data['google_map'] = this.googleMap;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['seo_title'] = this.seoTitle;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? tourId;
  int? locationId;

  Pivot({this.tourId, this.locationId});

  Pivot.fromJson(Map<String, dynamic> json) {
    tourId = json['tour_id'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tour_id'] = this.tourId;
    data['location_id'] = this.locationId;
    return data;
  }
}
