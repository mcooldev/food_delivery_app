import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/widgets/counter_widget.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    required this.prodName,
    required this.prodPrice,
    required this.prodImage,
    required this.prodCategory,
    required this.qty,
    required this.deleteCall,
    required this.decrease,
    required this.increase,
    super.key,
  });

  final String prodName, prodPrice, prodImage, prodCategory, qty;
  final VoidCallback deleteCall, decrease, increase;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: white,
        shape: ContinuousRectangleBorder(
          side: BorderSide(width: 1, color: strokeColor),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Container(
            height: 100,
            width: 100,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
              ),
            child: Image(image: NetworkImage(prodImage), fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),

          /// Category, name and Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Category
                Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: ShapeDecoration(
                    color: customGreen,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(prodCategory, style: smallTextBold),
                ),
                const SizedBox(height: 4),
                /// Product name
                Text(
                  prodName,
                  style: headline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                /// Product price
                Text(
                  "$prodPrice CFA",
                  style: headlineBold,
                ),
              ],
            ),
          ),

          /// Delete button and Counter
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: deleteCall,
                icon: const Icon(Icons.highlight_remove_rounded, color: Colors.red),
              ),
              const SizedBox(height: 4),
              CounterWidget(
                increase: increase,
                textCounter: qty,
                decrease: decrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
