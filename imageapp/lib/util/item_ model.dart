import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Item extends ChangeNotifier {
  int id;
  String name;
  String image;
  String description;
  bool isFavorite = false;

  Item(
      {required this.id,
      required this.name,
      required this.image,
      required this.description});

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "description": description,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
