import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_app/controllers/movie_controller.dart';
import 'package:the_movie_app/controllers/person_detail_controller.dart';
import 'package:the_movie_app/controllers/person_movie_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/models/person_model.dart';
import 'package:the_movie_app/utils/appbar.dart';
import 'package:the_movie_app/utils/open_page.dart';
import 'package:the_movie_app/widgets/build_image_cover.dart';
import 'package:the_movie_app/widgets/build_image_poster.dart';
import 'package:the_movie_app/widgets/description_text.dart';
import 'package:the_movie_app/widgets/section_title.dart';
import 'package:the_movie_app/widgets/transition_shadow.dart';

class DetailPersonPage extends StatefulWidget {
  final int personId;
  const DetailPersonPage(this.personId, {Key? key}) : super(key: key);

  @override
  _DetailPersonPageState createState() => _DetailPersonPageState();
}

class _DetailPersonPageState extends State<DetailPersonPage> {
  final _controllerPerson = PersonDetailController();
  final _controllerMovie = MovieController();
  final _controllerPersonMovie = PersonMovieController();

  final _scrollController = ScrollController();
  final kExpandedHeight = 400.0;
  final kToolbarHeight = 55.0;

  bool isHeart = false;

  double largImage = 150;
  double marginImage = 20;
  double alturaImagem = 220;

  @override
  void initState() {
    super.initState();
    _initializePerson();
    _initializePersonMovie();
    _initializeScroll();
  }

  _initializeScroll() async {
    _scrollController.addListener(() => setState(() {}));
  }

  _initializePerson() async {
    setState(() {
      _controllerPerson.loading = true;
    });

    await _controllerPerson.fetchPersonById(widget.personId);

    setState(() {
      _controllerPerson.loading = false;
    });
  }

  _initializePersonMovie() async {
    setState(() {
      _controllerPersonMovie.loading = true;
    });

    await _controllerPersonMovie.fetchPersonMovieById(widget.personId);

    setState(() {
      _controllerPersonMovie.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(personName.toString()),
      //   elevation: 0,
      //   backgroundColor: mainColor,
      // ),
      body: _buildBodyPersonDetail(),
    );
  }

  Widget _buildBodyPersonDetail() {
    print(widget.personId);
    final person = _controllerPerson.personDetail;
    if (_controllerPerson.loading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: mainColor,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    final personPath = person?.profilePath;
    final personBiography = person?.biography;
    final pathImage = personPath ?? urlAlternative;
    final personPlaceOfBirth = person?.placeOfBirth ?? '';
    final personBirthday = person?.birthday ?? DateTime.now();
    final personKnowFor = person?.knownForDepartment;
    final personPopularity = person?.popularity;
    String personName = person?.name ?? '';
    _controllerPerson.personDetail?.knownForDepartment ?? '';

    final today = DateTime.now();
    final age = today.difference(personBirthday).inDays ~/ 365;

    return CustomScrollView(
      // Let show blank space when scroll page down
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),

      slivers: <Widget>[
        MySliverAppBar(
          personName,
          '$urlPoster400$pathImage',
          kExpandedHeight,
          isHeart,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: mainColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const SizedBox(width: 10),
                    //     _buildInfo(
                    //       age.toString(),
                    //       'Idade',
                    //     ),
                    //     _buildInfo(
                    //       personKnowFor.toString(),
                    //       'Conhecido(a) como',
                    //     ),
                    //     _buildInfo(
                    //       personPopularity.toString(),
                    //       'Popularidade',
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: buildSectionTitle('Biografia'),
                    ),
                    DescriptionTextWidget(text: personBiography ?? ''),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: buildSectionTitle('Conhecido(a) por'),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(5.0),
                          itemCount: _controllerPersonMovie.castCount,
                          itemBuilder: _buildKnownForCast,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: buildSectionTitle('Conhecido(a) por'),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(5.0),
                          itemCount: _controllerPersonMovie.crewCount,
                          itemBuilder: _buildKnownForCrew,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKnownForCast(_, index) {
    final similar = _controllerPersonMovie.cast[index];
    final similarPath = similar.posterPath;
    final urlPoster = '$urlPoster400$similarPath';
    final pathImage = similarPath == null ? urlAlternative : urlPoster;
    return GestureDetector(
      child: buildImagePoster(pathImage),
      onTap: () => openDetailPage(similar.id, context),
    );
  }

  Widget _buildKnownForCrew(_, index) {
    final similar = _controllerPersonMovie.crew[index];
    final similarPath = similar.posterPath;
    final urlPoster = '$urlPoster400$similarPath';
    final pathImage = similarPath == null ? urlAlternative : urlPoster;
    return GestureDetector(
      child: buildImagePoster(pathImage),
      onTap: () => openDetailPage(similar.id, context),
    );
  }

  _buildInfo(String text, String label) {
    return SizedBox(
      width: 90,
      height: 90,
      // color: Colors.green,
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  // _buildImage(BuildContext context, PersonDetail? _person) {
  //   final personPath = _person?.profilePath;
  //   final pathImage = personPath ?? urlAlternative;

  //   return Stack(
  //     alignment: Alignment.topCenter,
  //     clipBehavior: Clip.none,
  //     children: [
  //       buildCover(pathImage, urlPoster400),
  //     ],
  //   );
  // }

  // _buildbiography(PersonDetail? _person) {
  //   final personBiography = _person?.biography;

  //   return Container(
  //     padding: const EdgeInsets.only(right: 20),
  //     height: alturaImagem,
  //     width: MediaQuery.of(context).size.width - largImage - (marginImage * 2),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: const [
  //             Text(
  //               "Biografia",
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //                 letterSpacing: 0.5,
  //               ),
  //             )
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         SizedBox(
  //           height: alturaImagem - 50,
  //           child: Text(
  //             '$personBiography',
  //             textAlign: TextAlign.justify,
  //             overflow: TextOverflow.fade,
  //             style: const TextStyle(
  //               color: Colors.white70,
  //               fontSize: 12.0,
  //               letterSpacing: 0.2,
  //               height: 1.4,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _buildRelated() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
  //         child: Row(
  //           children: [
  //             buildSectionTitle("Aparece em"),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       SingleChildScrollView(
  //         child: SizedBox(
  //           height: 250,
  //           child: ListView.builder(
  //             padding: const EdgeInsets.all(5.0),
  //             itemCount: _controllerMovie.moviesCount,
  //             itemBuilder: _buildMovie,
  //             scrollDirection: Axis.horizontal,
  //             shrinkWrap: true,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _buildMovie(_, index) {
  //   final movie = _controllerMovie.movies[index];
  //   final moviePath = movie;
  //   final urlPoster = '$urlPoster400$moviePath';
  //   final pathImage = moviePath == null ? urlAlternative : urlPoster;
  //   return GestureDetector(
  //     child: buildImagePoster(pathImage),
  //     onTap: () => openDetailPage(movie.id, context),
  //   );
  // }
}
