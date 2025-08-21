import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.image, required this.title});

  final String image, title;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    bool isSelected = product.selectedCategory == widget.title;
    return GestureDetector(
      onTap: () {
        product.filterByCategory(isSelected ? null : widget.title);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: isSelected ? purple : lightBg,
            ),
            child: Text(widget.image, style: h2),
          ),
          const SizedBox(height: 4),
          Text(widget.title, style: isSelected ? smallTextBold : smallText),
        ],
      ),
    );
  }
}
