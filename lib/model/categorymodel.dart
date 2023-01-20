// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<CategoryModel?>? productmodelFromJson(String str) =>
    List<CategoryModel?>.from(
        json.decode(str)!.map((x) => CategoryModel.fromJson(x)));

String productmodelToJson(List<CategoryModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.stock,
    required this.categoryName,
    required this.products,
  });

  final int? categoryId;
  final bool? stock;
  final String? categoryName;
  final List<Product?>? products;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"],
        stock: json["stock"],
        categoryName: json["category_name"],
        products: json["products"] == null
            ? []
            : List<Product?>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "stock": stock,
        "category_name": categoryName,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.isOffer,
    required this.offerType,
    required this.offer,
    required this.price,
    required this.img,
    required this.type,
    required this.description,
    required this.tags,
    required this.customizable,
  });

  final int? id;
  final String? name;
  final bool? stock;
  final bool? isOffer;
  final String? offerType;
  final Offer? offer;
  final int? price;
  final String? img;
  final String? type;
  final String? description;
  final List<dynamic>? tags;
  final bool? customizable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        stock: json["stock"],
        isOffer: json["is_offer"],
        offerType: json["offer_type"],
        offer: Offer.fromJson(json["offer"]),
        price: json["price"],
        img: json["img"],
        type: json["type"],
        description: json["description"],
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        customizable: json["customizable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stock": stock,
        "is_offer": isOffer,
        "offer_type": offerType,
        "offer": offer!.toJson(),
        "price": price,
        "img": img,
        "type": type,
        "description": description,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "customizable": customizable,
      };
}

class Offer {
  Offer({
    required this.offerPc,
    required this.description,
    required this.offerUpto,
    required this.offerPrice,
  });

  final String? offerPc;
  final String? description;
  final String? offerUpto;
  final double? offerPrice;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerPc: json["offerPc"],
        description: json["description"],
        offerUpto: json["offerUpto"],
        offerPrice: json["offerPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "offerPc": offerPc,
        "description": description,
        "offerUpto": offerUpto,
        "offerPrice": offerPrice,
      };
}
