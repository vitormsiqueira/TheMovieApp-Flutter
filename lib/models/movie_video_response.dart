import 'dart:convert';

import 'package:the_movie_app/models/movie_video_model.dart';

class MovieVideoResponse {
  MovieVideoResponse({
    this.id,
    this.results,
  });

  final int? id;
  final List<MovieVideoModel>? results;

  factory MovieVideoResponse.fromJson(String str) =>
      MovieVideoResponse.fromMap(json.decode(str));

  factory MovieVideoResponse.fromMap(Map<String, dynamic> json) =>
      MovieVideoResponse(
        id: json["id"],
        results: List<MovieVideoModel>.from(
            json["results"].map((x) => MovieVideoModel.fromMap(x))),
      );
}
