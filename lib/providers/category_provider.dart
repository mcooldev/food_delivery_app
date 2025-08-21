import 'package:flutter/cupertino.dart';

class Category {
  String image, title;

  Category({required this.image, required this.title});
}

class CategoryProvider with ChangeNotifier {
  final List<Category> _categoryList = [
    Category(image: "🍔", title: "Hamburger"),
    Category(image: "🌯", title: "Sandwich"),
    Category(image: "🥤", title: "Boisson"),
    Category(image: "🍕", title: "Pizza"),
    Category(image: "🍰", title: "Pâtisserie"),
  ];

  List<Category> get categoryList => [..._categoryList];
}
