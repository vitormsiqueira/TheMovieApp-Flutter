import 'package:dartz/dartz.dart';
import 'package:the_movie_app/models/movie_video_model.dart';
import 'package:the_movie_app/models/movie_video_response.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

import '../errors/movie_error.dart';

class MovieVideoController {
  final _repository = Repository();

  MovieVideoResponse? movieVideoResponse;
  MovieError? movieError;
  bool loading = true;

  List<MovieVideoModel> get videos =>
      movieVideoResponse?.results ?? <MovieVideoModel>[];
  int get videosCount => videos.length;

  Future<Either<MovieError, MovieVideoResponse>> fetchVideos(
      {required int idMovie}) async {
    movieError;
    final results = await _repository.fetchVideos(idMovie);
    results.fold(
      (error) => movieError = error,
      (videos) {
        movieVideoResponse = videos;
      },
    );

    return results;
  }
}
