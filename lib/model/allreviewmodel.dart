// To parse this JSON data, do
//
//     final allProductReview = allProductReviewFromJson(jsonString);

import 'dart:convert';

AllProductReviewModel allProductReviewFromJson(String str) =>
    AllProductReviewModel.fromJson(json.decode(str));

String allProductReviewToJson(AllProductReviewModel data) =>
    json.encode(data.toJson());

class AllProductReviewModel {
  AllProductReviewModel({
    required this.rating,
    required this.ratingCount,
    required this.review,
  });

  final double rating;
  final String ratingCount;
  final List<Review> review;

  factory AllProductReviewModel.fromJson(Map<String, dynamic> json) =>
      AllProductReviewModel(
        rating: json["rating"].toDouble(),
        ratingCount: json["rating_count"],
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "rating_count": ratingCount,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
      };
}

class Review {
  Review({
    required this.name,
    required this.rating,
    required this.description,
    required this.createdDate,
  });

  final String? name;
  final String? rating;
  final String? description;
  final DateTime createdDate;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        rating: json["rating"],
        description: json["description"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rating": rating,
        "description": description,
        "created_date": createdDate.toIso8601String(),
      };
}
