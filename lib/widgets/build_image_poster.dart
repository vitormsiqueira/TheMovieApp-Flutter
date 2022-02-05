import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildImagePoster(String urlImage,
    {double altura = 220, double larg = 140, double margin = 5.0}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      // Permite adicionar um indicador de progresso enquanto a imagem é carregada
      child: CachedNetworkImage(
        height: altura,
        width: larg,
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
