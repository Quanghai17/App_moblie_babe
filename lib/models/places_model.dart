class Places {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? image;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? googleMap;
  String? phone;
  String? status;
  int? featured;
  String? metaDescription;
  String? metaKeywords;
  String? seoTitle;
  String? multiimage;
  int? ownerId;

  Places(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.image,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.googleMap,
      this.phone,
      this.status,
      this.featured,
      this.metaDescription,
      this.metaKeywords,
      this.seoTitle,
      this.multiimage,
      this.ownerId});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address = json['address'];
    googleMap = json['google_map'];
    phone = json['phone'];
    status = json['status'];
    featured = json['featured'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    seoTitle = json['seo_title'];
    multiimage = json['multiimage'];
    ownerId = json['owner_id'];
  }
}
