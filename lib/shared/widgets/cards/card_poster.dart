import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardPoster({required String? imageUrl}) {
  final _configurationController = Get.find<ControllerConfiguration>();

  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: imageUrl == null
            ? Container(
                alignment: Alignment.center,
                width: 94,
                height: 140,
                color: Colors.black12,
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 34,
                ),
              )
            : CachedNetworkImage(
                width: 94,
                height: 140,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ),
                imageUrl: '${_configurationController.posterUrl}$imageUrl',
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
              ),
      ),
    ),
  );
}
