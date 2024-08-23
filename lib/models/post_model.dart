class Post {
  int? id;
  int? authorId;
  int? categoryId;
  String? title;
  String? seoTitle;
  String? excerpt;
  String? body;
  String? image;
  String? slug;
  String? metaDescription;
  String? metaKeywords;
  String? status;
  int? featured;
  String? createdAt;
  String? updatedAt;

  Post(
      {this.id,
      this.authorId,
      this.categoryId,
      this.title,
      this.seoTitle,
      this.excerpt,
      this.body,
      this.image,
      this.slug,
      this.metaDescription,
      this.metaKeywords,
      this.status,
      this.featured,
      this.createdAt,
      this.updatedAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    categoryId = json['category_id'];
    title = json['title'];
    seoTitle = json['seo_title'];
    excerpt = json['excerpt'];
    body = json['body'];
    image = json['image'];
    slug = json['slug'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    status = json['status'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
