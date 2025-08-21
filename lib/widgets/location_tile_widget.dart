import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class LocationTileWidget extends StatefulWidget {
  const LocationTileWidget({
    super.key,
    required this.onTap,
    required this.subsText,
    required this.title,
    required this.isSelected,
  });

  final void Function() onTap;
  final String subsText, title;
  final bool isSelected;

  @override
  State<LocationTileWidget> createState() => _LocationTileWidgetState();
}

class _LocationTileWidgetState extends State<LocationTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: CircleAvatar(
        backgroundColor: lightBg,
        child: Text(widget.subsText.substring(0, 1)),
      ),
      title: Text(widget.title, style: headline),
      trailing:
          widget.isSelected
              ? Icon(Icons.radio_button_on_rounded, color: purple)
              : Icon(Icons.radio_button_off_rounded, color: strokeColor),
    );
  }
}
