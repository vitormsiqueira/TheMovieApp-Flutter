import 'package:flutter/material.dart';

class MovieCardPopular extends StatelessWidget {
  final String? posterPath;
  final String? title;
  final double? rate;
  final VoidCallback onTap;

  const MovieCardPopular({
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
      child:
          //Stack(
          //  alignment: AlignmentDirectional.bottomStart,
          //  children: [
          Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/w780/$posterPath',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      //       child: Text(
      //         '$title',
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontSize: 22.0,
      //           fontWeight: FontWeight.w700,
      //           shadows: <Shadow>[
      //             Shadow(
      //               offset: Offset.zero,
      //               blurRadius: 20.0,
      //               color: Colors.black,
      //             ),
      //             Shadow(
      //               offset: Offset.zero,
      //               blurRadius: 5.0,
      //               color: Colors.black,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(
      //         left: 15.0,
      //         right: 15.0,
      //         bottom: 15.0,
      //       ),
      //       child: Row(
      //         children: [
      //           const Icon(
      //             Icons.star_rounded,
      //             color: Colors.yellow,
      //             size: 20.0,
      //           ),
      //           Text(
      //             '$rate',
      //             style: const TextStyle(
      //               color: Colors.white,
      //               fontSize: 15.0,
      //               fontWeight: FontWeight.w500,
      //               shadows: <Shadow>[
      //                 Shadow(
      //                   offset: Offset.zero,
      //                   blurRadius: 20.0,
      //                   color: Colors.black,
      //                 ),
      //                 Shadow(
      //                   offset: Offset.zero,
      //                   blurRadius: 5.0,
      //                   color: Colors.black,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      //    ],
      //  ),
    );
  }
}
