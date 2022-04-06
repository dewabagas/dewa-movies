import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardBackdrop extends StatelessWidget {
  const CardBackdrop({required this.imageUrl, Key? key}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Container(
          alignment: Alignment.center,
          // width: 94,
          // height: 140,
          color: Colors.black12,
          child: const Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),
    );
  }
}
