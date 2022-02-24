import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55,
              color: mainColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 10.0, right: 15.0, top: 10),
                child: CupertinoSearchTextField(
                  // itemColor: Colors.white,
                  style: const TextStyle(color: Colors.grey),
                  placeholderStyle: const TextStyle(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                  suffixInsets:
                      const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                  prefixInsets:
                      const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                  suffixIcon: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),

                  onChanged: (String value) {
                    print('The text has changed to: $value');
                  },
                  onSubmitted: (String value) {
                    print('Submitted text: $value');
                  },
                ),
              ),
            ),
            Container(
              color: mainColor,
              height: 800,
            )
          ],
        ),
      ),
    );
  }
}
