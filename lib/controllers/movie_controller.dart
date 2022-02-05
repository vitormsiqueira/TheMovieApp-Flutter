import 'package:dartz/dartz.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

import '../errors/movie_error.dart';
import '../models/movie_model.dart';
import '../models/movie_response_model.dart';

class MovieController {
  final _repository = MovieRepository();

  MovieResponseModel? movieResponseModel;
  MovieError? movieError;
  bool loading = true;

  List<MovieModel> get movies => movieResponseModel?.movies ?? <MovieModel>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel!.totalPages ?? 1;
  int get currentPage => movieResponseModel!.page ?? 1;

  Future<Either<MovieError, MovieResponseModel>> fetchMovies(
      {int page = 1,
      required int idMovie,
      required String classMovie,
      required bool similar}) async {
    movieError;
    final result =
        await _repository.fetchMovies(page, idMovie, classMovie, similar);
    result.fold(
      (error) => movieError = error,
      (movie) {
        if (movieResponseModel == null) {
          movieResponseModel = movie;
        } else {
          movieResponseModel!.page = movie.page;
        }
      },
    );

    return result;
  }
}
