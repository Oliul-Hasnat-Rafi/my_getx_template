import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final bool isOnline;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CustomImage({super.key, this.isOnline = false, required this.image, this.height, this.width, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return isOnline
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              height: height,
              width: width,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: height,
              width: width,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
          );
  }
}
