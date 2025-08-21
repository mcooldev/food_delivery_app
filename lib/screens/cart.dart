import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/cart_provider.dart';
import 'package:food_delivery_app/providers/checkout_provider.dart';
import 'package:food_delivery_app/widgets/cart_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    ///
    final cart = Provider.of<CartProvider>(context);
    final checkout = Provider.of<CheckoutProvider>(context);

    ///
    return Scaffold(
      backgroundColor: white,

      /* App bar here */
      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Mon panier"),
        centerTitle: false,
      ),

      /* Bottom navigation for button here */
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
              /// Total price text here
              Text(
                "${cart.totalCart.toStringAsFixed(0)} CFA",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: customGreen,
                ),
              ),

              /// Checkout button
              SizedBox(
                child: MaterialButton(
                  onPressed:
                      cart.cartItems.isEmpty
                          ? () {}
                          : () {
                            /// On press button
                            checkout.addItems(
                              cartItems: cart.cartItems.values.toList(),
                              totalPrice: cart.totalCart,
                            );
                            Navigator.of(
                              context,
                            ).pushReplacementNamed("/checkout");
                            cart.clearCart();

                            ///
                          },
                  elevation: 0,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color:
                      cart.cartItems.isEmpty
                          ? purple.withValues(alpha: 0.4)
                          : purple,
                  child: Text(
                    "Vérification • 👀",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: cart.cartItems.isEmpty ? white.withValues(alpha: 0.5) : white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /* Body content here */
      body:
          cart.cartItems.isEmpty
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 300,
                        child: Image(
                          image: AssetImage("assets/emptyCartImg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Aucun produit dans le panier !",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: bodyTextColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      MaterialButton(
                        onPressed: () {
                          /// On press button
                          Navigator.of(context).pushReplacementNamed("/home");

                          ///
                        },
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: purple,
                        child: Text(
                          "Voir le menu • 🌮🥤🍰",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (ctx, i) {
                      ///
                      final items = cart.cartItems.values.toList()[i];
                      final itemsId = cart.cartItems.keys.toList()[i];

                      ///
                      return CartTile(
                        prodName: items.name,
                        prodPrice: items.price,
                        prodImage: items.imageUrl,
                        prodCategory: items.category,
                        qty: items.qty.toString(),
                        deleteCall: () {
                          cart.deleteItem(itemsId);
                        },
                        decrease: () {
                          cart.decreaseItem(itemsId);
                        },
                        increase: () {
                          cart.increaseItem(itemsId);
                        },
                      );
                    },
                  ),
                ),
              ),
    );
  }
}
