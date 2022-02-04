import 'dart:convert';

import 'package:the_movie_app/models/movie_cast_model.dart';

class MovieCastResponseModel {
  MovieCastResponseModel({
    this.id,
    this.cast,
    this.crew,
  });

  final int? id;
  final List<MovieCastModel>? cast;
  final List<MovieCastModel>? crew;

  factory MovieCastResponseModel.fromJson(String str) =>
      MovieCastResponseModel.fromMap(json.decode(str));

  factory MovieCastResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieCastResponseModel(
        id: json["id"],
        cast: List<MovieCastModel>.from(
            json["cast"].map((x) => MovieCastModel.fromMap(x))),
        crew: List<MovieCastModel>.from(
            json["crew"].map((x) => MovieCastModel.fromMap(x))),
      );
}
