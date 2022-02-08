// To parse this JSON data, do
//
//     final movieModel = movieModelFromMap(jsonString);

import 'dart:convert';

import 'package:the_movie_app/models/movie_model.dart';

class MovieResponseModel {
  MovieResponseModel(
      {this.page,
      this.results,
      this.totalPages,
      this.totalResults,
      this.movies,
      this.cast});

  int? page;
  final List<dynamic>? results;
  final int? totalPages;
  final int? totalResults;
  final List<MovieModel>? movies;
  final List<dynamic>? cast;

  factory MovieResponseModel.fromJson(String str) =>
      MovieResponseModel.fromMap(json.decode(str));

  factory MovieResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: json["results"] == null
            ? null
            : List<dynamic>.from(json["results"].map((x) => x)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        movies: json["results"] == null
            ? null
            : List<MovieModel>.from(
                json["results"].map((x) => MovieModel.fromMap(x))),
        cast: json["cast"] == null
            ? null
            : List<MovieModel>.from(
                json["cast"].map((x) => MovieModel.fromMap(x))),
      );
}
