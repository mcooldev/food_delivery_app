import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../constants/colors.dart';

class OrderTimelineTile extends StatelessWidget {
  final bool isLast;
  final bool isFirst;
  final bool isPast;
  final IconData iconData;

  const OrderTimelineTile({
    super.key,
    required this.isLast,
    required this.isFirst,
    required this.isPast,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: MediaQuery.sizeOf(context).width * 0.28,
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? purple : lightBg,
          thickness: 3,
        ),
        indicatorStyle: IndicatorStyle(
          height: 44,
          color: isPast ? purple : lightBg,
          iconStyle: IconStyle(
            iconData: iconData,
            color: isPast ? white : bodyTextColor,
            fontSize: 28
          ),
        ),
      ),
    );
  }
}
