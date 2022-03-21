import 'package:dartz/dartz.dart';
import 'package:the_movie_app/models/person_movie_model.dart';
import 'package:the_movie_app/models/person_movie_response.dart';
import 'package:the_movie_app/models/person_model.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

import '../errors/movie_error.dart';

class PersonMovieController {
  final _repository = Repository();

  PersonMovieResponse? personMovieResponse;
  MovieError? movieError;

  List<PersonMovieModel> get cast =>
      personMovieResponse?.cast ?? <PersonMovieModel>[];
  List<PersonMovieModel> get crew =>
      personMovieResponse?.crew ?? <PersonMovieModel>[];
  int get castCount => cast.length;
  int get crewCount => crew.length;

  bool loading = true;

  Future<Either<MovieError, PersonMovieResponse>> fetchPersonMovieById(
      int id) async {
    movieError;
    final result = await _repository.fetchPersonMovieById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => personMovieResponse = detail,
    );
    return result;
  }
}
