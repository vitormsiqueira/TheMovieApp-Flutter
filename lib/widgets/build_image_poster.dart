import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildImagePoster(String urlImage, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      // Permite adicionar um indicador de progresso enquanto a imagem é carregada
      child: CachedNetworkImage(
        height: 220,
        width: 140,
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
        imageUrl: urlImage,
        fit: BoxFit.cover,
      ),
    ),
  );
}
