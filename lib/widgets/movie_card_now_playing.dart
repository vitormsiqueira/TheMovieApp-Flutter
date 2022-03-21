import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:the_movie_app/core/constants.dart';

class MovieCardNowPlaying extends StatefulWidget {
  final String? posterPath;
  final String? title;
  final double? rate;
  final VoidCallback onTap;

  const MovieCardNowPlaying({
    Key? key,
    required this.posterPath,
    required this.onTap,
    required this.title,
    required this.rate,
  }) : super(key: key);

  @override
  State<MovieCardNowPlaying> createState() => _MovieCardNowPlayingState();
}

class _MovieCardNowPlayingState extends State<MovieCardNowPlaying> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: widget.posterPath != null
                    ? CachedNetworkImage(
                        height: 450,
                        placeholder: (context, _) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white60,
                            ),
                          );
                        },
                        imageUrl: '$urlPoster780${widget.posterPath}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset('lib/assets/images/backdrop_alternative.png'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    '${widget.title}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset.zero,
                          blurRadius: 20.0,
                          color: Colors.black87,
                        ),
                        Shadow(
                          offset: Offset.zero,
                          blurRadius: 5.0,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.yellow,
                        size: 15.0,
                      ),
                      Text(
                        '${widget.rate}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset.zero,
                              blurRadius: 20.0,
                              color: Colors.black,
                            ),
                            Shadow(
                              offset: Offset.zero,
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
