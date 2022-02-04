import 'package:flutter/material.dart';
import 'package:the_movie_app/controllers/movie_controller.dart';
import 'package:the_movie_app/widgets/centerad_message.dart';
import 'package:the_movie_app/widgets/movie_card_now_playing.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _controller = MovieController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovies(page: page, classMovie: 'now_playing');

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMovieGrid(),
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_controller.movieError != null) {
      return const CenteredMessage(message: "Error!!!!");
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2.0),
      itemCount: _controller.moviesCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
      ),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCardNowPlaying(
        posterPath: movie.posterPath,
        title: movie.title,
        rate: movie.voteAverage,
        onTap: () {} //() => _openDetailPage(movie.id),
        );
  }
}
