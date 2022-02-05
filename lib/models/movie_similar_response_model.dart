import 'dart:convert';

import 'package:the_movie_app/models/movie_similar_model.dart';

class MovieSimilarResponseModel {
  MovieSimilarResponseModel({
    this.page,
    this.movies,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  final List<MovieSimilarModel>? movies;
  final int? totalPages;
  final int? totalResults;

  factory MovieSimilarResponseModel.fromJson(String str) =>
      MovieSimilarResponseModel.fromMap(json.decode(str));

  factory MovieSimilarResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieSimilarResponseModel(
        page: json["page"],
        movies: List<MovieSimilarModel>.from(
            json["results"].map((x) => MovieSimilarModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
