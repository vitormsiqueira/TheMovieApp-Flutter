import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/controllers/movie_cast_controller.dart';
import 'package:the_movie_app/controllers/movie_detail_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/models/movie_genre_model.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage(this.movieId, {Key? key}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controllerDetail = MovieDetailController();
  final _controllerCast = MovieCastController();

  @override
  void initState() {
    super.initState();
    _initializeDetail();
    _initializeCast();
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

  _initializeCast() async {
    setState(() {
      _controllerCast.loading = true;
    });

    await _controllerCast.fetchCastMovieById(movieId: widget.movieId);

    setState(() {
      _controllerCast.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMovieDetail(),
    );
  }

  _buildMovieDetail() {
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

    // if (_controllerDetail.movieError != null) {
    //   return CenteredMessage(message: _controllerDetail.movieError.message);
    // }

    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          _buildCover(),
          Center(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _transitionShadow(),
                    _movieTitle(),
                  ],
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      _buildOverview(),
                      _buildCast(),
                      _buildRelated(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionTitle(String txt) {
    return Text(
      txt,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _buildOverview() {
    String? movieOverview = _controllerDetail.movieDetail?.overview;
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [_buildSectionTitle("Sinopse")],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            movieOverview ?? 'Sinopse não fornecida.',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13.0,
              letterSpacing: 0.2,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  _buildRelated() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [_buildSectionTitle("Recomendados")],
      ),
    );
  }

  _buildCast() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
          child: Row(
            children: [_buildSectionTitle("Elenco")],
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: _controllerCast.castCount,
              itemBuilder: _buildCastMovie,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCastMovie(_, index) {
    final cast = _controllerCast.cast[index];
    final castPath = cast.profilePath;
    final castName = cast.name;
    final castCharacter = cast.character;
    final urlPoster = '$urlPoster400$castPath';
    final pathImage = castPath == null ? urlAlternative : urlPoster;
    return GestureDetector(
        child: buildImage(pathImage, index, '$castName', '$castCharacter'),
        onTap: () {} //() => _openDetailPage(movie.id),
        );
  }

  Widget buildImage(
      String urlImage, int index, String castName, String character) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 80,
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => const SizedBox(
                width: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              imageUrl: urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 80,
          child: Text(
            castName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: 80,
          child: Text(
            character,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )
      ],
    );
  }

  _buildCover() {
    return SizedBox(
      height: 420,
      child: CachedNetworkImage(
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        fit: BoxFit.cover,
        imageUrl:
            'https://image.tmdb.org/t/p/original${_controllerDetail.movieDetail?.backdropPath}',
      ),
    );
  }

  _movieTitle() {
    String? movieTitle = _controllerDetail.movieDetail?.title;
    int? movieYear = _controllerDetail.movieDetail?.releaseDate?.year;
    List<Genre>? movieGenre = _controllerDetail.movieDetail?.genres;
    int? movieRuntime = _controllerDetail.movieDetail?.runtime;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: [
          Text(
            movieTitle ?? 'Sem Título',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$movieYear',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12.0,
                ),
              ),
              const Text(
                ' • ',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$movieRuntime min',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                  size: 18.0,
                ),
            ],
          )
        ],
      ),
    );
  }

  _transitionShadow() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.transparent,
            Colors.black
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.1, 2, 0, 0],
        ),
      ),
    );
  }
}
