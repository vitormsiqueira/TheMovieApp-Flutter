import 'package:dartz/dartz.dart';
import 'package:the_movie_app/models/person_model.dart';
import 'package:the_movie_app/repositories/movies_repository.dart';

import '../errors/movie_error.dart';

class PersonDetailController {
  final _repository = Repository();

  PersonDetail? personDetail;
  MovieError? movieError;

  bool loading = true;

  Future<Either<MovieError, PersonDetail>> fetchPersonById(int id) async {
    movieError;
    final result = await _repository.fetchPersonById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => personDetail = detail,
    );
    return result;
  }
}
