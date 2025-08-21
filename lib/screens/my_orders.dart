import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      /*App bar content*/
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        title: const Text('Mes commandes'),
      ),

      /*Body content*/
      body: Consumer<OrderProvider>(
        builder: (_, prov, _) {
          return prov.orders.isEmpty
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
                        "Vous n'avez aucune commande",
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
                          "Passer une commande • 🌮🥤🍰",
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
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: prov.orders.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      onTap: () {
                        // todo
                        Navigator.of(context).pushNamed(
                          "/orderDetails",
                          arguments: prov.orders[i].orderId,
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      titleAlignment: ListTileTitleAlignment.top,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color(0xffdcdfe3),
                          width: 1,
                        ),
                      ),
                      leading: const Icon(
                        CupertinoIcons.checkmark_circle_fill,
                        color: Colors.green,
                      ),

                      ///
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Commande N˚${prov.orders[i].orderId.toString().substring(0, 10)}",
                            style: bodyText.apply(fontWeightDelta: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "${prov.orders[i].orderDate.toString().split(' ')[0]} •",
                                style: bodyText.apply(fontWeightDelta: 20),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${prov.orders[i].cartItems.length} article(s)",
                                style: bodyText.apply(fontWeightDelta: 20),
                              ),
                            ],
                          ),
                        ],
                      ),

                      ///
                      trailing: Text(
                        "${prov.orders[i].orderPrice.toStringAsFixed(0)} CFA",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
