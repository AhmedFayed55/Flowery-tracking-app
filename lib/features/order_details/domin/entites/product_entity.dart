class ProductEntity {
  ProductEntity({
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.imgCover, 
      this.images, 
      this.price, 
      this.priceAfterDiscount, 
      this.quantity, 
      this.category, 
      this.occasion, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.isSuperAdmin, 
      this.sold,});

  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  bool? isSuperAdmin;
  num? sold;

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "imgCover": imgCover,
    "images": images,
    "price": price,
    "priceAfterDiscount": priceAfterDiscount,
    "quantity": quantity,
    "category": category,
    "occasion": occasion,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "isSuperAdmin": isSuperAdmin,
    "sold": sold,
  };

}