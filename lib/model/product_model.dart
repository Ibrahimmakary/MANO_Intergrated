class Product {
  bool isUsable= false ;
  int id = 0;
  String title = "";
  String sku = "";
  bool favorite=false;
  List<Categories> categories=[];
  String originalPrice = "";
  String discountedPrice = "";
  String price = "";
  int quantity = 0;
  int maxAllowedQuantity = 0;
  String shelfZone = "";
  String shelfSection = "";
  int storeId = 0;
  List<Images> images = [];

  Product({
    this.id = 0,
    this.quantity = 0,
    this.maxAllowedQuantity = 0,
    this.storeId = 0,
    this.favorite=false,

    this.title="",
    this.sku="",
    this.originalPrice="",
    this.discountedPrice="",
    this.price="",
    this.shelfZone="",
    this.shelfSection="",
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    title = json['title']??"";
    sku = json['sku']??"";
    favorite = json['favorite']??false;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    originalPrice = json['original_price']??"";
    discountedPrice = json['discounted_price']??"";
    price = json['price']??"";
    quantity = json['quantity']??0;
    maxAllowedQuantity = json['max_allowed_quantity']??0;
    shelfZone = json['shelf_zone']??'';
    shelfSection = json['shelf_section']??"";
    storeId = json['store_id']??0;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add( Images.fromJson(v));
      });
    }
    if( id!=0 &&title!=""&&images.isNotEmpty){
isUsable=true;
    }
  }

}

class Categories {
  int id = 0;
  int parentCategoryId = 0;
  String title = "";

  Categories({
    this.id = 0,
    this.parentCategoryId = 0,
    this.title="",
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCategoryId = json['parent_category_id'];
    title = json['title'];
  }
}

class Images {
  int id = 0;
  String className = "";
  String createdAt = "";
  String thumbnail = "";
  String large = "";
  String small = "";
  String extraSmall = "";
  String original = "";


  Images(
      {this.id = 0,
      this.className="",
      this.createdAt="",
      this.thumbnail="",
      this.large="",
      this.small="",
      this.extraSmall="",
      this.original="",


      });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    createdAt = json['created_at'];
    thumbnail = json['thumbnail'];
    large = json['large'];
    small = json['small'];
    extraSmall = json['extra_small'];
    original = json['original'];

  }

}


