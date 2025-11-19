// To parse this JSON data, do
//
//     final shopItem = shopItemFromJson(jsonString);

import 'dart:convert';

List<ShopItem> shopItemFromJson(String str) => List<ShopItem>.from(json.decode(str).map((x) => ShopItem.fromJson(x)));

String shopItemToJson(List<ShopItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopItem {
    String model;
    int pk;
    Fields fields;

    ShopItem({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ShopItem.fromJson(Map<String, dynamic> json) => ShopItem(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int? user;
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
    };
}
