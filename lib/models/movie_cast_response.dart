import 'dart:convert';

import 'package:the_movie_app/models/movie_cast_model.dart';

class MovieCastResponse {
  MovieCastResponse({
    this.id,
    this.cast,
    this.crew,
  });

  final int? id;
  final List<MovieCastModel>? cast;
  final List<MovieCastModel>? crew;

  factory MovieCastResponse.fromJson(String str) =>
      MovieCastResponse.fromMap(json.decode(str));

  factory MovieCastResponse.fromMap(Map<String, dynamic> json) =>
      MovieCastResponse(
        id: json["id"] == null ? null : json["id"],
        cast: json["cast"] == null
            ? null
            : List<MovieCastModel>.from(
                json["cast"].map((x) => MovieCastModel.fromMap(x))),
        crew: json["crew"] == null
            ? null
            : List<MovieCastModel>.from(
                json["crew"].map((x) => MovieCastModel.fromMap(x))),
      );
}
