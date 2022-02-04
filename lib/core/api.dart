import 'package:dio/dio.dart';

const kBaseUrl = 'https://api.themoviedb.org/3';

const kApiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMGZjNzdkZjhmNzM1ZmU0ZWQ5YTIxZGZlZDI0NmIxZCIsInN1YiI6IjVlZWMyNTc2NmRlYTNhMDAzNGJkOTJiOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QjtZuVGQ-eKpxKZ9s30b4yqSgGWf3HkT9xz-xyi0UYM';

const kServerError = 'Failed to connect to the server. Try again later.';
final kDioOptions = BaseOptions(
  baseUrl: kBaseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  contentType: 'application/json;charset=utf-8',
  headers: {"Authorization": 'bearer $kApiKey'},
);
