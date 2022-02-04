import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCardNowPlaying extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: CachedNetworkImage(
                height: 220,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
                imageUrl: 'https://image.tmdb.org/t/p/w780/$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  '$title',
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
                      '$rate',
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
    );
  }
}
