import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/widgets/transition_shadow.dart';

class MySliverAppBar extends StatefulWidget {
  final String appbarText;
  final String posterPath;
  final double kExpandedHeight;
  bool heart;
  final Color myBackgroudColor;

  MySliverAppBar(
    this.appbarText,
    this.posterPath,
    this.kExpandedHeight,
    this.heart, {
    Key? key,
    this.myBackgroudColor = Colors.white,
  }) : super(key: key);

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: mainColor,
      expandedHeight: widget.kExpandedHeight,
      pinned: true,
      floating: false,
      snap: false,
      toolbarHeight: kToolbarHeight,
      stretch: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(
              () {
                widget.heart = widget.heart ? false : true;
              },
            );
          },
          icon: Icon(
            widget.heart ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: widget.heart ? Colors.red : Colors.white,
          ),
        ),
      ],
      // stretchTriggerOffset: 20,
      // Text for AppBar is only showed when scrolling page down

      // onStretchTrigger: () {
      //   return RefreshIndicator(child: child, onRefresh: onRefresh);
      // },

      // Text for Initial State. Dissapear when scroll page down
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: Text(
          widget.appbarText,
          textScaleFactor: 1,
          style: TextStyle(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.85),
                offset: const Offset(1, 1),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        background: Image.network(
          widget.posterPath,
          fit: BoxFit.cover,
        ),
        stretchModes: const [
          // StretchMode.blurBackground,
          StretchMode.zoomBackground,
          // StretchMode.fadeTitle,
        ],
      ),

      elevation: 0,
    );
  }
}
