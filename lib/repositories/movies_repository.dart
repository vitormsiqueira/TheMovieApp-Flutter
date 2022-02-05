import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:the_movie_app/core/api.dart';
import 'package:the_movie_app/errors/movie_error.dart';
import 'package:the_movie_app/models/movie_cast_response_model.dart';
import 'package:the_movie_app/models/movie_details_model.dart';
import 'package:the_movie_app/models/movie_response_model.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOptions);

  Future<Either<MovieError, MovieResponseModel>> fetchMovies(
      int page, int idMovie, String classMovie, bool similar) async {
    String path = similar == false
        ? '/movie/$classMovie?&language=pt-BR&page=$page'
        : '/movie/$idMovie/similar?&language=pt-BR&page=1';
    try {
      final response = await _dio.get(path);
      final model = MovieResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  // Future<Either<MovieError, MovieSimilarResponseModel>> fetchSimilarMovies(
  //     int page, int id) async {
  //   try {
  //     final response = await _dio.get();
  //     final model = MovieSimilarResponseModel.fromMap(response.data);
  //     return Right(model);
  //   } on DioError catch (error) {
  //     if (error.response != null) {
  //       return Left(
  //           MovieRepositoryError(error.response!.data['status_message']));
  //     } else {
  //       return Left(MovieRepositoryError(kServerError));
  //     }
  //   } on Exception catch (error) {
  //     return Left(MovieRepositoryError(error.toString()));
  //   }
  // }

  Future<Either<MovieError, MovieCastResponseModel>> fetchCastMovieById(
      int id) async {
    try {
      final response = await _dio.get('/movie/$id/credits?&language=pt-BR');
      final model = MovieCastResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetail>> fetchMovieById(int id) async {
    try {
      final response = await _dio.get('/movie/$id?&language=pt-BR');
      final model = MovieDetail.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}
