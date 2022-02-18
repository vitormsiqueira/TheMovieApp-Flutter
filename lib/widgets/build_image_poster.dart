import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';

Widget buildImagePoster(String urlImage,
    {double altura = 220,
    double larg = 140,
    double margin = 5.0,
    double border = 14.0}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(border),
      // Permite adicionar um indicador de progresso enquanto a imagem é carregada

      child: CachedNetworkImage(
        height: altura,
        width: larg,
        imageUrl: urlImage,
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    ),
  );
}
