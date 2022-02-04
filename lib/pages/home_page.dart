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

  final String _urlPoster = 'https://image.tmdb.org/t/p/w780/';

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
          buildBottomNavigation(),
        ],
      ),
    );
  }

  _homeAppBar() {
    return AppBar(
      title: const Text("The Movie App"),
      elevation: 0,
      backgroundColor: Colors.black,
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
      height: 200,
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

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        // Permite adicionar um indicador de progresso enquanto a imagem é carregada
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

  Widget buildBottomNavigation() {
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

  Widget _itemBuilder(BuildContext context, int index, MovieController _movie) {
    final movie = _movie.movies[index];
    final posterPath = movie.posterPath;
    final urlPoster = '$_urlPoster$posterPath';
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
