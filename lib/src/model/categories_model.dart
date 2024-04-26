class Categories {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  List<String>? tags;
  int? viewers;
  Category? category;

  Categories(
      {this.id,
        this.categoryId,
        this.name,
        this.slug,
        this.tags,
        this.viewers,
        this.category});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    tags = json['tags'].cast<String>();
    viewers = json['viewers'];
    category =
    json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['slug'] = slug;
    data['tags'] = tags;
    data['viewers'] = viewers;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;

  Category({this.id, this.name, this.slug, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    return data;
  }
}
