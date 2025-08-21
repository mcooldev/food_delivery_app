import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  /// AuthServices instance
  final auth = AuthServices.instance;

  ///
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,

      /* App bar content here */

      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Mon compte"),
        centerTitle: false,
      ),

      /* Body content here */

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// User info
            ListTile(
              tileColor: lightBg,
              contentPadding: const EdgeInsets.all(12),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              /// user image
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/mc-pic.png'),
                radius: 30,
              ),

              /// Email && todo: Name
              title: Text(auth.getUserEmail().toString(), style: headline),

              /// Edit button
              trailing: IconButton(
                onPressed: () {
                  // todo:
                },
                icon: const Icon(
                  Icons.edit_note_rounded,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Account info
            Text("Informations du compte", style: headlineBold),
            const SizedBox(height: 12),

            /// List tiles
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: lightBg,
              ),
              child: Column(
                children: [
                  /// My orders
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/myOrders');
                    },
                    leading: const Icon(CupertinoIcons.arrow_up_bin),
                    title: Text("Mes commandes", style: headline),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(thickness: 0.7, color: strokeColor),
                  /// My cart
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                    leading: const Icon(CupertinoIcons.cart),
                    title: Text("Mon panier", style: headline),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(thickness: 0.7, color: strokeColor),
                  /// Gmaps
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/mapsScreen');
                    },
                    leading: const Icon(Icons.location_searching_rounded),
                    title: Text("Google maps", style: headline),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            /// Support
            Text("Autres", style: headlineBold),
            const SizedBox(height: 12),
            /// List tiles
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: lightBg,
              ),
              child: Column(
                children: [
                  /// Chat support
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/supportChat");
                    },
                    leading: const Icon(CupertinoIcons.chat_bubble_2),
                    title: Text("Parler à un agent", style: headline),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(thickness: 0.7, color: strokeColor),
                  /// My cart
                  ListTile(
                    onTap: () {
                      // todo
                    },
                    leading: const Icon(CupertinoIcons.settings),
                    title: Text("Paramètres", style: headline),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            /// Log out session button
            ListTile(
              onTap: () {
                auth.signOut(context);
              },
              tileColor: lightBg,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                "Se déconnecter",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
