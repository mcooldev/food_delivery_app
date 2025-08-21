import 'package:flutter/foundation.dart';

import 'cart_provider.dart';

class Order {
  DateTime orderDate;
  String orderId;
  String orderPaymentMethod;
  double orderPrice;
  String orderDeliveryAddress;
  String orderStatus;
  List<CartModel> cartItems;

  Order({
    required this.orderDate,
    required this.orderId,
    required this.orderPaymentMethod,
    required this.orderPrice,
    required this.orderDeliveryAddress,
    required this.cartItems,
    this.orderStatus = 'received',
  });
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder({
    required DateTime orderDate,
    required String orderId,
    required String orderPaymentMethod,
    required double orderPrice,
    required String orderDeliveryAddress,
    required String orderStatus,
    required List<CartModel> cartItems,
  }) {
    final order = Order(
      orderDate: orderDate,
      orderId: orderId,
      orderPaymentMethod: orderPaymentMethod,
      orderPrice: orderPrice,
      orderDeliveryAddress: orderDeliveryAddress,
      cartItems: cartItems,
      orderStatus: orderStatus,
    );
    _orders.insert(0, order);
    notifyListeners();
  }

  /// Find order by id
  Order findOrderById(String? id) {
    final findById = _orders.firstWhere((order) => order.orderId == id);
    return findById;
  }

  /// Set status of order
  final List<String> _statusMessage = [
    "🎉 Commande confirmée avec succès.\n Nous vous dirons une fois donnée au livreur.",
    "🛵 Commande en cours de livraison.\n Le livreur est en route.",
    "✅ Commande livrée avec succès.\n Merci pour votre achat et bon appétit.",
  ];

  List<String> get statusMessage => [..._statusMessage];

  String getStatusMessage(String? status) {
    switch (status) {
      case 'received':
        return _statusMessage[0];
      case 'delivering':
        return _statusMessage[1];
      case 'delivered':
        return _statusMessage[2];
      default:
        return "Statut de la commande inconnu";
    }
  }

  bool isStepPast(String currentStatus, String targetStatus) {
    final List<String> statusOrder = ['received', 'delivering', 'delivered'];
    final currentStatusIndex = statusOrder.indexOf(currentStatus);
    final targetStatusIndex = statusOrder.indexOf(targetStatus);
    return currentStatusIndex >= targetStatusIndex;
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final orderIndex = _orders.indexWhere((order) => order.orderId == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex].orderStatus = newStatus;
      notifyListeners();
    }
    if (orderIndex == -1) {
      _orders[orderIndex].orderStatus = 'received';
      notifyListeners();
    }
  }
}
