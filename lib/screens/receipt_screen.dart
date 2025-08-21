import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/providers/checkout_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  ///
  CheckoutModel? checkoutData;
  String? paymentMethod, location;

  ///
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")}";
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      checkoutData = args['checkoutData'];
      paymentMethod = args['paymentMethod'];
      location = args['location'];
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      /*App bar content here*/
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            /// Navigation and clear checkout
            Navigator.of(context).pushReplacementNamed('/home').then((_) {
              if (context.mounted) {
                Provider.of<CheckoutProvider>(context).clearCheckout();
              }
            });
          },
          icon: const Icon(Icons.clear),
        ),
      ),

      /*Body content here*/
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// icon success
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.check_circle_rounded,
                size: 70,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),

            /// headline info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Votre commande est passé avec succès", style: h3),
            ),
            const SizedBox(height: 4),

            /// sub headline info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(formatDate(checkoutData!.dateTime), style: bodyText),
            ),
            const SizedBox(height: 32),

            /// transaction details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Détails de la commande", style: headlineBold),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Id commande", style: bodyText),
                      Text(
                        checkoutData!.id.toString().substring(0, 10),
                        style: bodyText.apply(
                          fontWeightDelta: 600,
                          color: darkPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Moyen de paiement", style: bodyText),
                      Text(
                        paymentMethod.toString(),
                        style: bodyText.apply(
                          fontWeightDelta: 600,
                          color: darkPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Montant réglé", style: bodyText),
                      Text(
                        "${checkoutData!.totalPrice.toStringAsFixed(0)} CFA",
                        style: bodyText.apply(
                          fontWeightDelta: 600,
                          color: darkPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text("Adresse de livraison", style: bodyText)),
                      Flexible(
                        child: Text(
                          location.toString(),
                          style: bodyText.apply(
                            fontWeightDelta: 600,
                            color: darkPurple,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// orders list
                  ExpansionTile(
                    childrenPadding: const EdgeInsets.all(16),
                    shape: ContinuousRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    collapsedBackgroundColor: lightBg,
                    collapsedShape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: lightBg,
                    title: Text(
                      "Commandes (${checkoutData!.cartItems.length} articles)",
                    ),
                    children: [
                      ...checkoutData!.cartItems.map(
                        (item) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name, style: bodyText),
                                Text(
                                  "${item.price.substring(0, item.price.length - 2)} x ${item.qty}",
                                  style: bodyText.apply(
                                    fontWeightDelta: 600,
                                    color: darkPurple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  /// View orders button
                  MaterialButton(
                    onPressed: () {
                      /// On press button
                      Navigator.of(context).pushReplacementNamed("/myOrders");
                    },
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(width: 1, color: strokeColor),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    minWidth: double.infinity,
                    color: white,
                    child: Text(
                      "Voir mes commandes",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: purple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  /// Go to home button
                  MaterialButton(
                    onPressed: () {
                      /// On press button
                      Navigator.of(context).pushReplacementNamed("/home");
                    },
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    minWidth: double.infinity,
                    color: purple,
                    child: Text(
                      "Aller à l'accueil",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: white,
                      ),
                    ),
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
