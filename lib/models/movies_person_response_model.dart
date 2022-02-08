import 'dart:convert';

import 'package:the_movie_app/models/movie_model.dart';

class MoviesPersonResponse {
  MoviesPersonResponse({
    this.cast,
    this.id,
  });

  final List<MovieModel>? cast;
  final int? id;

  factory MoviesPersonResponse.fromJson(String str) =>
      MoviesPersonResponse.fromMap(json.decode(str));

  factory MoviesPersonResponse.fromMap(Map<String, dynamic> json) =>
      MoviesPersonResponse(
        cast: json["cast"] == null
            ? null
            : List<MovieModel>.from(
                json["cast"].map((x) => MovieModel.fromMap(x))),
        id: json["id"],
      );
}
