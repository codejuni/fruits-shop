import 'package:flutter/material.dart';

import '../enum/fruits_enum.dart';
import '../models/cart_model.dart';
import '../models/fruits_model.dart';


class FruitsController with ChangeNotifier {
  BlocState blocState = BlocState.normal;

  bool _loading = false;
  bool get loading => _loading;

  List<FruitsModel> _list = [];
  List<FruitsModel> get fruits => _list;

  final List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  int quantityItems = 0;

  final List<String> _sort = ['Highest to lowest', 'Lowest to highest'];
  List<String> get sort => _sort;

  void getList() {
    Future.delayed(const Duration(seconds: 3));
    _list = FruitsModel.list;
    _loading = true;
    notifyListeners();
  }

  void changeToNormal() {
    blocState = BlocState.normal;
    notifyListeners();
  }

  void changeToCart() {
    blocState = BlocState.cart;
    notifyListeners();
  }

  void addCart(FruitsModel model, int count) {
    for (CartModel item in _cart) {
      if (item.fruit.id == model.id) {
        item.increment(count);
        quantityItems = quantityItems + count;
        notifyListeners();
        return;
      }
    }
    _cart.add(CartModel(fruit: model, count: count));
    quantityItems = quantityItems + count;
    notifyListeners();
  }

  double totalPrice() {
    double total = 0;

    for (CartModel item in _cart) {
      double price = item.count * item.fruit.price;
      total = total + price;
    }

    return total;
  }

  void filterSort(index) {
    switch (index) {
      case 0:
        _list.sort((a, b) => a.price.compareTo(b.price));
        _list = _list.reversed.toList();
        notifyListeners();
        break;
      case 1:
        _list.sort((a, b) => a.price.compareTo(b.price));
        notifyListeners();
        break;
      default:
        getList();
    }
  }
}
