import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_movie_app/controllers/movie_controller.dart';
import 'package:the_movie_app/controllers/person_detail_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/models/person_model.dart';
import 'package:the_movie_app/utils/open_page.dart';
import 'package:the_movie_app/widgets/build_image_cover.dart';
import 'package:the_movie_app/widgets/build_image_poster.dart';
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

  double largImage = 150;
  double marginImage = 20;
  double alturaImagem = 220;

  @override
  void initState() {
    super.initState();
    _initializePerson();
    // _initializeMovie();
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

  _initializeMovie() async {
    setState(() {
      _controllerMovie.loading = true;
    });

    await _controllerMovie.fetchMovies(
      idPerson: widget.personId,
      responseType: 2,
    );

    setState(() {
      _controllerMovie.loading = false;
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
    final pathImage = personPath ?? urlAlternative;
    String personName = _controllerPerson.personDetail?.name ?? '';
    double? personPopularity = _controllerPerson.personDetail?.popularity;
    String? personKnowDepartment =
        _controllerPerson.personDetail?.knownForDepartment ?? '';

    return Container(
      color: mainColor,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  '$urlPosterOriginal$pathImage',
                  fit: BoxFit.cover,
                ),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.blueGrey.withOpacity(0.4),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                // transitionShadow(altura: 600),
              ],
            ),
          ),
          Center(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 220,
                          color: Colors.transparent,
                        ),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        buildImagePoster(
                          '$urlPoster400$pathImage',
                          larg: 150,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            personName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_border_purple500_rounded,
                              color: Colors.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                personPopularity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            personKnowDepartment,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // Container(
                //   height: 100,
                //   color: mainColor,
                // ),
              ],
            ),
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
