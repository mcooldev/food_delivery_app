import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/providers/cart_provider.dart';

class CheckoutModel {
  String? id;
  DateTime dateTime;
  double totalPrice;
  List<CartModel> cartItems;

  CheckoutModel({
    this.id,
    required this.dateTime,
    required this.totalPrice,
    required this.cartItems,
  });
}

class CheckoutProvider with ChangeNotifier {
  final List<CheckoutModel> _checkoutItems = [];

  List<CheckoutModel> get checkoutItems => [..._checkoutItems];

  /// Add cart items to the checkout screen
  void addItems({
    required List<CartModel> cartItems,
    required double totalPrice,
  }) {
    final items = CheckoutModel(
      id: DateTime.now().toString(),
      dateTime: DateTime.now(),
      totalPrice: totalPrice,
      cartItems: cartItems,
    );
    _checkoutItems.add(items);
    notifyListeners();
  }

  /// Get the total price
  double get totalCheckout {
    double totalCheckout = 0.0;
    for (var item in _checkoutItems) {
      totalCheckout += item.totalPrice;
    }
    return totalCheckout;
  }

  ///
  int get totalItems {
    int allItems = 0;
    for(var item in _checkoutItems){
      allItems += item.cartItems.length;
    }
    return allItems;
  }


  /// Clear checkout
  void clearCheckout () {
    for (var item in _checkoutItems) {
      item.cartItems.clear();
    }
    _checkoutItems.clear();
    notifyListeners();
  }

}
