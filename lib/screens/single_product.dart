import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/cart_provider.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({super.key});

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    ///
    final product = Provider.of<ProductProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    final prodId = ModalRoute.of(context)!.settings.arguments as String;

    ///
    return Scaffold(
      backgroundColor: white,

      /* App bar here */

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 74,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Icon(Icons.arrow_back, color: darkPurple),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,

      /* Bottom Navigation bar here */

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: darkPurple.withValues(alpha: 0.3),
                offset: const Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
            color: darkPurple,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// price text here
              Text(
                "${product.findById(prodId).price.toString()} CFA",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: customGreen,
                ),
              ),

              /// add to cart button
              SizedBox(
                child: MaterialButton(
                  onPressed: () {
                    final prod =
                        product.findById(prodId);
                    cart.addToCart(
                      prodId: prod.id!,
                      name: prod.name,
                      prodImage: prod.imageUrl,
                      price: prod.price.toString(),
                      category: prod.category,
                    );

                    /// Scaffold messenger after adding product
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: customGreen,
                        width: 230,
                        behavior: SnackBarBehavior.floating,
                        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        content: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '🥳Ajouté',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: darkPurple,
                                ),
                              ),

                              /// button
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/cart');
                                },
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                color: purple,
                                child: Text(
                                  "Voir panier",
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                    );
                  },
                  elevation: 0,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: purple,
                  child: Row(
                    children: [
                      Icon(Icons.add_shopping_cart_rounded, color: white),
                      const SizedBox(width: 8),
                      Text(
                        "Ajouter",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /* Body content here */

      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (ctx, prod, child) {
            final prod = product.findById(prodId);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Image
                SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(prod.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                /// Product(category && name)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// category
                      Container(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: ShapeDecoration(
                          color: customGreen,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(prod.category, style: headline),
                      ),
                      const SizedBox(height: 8),

                      /// Name
                      Text(prod.name, style: h2),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                /// Product description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(prod.description, style: bodyText),
                ),
                const SizedBox(height: 12),

                /// Product price and Add to cart button
                Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
