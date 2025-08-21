import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    super.key,
    required this.providerImage,
    required this.providerName,
    required this.cardOrPhoneNumbers,
    required this.onTap,
    required this.isSelected,
  });

  final String providerImage, providerName, cardOrPhoneNumbers;
  final void Function() onTap;
  final bool isSelected;

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      shape: ContinuousRectangleBorder(
        side: BorderSide(width: 1, color: strokeColor),
        borderRadius: BorderRadius.circular(30),
      ),

      /// Provider payment image
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: strokeColor),
          borderRadius: BorderRadius.circular(90),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(widget.providerImage),
        ),
      ),

      /// Provider's name
      title: Text(
        widget.providerName,
        style: GoogleFonts.manrope(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: darkPurple,
        ),
      ),

      /// Phone number or Card numbers
      subtitle: Text(widget.cardOrPhoneNumbers, style: bodyText),

      /// Trailing icon
      trailing: Icon( widget.isSelected ?
      Icons.radio_button_on_rounded : Icons.radio_button_off_rounded,
        color: widget.isSelected ? purple : strokeColor,
        size: 28,
      ),
    );
  }
}
