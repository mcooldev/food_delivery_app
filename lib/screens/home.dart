import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/providers/cart_provider.dart';
import 'package:food_delivery_app/providers/category_provider.dart';
import 'package:food_delivery_app/providers/choose_location_provider.dart';
import 'package:food_delivery_app/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/category_widget.dart';
import '../widgets/choose_location_widget.dart';
import '../widgets/location_tile_widget.dart';
import '../widgets/product_item_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Test
  /*  final PageController _pageController = PageController(initialPage: 0);
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (t) {
      if (_pageController.page ==
          Provider.of<CategoryProvider>(context).categoryList.length - 1) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }*/

  /// End of the Test

  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<ProductProvider>(context, listen: false).resetFilterByCategory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///
    final categories = Provider.of<CategoryProvider>(context);
    final products = Provider.of<ProductProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    ///
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: white,

        /*Floating action button content here*/
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          ),
          extendedPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          backgroundColor: darkPurple,
          label: Text(
            "Mon panier",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: white,
            ),
          ),
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: purple,
            ),
            child: Icon(Icons.shopping_cart_outlined, color: white),
          ),
        ),

        /*Body content here*/
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// containerRow containing Location chooser && More menu button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// choose location here
                      Consumer<ChooseLocationProvider>(
                        builder: (ctx, prov, child) {
                          final String newAddress = prov.getAddress();
                          return ChooseLocationWidget(
                            width: 275,
                            userImage: "assets/mc-pic.png",
                            address: newAddress,
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                                            if (context
                                                                .mounted) {
                                                              Navigator.of(
                                                                context,
                                                              ).pop();
                                                            }
                                                          },
                                                        );
                                                      });
                                                },
                                                elevation: 0,
                                                shape:
                                                    ContinuousRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
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
                                                      style:
                                                          GoogleFonts.manrope(
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
                                                    modalProv
                                                        .locationList
                                                        .length,
                                                itemBuilder: (ctx, i) {
                                                  return LocationTileWidget(
                                                    onTap: () {
                                                      modalProv.selectLocation(
                                                        ctx,
                                                        i,
                                                      );
                                                    },
                                                    subsText:
                                                        modalProv
                                                            .locationList[i],
                                                    title:
                                                        modalProv
                                                            .locationList[i],
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

                      /// More menu button
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/myAccount');
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(width: 1, color: strokeColor),
                          ),
                          child: Icon(
                            Icons.clear_all_rounded,
                            size: 28,
                            color: darkPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                /// Search bar here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SearchBar(
                    controller: products.searchController,
                    onChanged: (val) {
                      products.filterProduct(val);
                    },
                    leading: const Icon(Icons.search_rounded),
                    backgroundColor: WidgetStatePropertyAll(white),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 13),
                    ),
                    hintText: "Que cherchez-vous ?",
                    hintStyle: WidgetStatePropertyAll(bodyText),
                    shape: WidgetStatePropertyAll(
                      ContinuousRectangleBorder(
                        side: BorderSide(width: 1, color: strokeColor),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    elevation: const WidgetStatePropertyAll(0),
                  ),
                ),
                const SizedBox(height: 24),

                /// All products && Product category
                SizedBox(
                  height: 85,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
                      /// All product button
                      GestureDetector(
                        onTap: () {
                          products.filterByCategory(null);
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                color: customGreen,
                              ),
                              child: Icon(
                                Icons.all_inclusive_rounded,
                                color: darkPurple,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Toutes", style: smallTextBold),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// Product categories buttons
                      ...List.generate(categories.categoryList.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CategoryWidget(
                            image: categories.categoryList[i].image,
                            title: categories.categoryList[i].title,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                /// Products list here
                Consumer<ProductProvider>(
                  builder: (ctx, prod, child) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: prod.filters.length,
                      itemBuilder: (ctx, i) {
                        final product = prod.filters[i];
                        return ProductItemWidget(
                          productImage: product.imageUrl,
                          productName: product.name,
                          productPrice: product.price.toString(),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/singleProduct',
                              arguments: product.id,
                            );
                          },
                          onTapCart: () {
                            cart.addToCart(
                              prodId: product.id.toString(),
                              name: product.name,
                              prodImage: product.imageUrl,
                              category: product.category,
                              price: product.price.toString(),
                            );

                            /// Scaffold messenger after adding product
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: customGreen,
                                width: 230,
                                behavior: SnackBarBehavior.floating,
                                padding: const EdgeInsets.fromLTRB(16, 4, 5, 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                content: SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          Navigator.of(
                                            context,
                                          ).pushNamed('/cart');
                                        },
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            90,
                                          ),
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
                        );
                      },
                    );
                  },
                ),

                /// Space for FAB
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
