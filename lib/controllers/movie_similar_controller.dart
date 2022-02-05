import 'package:dartz/dartz.dart';
import 'package:the_movie_app/errors/movie_error.dart';
import 'package:the_movie_app/models/movie_similar_model.dart';
import 'package:the_movie_app/models/movie_similar_response_model.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

class MovieSimilarController {
  final _repository = MovieRepository();

  MovieSimilarResponseModel? movieSimilarResponseModel;
  MovieError? movieError;
  bool loading = true;

  List<MovieSimilarModel> get movies =>
      movieSimilarResponseModel?.movies ?? <MovieSimilarModel>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieSimilarResponseModel!.totalPages ?? 1;
  int get currentPage => movieSimilarResponseModel!.page ?? 1;

  Future<Either<MovieError, MovieSimilarResponseModel>> fetchSimilarMovies(
      {int page = 1, required int idMovie}) async {
    movieError;
    final result = await _repository.fetchSimilarMovies(page, idMovie);
    result.fold(
      (error) => movieError = error,
      (movie) {
        if (movieSimilarResponseModel == null) {
          movieSimilarResponseModel = movie;
        } else {
          movieSimilarResponseModel!.page = movie.page;
        }
      },
    );

    return result;
  }
}
