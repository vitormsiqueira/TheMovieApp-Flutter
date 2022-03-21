import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/controllers/movie_detail_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/widgets/build_image_poster.dart';

class NewMovieDetailPage extends StatefulWidget {
  final int movieId;

  const NewMovieDetailPage(this.movieId, {Key? key}) : super(key: key);

  @override
  State<NewMovieDetailPage> createState() => _NewMovieDetailPageState();
}

class _NewMovieDetailPageState extends State<NewMovieDetailPage> {
  final _controllerDetail = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initializeDetail();
  }

  _initializeDetail() async {
    setState(() {
      _controllerDetail.loading = true;
    });

    await _controllerDetail.fetchMovieById(widget.movieId);

    setState(() {
      _controllerDetail.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyMovieDetail(),
    );
  }

  _buildBodyMovieDetail() {
    String? moviePoster = _controllerDetail.movieDetail?.posterPath;

    if (_controllerDetail.loading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
    // print('new');
    // print('movie-poster-${widget.movieId.toString()}');
    return Center(
      child: Container(
        child: Hero(
          tag: 'movie-poster-476669',
          child: buildImagePoster('$urlPoster400$moviePoster',
              altura: 400, larg: 300, movieId: '476669'),
        ),
      ),
    );
  }
}
