class AboutUs {
  int? id;
  int? authorId;
  String? title;
  String? excerpt;
  String? body;
  String? image;
  String? slug;
  String? metaDescription;
  String? metaKeywords;
  String? status;
  String? createdAt;
  String? updatedAt;

  AboutUs(
      {this.id,
      this.authorId,
      this.title,
      this.excerpt,
      this.body,
      this.image,
      this.slug,
      this.metaDescription,
      this.metaKeywords,
      this.status,
      this.createdAt,
      this.updatedAt});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    title = json['title'];
    excerpt = json['excerpt'];
    body = json['body'];
    image = json['image'];
    slug = json['slug'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
