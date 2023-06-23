import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:imageapp/util/item_%20model.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _items = [];
  String _bgUrl = '';
  int _countItemFavorite = 0;
  Item? _item;

  List<Item> get items {
    return [..._items];
  }

  String get bgUrl => _bgUrl;
  Item get item => _item!;

  void setBgUrl(String url) {
    _bgUrl = url;
    notifyListeners();
  }

  void setItem(Item item) {
    _item = item;
    notifyListeners();
  }

  int get countItemFavorite {
    return _countItemFavorite;
  }

  List<Item> showItemFavorite() {
    List<Item> data = _items.where((element) => element.isFavorite).toList();
    return data.isEmpty ? [] : data;
  }

  void handleCountItem() {
    _countItemFavorite = _items.where((element) => element.isFavorite).length;
    notifyListeners();
  }

  Future<List<Item>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/category.json');
    final parsedData = await jsonDecode(response);
    List<Item> listData = List<Item>.from(
        parsedData.map((data) => Item.fromJson(jsonEncode(data))));
    _items = listData;
    return listData;
  }
}
