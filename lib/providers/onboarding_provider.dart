import 'package:flutter/cupertino.dart';

class OnBoardingProvider with ChangeNotifier {
  int index = 0;
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  void onPageChange(int i) {
    index = i;
    notifyListeners();
  }

  void onTapButton(BuildContext ctx) {
    if (index < 2) {
      _pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      index++;
    } else {
      Navigator.of(ctx).pushNamed("/signUp");
    }
    notifyListeners();
  }
}
