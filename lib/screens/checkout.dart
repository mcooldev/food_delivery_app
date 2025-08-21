import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/providers/checkout_provider.dart';
import 'package:food_delivery_app/providers/payment_method_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/choose_location_provider.dart';
import '../providers/orders_provider.dart';
import '../widgets/cart_item_checkout_widget.dart';
import '../widgets/choose_location_widget.dart';
import '../widgets/location_tile_widget.dart';
import '../widgets/payment_method_widget.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    ///
    final checkout = Provider.of<CheckoutProvider>(context);
    final payment = Provider.of<PaymentMethodProvider>(context);
    final order = Provider.of<OrderProvider>(context, listen: false);

    ///
    return Scaffold(
      backgroundColor: white,

      /* App bar content here */
      appBar: AppBar(
        leadingWidth: 0.0,
        leading: const Icon(null),
        title: const Text('Vérification'),
        centerTitle: false,
        backgroundColor: white,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
              checkout.clearCheckout();
            },
            elevation: 0,
            shape: ContinuousRectangleBorder(
              side: BorderSide(width: 1, color: strokeColor),
              borderRadius: BorderRadius.circular(22),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text('Annuler • ❌', style: alertLinkText),
          ),
        ],
      ),

      /* Bottom navigation content here */
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: customGreen.withValues(alpha: 0.3),
                offset: const Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
            color: customGreen,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Total price text here
              Text(
                "${checkout.totalCheckout.toStringAsFixed(0)} CFA",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: darkPurple,
                ),
              ),

              /// Pay now button
              SizedBox(
                child: MaterialButton(
                  onPressed: () {
                    /// new checkout with the previous id
                    final checkoutItem = CheckoutModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      dateTime: DateTime.now(),
                      totalPrice: checkout.totalCheckout,
                      cartItems:
                          checkout.checkoutItems
                              .expand((item) => item.cartItems)
                              .toList(),
                    );

                    /// payment methods
                    final List paymentMethods = [
                      "Wave",
                      "Orange Money",
                      "Visa • Carte crédit",
                    ];
                    final selectedPayment =
                        paymentMethods[payment.selectedPayment];

                    /// Location address
                    String? location =
                        Provider.of<ChooseLocationProvider>(
                          context,
                          listen: false,
                        ).getAddress();

                    ///
                    Navigator.of(context).pushReplacementNamed(
                      "/receipt",
                      arguments: {
                        "paymentMethod": selectedPayment,
                        "checkoutData": checkoutItem,
                        "location": location,
                      },
                    );

                    /// Add order to order page
                    order.addOrder(
                      orderDate: DateTime.now(),
                      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                      orderPaymentMethod: selectedPayment,
                      orderPrice: checkout.totalCheckout,
                      orderDeliveryAddress: location,
                      cartItems: checkoutItem.cartItems,
                      orderStatus: 'received'
                    );

                    checkout.clearCheckout();
                  },
                  elevation: 0,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: purple,
                  child: Text(
                    "Payer maintenant 🤑",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /* Body content here */
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Delivery address
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Headline
                    Text("Adresse de livraison", style: headlineBold),
                    const SizedBox(height: 12),

                    /// Element widget
                    Consumer<ChooseLocationProvider>(
                      builder: (_, prov, _) {
                        return ChooseLocationWidget(
                          width: double.infinity,
                          userImage: "assets/mc-pic.png",
                          address: prov.getAddress(),

                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (ctx) {
                                /// Modal provider here
                                return Consumer<ChooseLocationProvider>(
                                  builder: (_, modalProv, _) {
                                    return SafeArea(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          8,
                                          16,
                                          16,
                                        ),
                                        width: double.infinity,
                                        decoration: ShapeDecoration(
                                          shape: ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          color: white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            /// Line drag
                                            Container(
                                              width: 50,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: strokeColor,
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                              ),
                                            ),
                                            const SizedBox(height: 12),

                                            /// Contents
                                            Text(
                                              "Choisissez une adresse",
                                              style: h2,
                                            ),
                                            const SizedBox(height: 16),
                                            MaterialButton(
                                              onPressed: () {
                                                // todo: Get current position
                                                prov
                                                    .fetchCurrentLocation()
                                                    .then((_) {
                                                      Future.delayed(
                                                        const Duration(seconds: 2),
                                                        () {
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                        },
                                                      );
                                                    });
                                              },
                                              elevation: 0,
                                              shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 24,
                                                vertical: 12,
                                              ),
                                              color: purple,
                                              minWidth: double.maxFinite,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .map_pin_ellipse,
                                                    color: white,
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Ma position actuelle",
                                                    style: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  modalProv.locationList.length,
                                              itemBuilder: (ctx, i) {
                                                return LocationTileWidget(
                                                  onTap: () {
                                                    modalProv.selectLocation(
                                                      ctx,
                                                      i,
                                                    );
                                                  },
                                                  subsText:
                                                      modalProv.locationList[i],
                                                  title:
                                                      modalProv.locationList[i],
                                                  isSelected:
                                                      modalProv
                                                          .selectedLocationIndex ==
                                                      i,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              /// Payment method
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Headline
                    Text("Méthode de paiement", style: headlineBold),
                    const SizedBox(height: 12),

                    /// Elements widget
                    /* Wave */
                    PaymentMethodWidget(
                      providerImage:
                          "https://pbs.twimg.com/profile_images/1416037687128113160/O5-WNBK6_400x400.jpg",
                      providerName: "Wave",
                      cardOrPhoneNumbers: "783928432",
                      isSelected: payment.selectedPayment == 0,
                      onTap: () {
                        payment.setIndexPayment(0);
                      },
                    ),
                    const SizedBox(height: 8),
                    /* Orange Money */
                    PaymentMethodWidget(
                      providerImage:
                          "https://play-lh.googleusercontent.com/5bVuQv-mHv8fwgD9xsYklPMVjCWQiKOIZt5GnKIVwwNtHniuZqWnxqJKqpWHlTP7vALZ",
                      providerName: "Orange Money",
                      cardOrPhoneNumbers: "776393847",
                      isSelected: payment.selectedPayment == 1,
                      onTap: () {
                        payment.setIndexPayment(1);
                      },
                    ),
                    const SizedBox(height: 8),

                    /* Credit card */
                    PaymentMethodWidget(
                      providerImage:
                          "https://logowik.com/content/uploads/images/857_visa.jpg",
                      providerName: "Visa • Carte crédit",
                      cardOrPhoneNumbers: "•••• •••• •••• 1234",
                      isSelected: payment.selectedPayment == 2,
                      onTap: () {
                        payment.setIndexPayment(2);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              /// Cart items
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Headline && qty
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// headline
                        Text("Mon panier", style: headlineBold),

                        /// quantity
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: strokeColor,
                          ),
                          child: Text(
                            checkout.totalItems.toString().padLeft(2, "0"),
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: darkPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: Builder(
                      builder: (ctx) {
                        /// Create list for all items
                        List<dynamic> allItems = <dynamic>[];
                        for (var item in checkout.checkoutItems) {
                          allItems.addAll(item.cartItems);
                        }

                        /// Return the ListView builder now
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: allItems.length,
                          itemBuilder: (ctx, i) {
                            final checkoutItem = allItems[i];
                            return CartItemCheckoutWidget(
                              categoryName: checkoutItem.category,
                              prodName: checkoutItem.name,
                              prodPrice: checkoutItem.price,
                              prodImage: checkoutItem.imageUrl,
                              qty: checkoutItem.qty.toString(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
