import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/orders_provider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/cart_item_checkout_widget.dart';
import '../widgets/order_timeline_tile.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  ///
  String? orderId;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;
    if (args != null) {
      orderId = args;
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    ///
    final orderProv = Provider.of<OrderProvider>(
      context,
      listen: false,
    ).findOrderById(orderId);

    ///
    return Scaffold(
      backgroundColor: white,

      /*App bar content*/
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Commande"),
            const SizedBox(height: 4),
            Text(
              "N˚${orderProv.orderId.substring(0, 10)}",
              style: bodyText.apply(fontWeightDelta: 700, color: purple),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: strokeColor, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🤑", style: h3),
                const SizedBox(width: 4),
                Text(
                  "${orderProv.orderPrice.toStringAsFixed(0)} CFA",
                  style: bodyText.apply(
                    fontSizeDelta: 1,
                    color: darkPurple,
                    fontWeightDelta: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /*Body content*/
      body: Consumer<OrderProvider>(
        builder: (_, orderProvider, _) {
          final order = orderProvider.findOrderById(orderId);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Détails de la commande", style: h3),
                const SizedBox(height: 12),

                /// Detail content
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(width: 1, color: strokeColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Order id
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.number, color: darkPurple),
                              const SizedBox(width: 8),
                              Text("Id commande", style: bodyText),
                            ],
                          ),
                          Text(
                            order.orderId.toString().substring(0, 10),
                            style: bodyText.apply(
                              fontWeightDelta: 600,
                              color: darkPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Order payment method
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.creditcard,
                                color: darkPurple,
                              ),
                              const SizedBox(width: 8),
                              Text("Moyen de paiement", style: bodyText),
                            ],
                          ),
                          Text(
                            order.orderPaymentMethod.toString(),
                            style: bodyText.apply(
                              fontWeightDelta: 600,
                              color: darkPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Order amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.money_dollar,
                                color: darkPurple,
                              ),
                              const SizedBox(width: 8),
                              Text("Montant réglé", style: bodyText),
                            ],
                          ),
                          Text(
                            "${order.orderPrice.toStringAsFixed(0)} CFA",
                            style: bodyText.apply(
                              fontWeightDelta: 600,
                              color: darkPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Delivery address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.location, color: darkPurple),
                                const SizedBox(width: 8),
                                Text("Adresse de livraison", style: bodyText),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(
                              order.orderDeliveryAddress.toString(),
                              style: bodyText.apply(
                                fontWeightDelta: 600,
                                color: darkPurple,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                /// orders list
                Text("Produits", style: h3),
                const SizedBox(height: 12),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: order.cartItems.length,
                    itemBuilder: (ctx, i) {
                      final orderItem = order.cartItems[i];
                      return CartItemCheckoutWidget(
                        categoryName: orderItem.category,
                        prodName: orderItem.name,
                        prodPrice: orderItem.price,
                        prodImage: orderItem.imageUrl,
                        qty: orderItem.qty.toString(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                /// Order tracking
                Text("Suivi de la commande", style: h3),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(width: 1, color: strokeColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Date and time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(Date • Heure) de commande",
                                style: bodyText,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${order.orderDate.toString().split(' ')[0]} • ${order.orderDate.toString().split(' ')[1].substring(0, 8)}",
                                style: headlineBold,
                              ),
                            ],
                          ),

                          /// Icon check
                          IconButton(
                            onPressed: () {
                              orderProvider.updateOrderStatus(
                                order.orderId,
                                "delivering",
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.checkmark_seal_fill,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Order timeline tile
                      Row(
                        children: [
                          OrderTimelineTile(
                            isFirst: true,
                            isLast: false,
                            isPast: orderProvider.isStepPast(
                              order.orderStatus,
                              'received',
                            ),
                            iconData: Icons.file_download_done_rounded,
                          ),
                          OrderTimelineTile(
                            isFirst: false,
                            isLast: false,
                            isPast: orderProvider.isStepPast(
                              order.orderStatus,
                              'delivering',
                            ),
                            iconData: Icons.linear_scale_rounded,
                          ),
                          OrderTimelineTile(
                            isFirst: false,
                            isLast: true,
                            isPast: orderProvider.isStepPast(
                              order.orderStatus,
                              'delivered',
                            ),
                            iconData: Icons.done_all_rounded,
                          ),
                        ],
                      ),

                      /// Order status text
                      const SizedBox(height: 24),
                      Text(
                        orderProvider.getStatusMessage(order.orderStatus),
                        style: bodyText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
