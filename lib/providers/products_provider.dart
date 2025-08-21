import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  /// Products List
  final List<Product> _productList = [
    Product(
      id: "1",
      name: "Classic Burger",
      description:
          "Pain brioché, steak haché, salade, tomate, cheddar, sauce maison.",
      category: "Hamburger",
      price: 1500.0,
      imageUrl:
          "https://thespiceway.com/cdn/shop/files/Signature_Savory_Classic_Burger.jpg?v=1712161801",
    ),
    Product(
      id: "2",
      name: "Bacon Deluxe",
      description:
          "Double steak, bacon croustillant, oignons frits, sauce BBQ.",
      category: "Hamburger",
      price: 2000.0,
      imageUrl:
          "https://res.cloudinary.com/perkchops/image/upload/v1600270811/product/20208161840/db8k4blf2iymfmt7sejl.jpg",
    ),
    Product(
      id: "3",
      name: "Club Sandwich",
      description: "Pain grillé, poulet, bacon, œuf, laitue, mayonnaise.",
      category: "Sandwich",
      price: 1200.0,
      imageUrl:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/6BFF3E98-D385-4D91-B68C-99558E1AFB44/Derivates/cf2dd960-e76c-4584-a5f3-1b68b547d79e.jpg",
    ),
    Product(
      id: "4",
      name: "Veggie Wrap",
      description: "Tortilla, légumes grillés, houmous, feta, roquette.",
      category: "Sandwich",
      price: 1000.0,
      imageUrl:
          "https://www.eatingwell.com/thmb/_KRmqSHZzUEWKQVE0uP3QLB98d4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/4526733-45129f82ed554ea1be3ac980d096a6f1.jpg",
    ),
    Product(
      id: "5",
      name: "Cola Frais",
      description: "Boisson gazeuse pétillante, servie avec glaçons.",
      category: "Boisson",
      price: 350.0,
      imageUrl: "https://streetbar.fr/cdn/shop/products/COCA.jpg?v=1620690018",
    ),
    Product(
      id: "6",
      name: "Jus d'Orange Pressé",
      description: "Jus frais d'oranges pressées, sans sucre ajouté",
      category: "Boisson",
      price: 500.0,
      imageUrl:
          "https://i-mom.unimedias.fr/2020/09/16/comment-preparer-un-succulent-jus-d-orange-a-la-maison.jpg?auto=format,compress&cs=tinysrgb",
    ),
    Product(
      id: "7",
      name: "Pizza Margherita",
      description: "Sauce tomate, mozzarella, basilic frais, huile d'olive.",
      category: "Pizza",
      price: 3000.0,
      imageUrl:
          "https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067",
    ),
    Product(
      id: "8",
      name: "Pizza Quattro Formaggi",
      description: "Mozzarella, gorgonzola, parmesan, chèvre, crème fraîche.",
      category: "Pizza",
      price: 3500.0,
      imageUrl:
          "https://az.przepisy.pl/www-przepisy-pl/www.przepisy.pl/przepisy3ii/img/variants/800x0/pizza-quattro-formaggi.jpg",
    ),
    Product(
      id: "9",
      name: "Éclair au Chocolat",
      description: "Pâte à choux, crème pâtissière chocolat, glaçage fondant.",
      category: "Pâtisserie",
      price: 750.0,
      imageUrl:
          "https://www.cookomix.com/wp-content/uploads/2021/03/eclairs-au-chocolat-thermomix.jpg",
    ),
    Product(
      id: "10",
      name: "Tarte aux Pommes",
      description: "Pâte sablée, compote de pommes, tranches de pommes dorées.",
      category: "Pâtisserie",
      price: 4000.0,
      imageUrl:
          "https://assets.afcdn.com/recipe/20230127/139908_w1024h1024c1cx1059cy707cxt0cyt0cxb2119cyb1414.webp",
    ),
  ];

  List<Product> get productList => [..._productList];

  /// Filter by name
  List<Product> _filters = [];

  List<Product> get filters => _filters.isEmpty ? _productList : _filters;

  final SearchController searchController = SearchController();

  Timer? _debounce;

  void filterProduct(String val) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    final allProduct = productList.toList();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isEmpty && _selectedCategory == null) {
        _filters = [];
      } else {
        _filters =
            allProduct.where((p) {
              final matchesName = p.name.toLowerCase().contains(
                searchController.text.toLowerCase(),
              );
              final matchesCategory =
                  _selectedCategory == null || p.category == _selectedCategory;
              return matchesName && matchesCategory;
            }).toList();
      }
      notifyListeners();
    });
  }

  /// Filter by category
  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  void filterByCategory(String? category) {
    _selectedCategory = category;
    if (category == null) {
      _filters = [];
    } else {
      _filters = _productList.where((p) => p.category == category).toList();
    }

    ///
    if (searchController.text.isNotEmpty) {
      filterProduct(searchController.text);
    } else {
      notifyListeners();
    }
  }

  void resetFilterByCategory()  {
    _selectedCategory = null;
    _filters = [];
    notifyListeners();
  }

  /// Find product by Id
  Product findById(String id) {
    return productList.firstWhere((p) => p.id == id);
  }

  /// Dispose
  @override
  void dispose() {
    _debounce?.cancel();
    resetFilterByCategory();
    super.dispose();
  }
}
