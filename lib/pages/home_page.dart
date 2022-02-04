import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_movie_app/controllers/movie_controller.dart';
import 'package:the_movie_app/pages/details_movie_page.dart';
import 'package:the_movie_app/widgets/movie_card_now_playing.dart';
import 'package:the_movie_app/widgets/movie_card_popular.dart';

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
        page: page, classMovie: 'now_playing');

    setState(() {
      _controllerNowPlaying.loading = false;
    });
  }

  _initializePopular() async {
    setState(() {
      _controllerPopular.loading = true;
    });

    await _controllerPopular.fetchMovies(page: page, classMovie: 'popular');

    setState(() {
      _controllerPopular.loading = false;
    });
  }

  _initializeTopRated() async {
    setState(() {
      _controllerTopRated.loading = true;
    });

    await _controllerTopRated.fetchMovies(page: page, classMovie: 'top_rated');

    setState(() {
      _controllerTopRated.loading = false;
    });
  }

  _initializeUpcoming() async {
    setState(() {
      _controllerUpcoming.loading = true;
    });

    await _controllerUpcoming.fetchMovies(page: page, classMovie: 'upcoming');

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("The Movie App"),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      // Possibilita criar uma AppBar que esconde quando a tela é rolada
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                // Filtros de filmes e séries
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       //Filtro 1
                //       Container(
                //         color: Colors.orange,
                //         width: 150,
                //         height: 50,
                //       ),
                //       //Filtro 2
                //       Container(
                //         color: Colors.green,
                //         width: 150,
                //         height: 50,
                //       ),
                //       //Filtro 3
                //       Container(
                //         color: Colors.blue,
                //         width: 150,
                //         height: 50,
                //       ),
                //       //Filtro 4
                //       Container(
                //         color: Colors.yellow,
                //         width: 150,
                //         height: 50,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 25,
                ),

                // Titulo Em Cartaz
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    child: const Text("Em Cartaz",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        )),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                // Cria o Carrosel de Em Cartaz
                CarouselSlider.builder(
                  itemCount: _controllerNowPlaying.moviesCount,
                  itemBuilder: _buildNowPlayingMovieCard,
                  options: CarouselOptions(
                    height: 220,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) =>
                        setState(() => _currentIndex = index),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                buildIndicator(),

                const SizedBox(
                  height: 30,
                ),

                // Titulo Popular
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Popular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                ),

                //
                SizedBox(
                  height: 200,
                  width: 500,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: _controllerPopular.moviesCount,
                    itemBuilder: _buildPopularMovies,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                  ),
                ),
                //

                const SizedBox(
                  height: 30,
                ),

                // Titulo Em Cartaz
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    child: const Text(
                      "Melhores Avaliados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: _controllerTopRated.moviesCount,
                    itemBuilder: _buildTopRatedMovies,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Titulo Em Cartaz
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    child: const Text(
                      "Em Breve",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: _controllerUpcoming.moviesCount,
                    itemBuilder: _buildUpcomingMovies,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                  ),
                ),

                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: CachedNetworkImage(
          height: 220,
          width: 140,
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          },
          imageUrl: urlImage,
          fit: BoxFit.cover,
        ),
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

  Widget _buildBottomNavigation() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      //this is very important, without it the whole screen will be blurred
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          //I'm using BackdropFilter for the blurring effect
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Opacity(
              //you can change the opacity to whatever suits you best
              opacity: 0.6,
              child: BottomNavigationBar(
                currentIndex: 0,
                onTap: (int index) {
                  setState(() {
                    currentTab = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.red,
                backgroundColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: "Pesquisar",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Minha Lista",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: "Meu Perfil",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNowPlayingMovieCard(context, index, _) {
    final movie = _controllerNowPlaying.movies[index];
    return MovieCardNowPlaying(
      posterPath: movie.backdropPath,
      title: movie.title,
      rate: movie.voteAverage,
      onTap: () => _openDetailPage(movie.id),
    );
  }

  // Widget _buildPopularMovieCard(_, index) {
  //   final movie = _controllerPopular.movies[index];
  //   return MovieCardPopular(
  //       posterPath: movie.backdropPath,
  //       title: movie.title,
  //       rate: movie.voteAverage,
  //       onTap: () {} //() => _openDetailPage(movie.id),
  //       );
  // }

  Widget _buildPopularMovies(_, index) {
    final movie = _controllerPopular.movies[index];
    final posterPath = movie.posterPath;
    final urlPoster = 'https://image.tmdb.org/t/p/w780/$posterPath';
    return GestureDetector(
      child: buildImage(urlPoster, index),
      onTap: () => _openDetailPage(movie.id),
    );
  }

  Widget _buildTopRatedMovies(_, index) {
    final movie = _controllerTopRated.movies[index];
    final posterPath = movie.posterPath;
    final urlPoster = 'https://image.tmdb.org/t/p/w780/$posterPath';
    return GestureDetector(
      child: buildImage(urlPoster, index),
      onTap: () => _openDetailPage(movie.id),
    );
  }

  Widget _buildUpcomingMovies(_, index) {
    final movie = _controllerUpcoming.movies[index];
    final posterPath = movie.posterPath;
    final urlPoster = 'https://image.tmdb.org/t/p/w780/$posterPath';
    return GestureDetector(
      child: buildImage(urlPoster, index),
      onTap: () => _openDetailPage(movie.id),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }
}
