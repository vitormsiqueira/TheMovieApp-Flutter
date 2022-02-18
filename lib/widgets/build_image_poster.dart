import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';

Widget buildImagePoster(String urlImage,
    {double altura = 230,
    double larg = 150,
    double margin = 5.0,
    double border = 14.0}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        border: Border.all(
          width: 1,
          color: Colors.blueGrey.withOpacity(0.6),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            color: Colors.blueGrey.withOpacity(0.2),
          ),
        ],
      ),
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
    ),
  );
}
