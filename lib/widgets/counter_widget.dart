import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/fonts.dart';

import '../constants/colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.increase,
    required this.decrease,
    required this.textCounter,
  });

  final void Function() increase, decrease;
  final String textCounter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: lightBg,
        borderRadius: BorderRadius.circular(90),
      ),
      child: Row(
        children: [
          /// Remove item
          GestureDetector(
            onTap: decrease,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(90.0),
              ),
              child:
                  int.parse(textCounter) > 1
                      ? Icon(Icons.remove, color: purple)
                      : const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ),
          const SizedBox(width: 6),

          /// Item counter
          Text(textCounter, style: headline),
          const SizedBox(width: 6),

          /// Add item
          GestureDetector(
            onTap: increase,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(90.0),
              ),
              child: Icon(Icons.add, color: purple),
            ),
          ),
        ],
      ),
    );
  }
}
