import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// OnBoarding image
          Container(
            width: 320,
            height: 380,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: [
                BoxShadow(
                  color: lightPurple.withValues(alpha: 0.3),
                  offset: const Offset(0, 10),
                  blurRadius: 20,
                  // blurStyle: BlurStyle.inner,
                )
              ]
            ),
            child: Image(image: AssetImage(image), fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),

          /// OnBoarding title
          Text(title, style: h1, textAlign: TextAlign.center,),
          const SizedBox(height: 12),

          /// OnBoarding description
          Text(description, style: bodyText, textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
