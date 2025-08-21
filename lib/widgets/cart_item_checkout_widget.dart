import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class CartItemCheckoutWidget extends StatelessWidget {
  const CartItemCheckoutWidget({
    super.key,
    required this.categoryName,
    required this.prodName,
    required this.prodPrice,
    required this.prodImage,
    required this.qty,
  });

  final String prodImage, categoryName, prodName, qty, prodPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(right: 12),
      width: 300,
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
                borderRadius: BorderRadius.circular(16),
              ),
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
                /// Category && Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// category
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
                      child: Text(categoryName, style: smallTextBold),
                    ),

                    /// quantity
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: darkPurple,
                      ),
                      child: Text(
                        qty,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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
                Text("$prodPrice CFA", style: headlineBold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
