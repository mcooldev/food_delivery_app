import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class ChooseLocationWidget extends StatelessWidget {
  const ChooseLocationWidget({
    super.key,
    required this.userImage,
    required this.address,
    required this.onTap,
    required this.width,
  });

  final String userImage, address;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
          side: BorderSide(width: 1, color: strokeColor),
          borderRadius: BorderRadius.circular(24),
          ),
        ),

        /// Choose location tile
        child: Row(
          children: [
            CircleAvatar(
                backgroundImage: AssetImage(userImage),
              radius: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Adresse de livrason", style: smallText),
                  const SizedBox(height: 2),
                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: darkPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_drop_down_rounded, size: 32, color: darkPurple),
          ],
        ),
      ),
    );
  }
}
