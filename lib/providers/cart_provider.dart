import 'package:flutter/cupertino.dart';

class CartModel {
  String id, imageUrl, name, price, category;
  int qty;

  CartModel({
    required this.id,
    required this.qty,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _carItems = {};

  Map<String, CartModel> get cartItems => {..._carItems};

  /// Add product to cart
  void addToCart({
    required String prodId,
    required String name,
    required String prodImage,
    required String category,
    required String price,
  }) {
    if (_carItems.containsKey(prodId)) {
      _carItems.update(
        prodId,
        (val) => CartModel(
          id: val.id,
          qty: val.qty + 1,
          name: val.name.toString(),
          category: val.category.toString(),
          price: val.price.toString(),
          imageUrl: val.imageUrl.toString(),
        ),
      );

      ///
      notifyListeners();

      ///
    } else {
      _carItems.putIfAbsent(
        prodId,
        () => CartModel(
          name: name,
          id: DateTime.now().toString(),
          qty: 1,
          category: category.toString(),
          price: price,
          imageUrl: prodImage,
        ),
      );
      notifyListeners();
    }
  }

  /// Increase item
  void increaseItem(String itemId) {
    if (_carItems.containsKey(itemId)) {
      _carItems[itemId]!.qty += 1;
      notifyListeners();
    }
  }

  /// Decrease item
  void decreaseItem(String itemId) {
    if (_carItems.containsKey(itemId)) {
      if (_carItems[itemId]!.qty > 1) {
        _carItems[itemId]!.qty -= 1;
      } else {
        _carItems.remove(itemId);
      }
      notifyListeners();
    }
  }

  /// Delete item from cart
  void deleteItem(String id) {
    _carItems.remove(id);
    notifyListeners();
  }

  /// Get total cart
  double get totalCart {
    double total = 0.0;
    _carItems.forEach((key, val) {
      total += double.parse(val.price) * val.qty;
    });
    return total;
  }

  /// Clear cart after going to the checkout screen
  void clearCart() {
    _carItems.clear();
    notifyListeners();
  }
}
