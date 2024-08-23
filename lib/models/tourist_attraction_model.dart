class TouristAttraction {
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

  TouristAttraction(
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
      this.updatedAt});

  TouristAttraction.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
