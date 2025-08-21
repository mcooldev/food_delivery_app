import 'package:flutter/cupertino.dart';

class PaymentMethodProvider with ChangeNotifier {
  int _selectedPaymentIndex = -1;
  int get selectedPayment => _selectedPaymentIndex;

  void setIndexPayment(int index) {
    _selectedPaymentIndex = index;
    notifyListeners();
  }
}