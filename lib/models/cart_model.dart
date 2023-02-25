import 'fruits_model.dart';

class CartModel {
  FruitsModel fruit;
  int count;
  CartModel({required this.fruit, this.count = 1});

  void increment(int quantity) {
    count = count + quantity;
  }

  void decrement() {
    count--;
  }
}
