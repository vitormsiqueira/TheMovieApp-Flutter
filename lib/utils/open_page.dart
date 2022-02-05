import 'package:flutter/material.dart';
import 'package:the_movie_app/pages/detail_person_page.dart';
import 'package:the_movie_app/pages/details_movie_page.dart';

openDetailPage(movieId, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MovieDetailPage(movieId),
    ),
  );
}

openPersonPage(personId, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailPersonPage(personId),
    ),
  );
}
