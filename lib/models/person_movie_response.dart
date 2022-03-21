import 'dart:convert';

import 'package:the_movie_app/models/movie_cast_model.dart';
import 'package:the_movie_app/models/movie_model.dart';
import 'package:the_movie_app/models/person_movie_model.dart';

class PersonMovieResponse {
  PersonMovieResponse({
    this.cast,
    this.crew,
    this.id,
  });

  final List<PersonMovieModel>? cast;
  final List<PersonMovieModel>? crew;
  final int? id;

  factory PersonMovieResponse.fromJson(String str) =>
      PersonMovieResponse.fromMap(json.decode(str));

  factory PersonMovieResponse.fromMap(Map<String, dynamic> json) =>
      PersonMovieResponse(
        cast: json["cast"] == null
            ? null
            : List<PersonMovieModel>.from(
                json["cast"].map((x) => PersonMovieModel.fromMap(x))),
        crew: json["crew"] == null
            ? null
            : List<PersonMovieModel>.from(
                json["crew"].map((x) => PersonMovieModel.fromMap(x))),
        id: json["id"],
      );
}
