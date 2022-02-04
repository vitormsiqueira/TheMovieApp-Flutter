import 'package:dartz/dartz.dart';
import 'package:the_movie_app/errors/movie_error.dart';
import 'package:the_movie_app/models/movie_cast_model.dart';
import 'package:the_movie_app/models/movie_cast_response_model.dart';
import 'package:the_movie_app/models/movie_model.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

class MovieCastController {
  final _repository = MovieRepository();

  MovieCastResponseModel? movieCastResponseModel;
  MovieError? movieError;
  bool loading = true;

  List<MovieCastModel> get cast =>
      movieCastResponseModel?.cast ?? <MovieCastModel>[];
  int get castCount => cast.length;

  Future<Either<MovieError, MovieCastResponseModel>> fetchCastMovieById(
      {required int movieId}) async {
    movieError;
    final result = await _repository.fetchCastMovieById(movieId);
    result.fold(
      (error) => movieError = error,
      (casts) {
        movieCastResponseModel = casts;
      },
    );

    return result;
  }
}
