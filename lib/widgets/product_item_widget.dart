import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.onTap,
    required this.onTapCart,
  });

  final String productImage, productName, productPrice;
  final void Function()? onTap, onTapCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product image
                  Container(
                    height: 170,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4),

                  /// Product name
                  Text(
                    productName,
                    style: headline,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),

                  /// Product price and Add to cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$productPrice CFA", style: headlineBold),
                      InkWell(
                        onTap: onTapCart,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: purple,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
