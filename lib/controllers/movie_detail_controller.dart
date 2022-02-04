import 'package:dartz/dartz.dart';
import 'package:the_movie_app/models/movie_details_model.dart';
import 'package:the_movie_app/models/movie_response_model.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

import '../errors/movie_error.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieDetail? movieDetail;
  MovieError? movieError;

  bool loading = true;

  Future<Either<MovieError, MovieDetail>> fetchMovieById(int id) async {
    movieError;
    final result = await _repository.fetchMovieById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }
}
