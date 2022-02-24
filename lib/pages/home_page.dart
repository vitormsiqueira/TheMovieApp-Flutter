import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_movie_app/controllers/movie_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/utils/open_page.dart';
import 'package:the_movie_app/widgets/build_image_poster.dart';
import 'package:the_movie_app/widgets/movie_card_now_playing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  final _controllerNowPlaying = MovieController();
  final _controllerPopular = MovieController();
  final _controllerTopRated = MovieController();
  final _controllerUpcoming = MovieController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _initializeNowPlaying();
    _initializePopular();
    _initializeTopRated();
    _initializeUpcoming();
  }

  _initializeNowPlaying() async {
    setState(() {
      _controllerNowPlaying.loading = true;
    });

    await _controllerNowPlaying.fetchMovies(
        page: page, classMovie: 'now_playing', responseType: 0);

    setState(() {
      _controllerNowPlaying.loading = false;
    });
  }

  _initializePopular() async {
    setState(() {
      _controllerPopular.loading = true;
    });

    await _controllerPopular.fetchMovies(
        page: page, classMovie: 'popular', idMovie: 0, responseType: 0);

    setState(() {
      _controllerPopular.loading = false;
    });
  }

  _initializeTopRated() async {
    setState(() {
      _controllerTopRated.loading = true;
    });

    await _controllerTopRated.fetchMovies(
        page: page, classMovie: 'top_rated', responseType: 0);

    setState(() {
      _controllerTopRated.loading = false;
    });
  }

  _initializeUpcoming() async {
    setState(() {
      _controllerUpcoming.loading = true;
    });

    await _controllerUpcoming.fetchMovies(
        page: page, classMovie: 'upcoming', idMovie: 0, responseType: 0);

    setState(() {
      _controllerUpcoming.loading = false;
    });
  }

  //
  double sigmaX = 10.0; // from 0-10
  double sigmaY = 10.0; // from 0-10
  double opacity = 0.5; // from 0-1.0
  int currentTab = 0;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: _homeAppBar(),
      // Possibilita criar uma AppBar que esconde quando a tela é rolada
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),

                buildSectionTitle("Em Cartaz"),
                buildCarouselMovieCard(),

                const SizedBox(height: 30),

                buildIndicator(),

                const SizedBox(height: 30),

                buildSectionTitle("Popular"),
                buildListViewMovieCard(_controllerPopular), //

                const SizedBox(height: 30),

                buildSectionTitle("Melhores Avaliados"),
                buildListViewMovieCard(_controllerTopRated),

                const SizedBox(height: 30),

                buildSectionTitle("Em Breve"),
                buildListViewMovieCard(_controllerUpcoming),

                const SizedBox(height: 100),
              ],
            ),
          ),
          // buildBottomNavigation(),
        ],
      ),
    );
  }

  _homeAppBar() {
    return AppBar(
      title: const Text("The Movie App"),
      elevation: 0,
      backgroundColor: mainColor,
    );
  }

  Widget buildCarouselMovieCard() {
    return CarouselSlider.builder(
      itemCount: _controllerNowPlaying.moviesCount,
      itemBuilder: _buildNowPlayingMovieCard,
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget buildListViewMovieCard(MovieController _mc) {
    return SizedBox(
      height: 230,
      width: 500,
      child: ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: _mc.moviesCount,
        itemBuilder: (context, index) => _itemBuilder(context, index, _mc),
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
      ),
    );
  }

  Widget buildSectionTitle(String titleSection) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        child: Text(
          titleSection,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _currentIndex,
      count: 10,
      effect: const ExpandingDotsEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.red,
      ),
    );
  }

  Widget _buildNowPlayingMovieCard(context, index, _) {
    final movie = _controllerNowPlaying.movies[index];
    return MovieCardNowPlaying(
      posterPath: movie.backdropPath,
      title: movie.title,
      rate: movie.voteAverage,
      onTap: () => openDetailPage(movie.id, context),
    );
  }

  Widget _itemBuilder(_, int index, MovieController _movie) {
    final movie = _movie.movies[index];
    final posterPath = movie.posterPath;
    final urlPoster = '$urlPoster780$posterPath';
    return GestureDetector(
      child: buildImagePoster(urlPoster),
      onTap: () => openDetailPage(movie.id, context),
    );
  }
}
