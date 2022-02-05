import 'package:flutter/material.dart';
import 'package:the_movie_app/pages/details_movie_page.dart';

openDetailPage(movieId, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MovieDetailPage(movieId),
    ),
  );
}
