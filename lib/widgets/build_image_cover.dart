import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildCover(BuildContext context, String posterPath, String basePath,
    {double altura = 420, BoxFit myFit = BoxFit.cover}) {
  return SizedBox(
    height: altura,
    width: MediaQuery.of(context).size.width,
    child: CachedNetworkImage(
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
      fit: myFit,
      imageUrl: '$basePath$posterPath',
    ),
  );
}
