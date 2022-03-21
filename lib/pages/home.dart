import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/pages/home_page.dart';
import 'package:the_movie_app/pages/my_list_page.dart';
import 'package:the_movie_app/pages/profile_page.dart';
import 'package:the_movie_app/pages/search_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool pressed = false;
  int _selectedPage = 0;
  final _pageOptions = const [
    MyHomePage(title: "The Movie App"),
    SearchPage(),
    MyListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pageOptions[_selectedPage],
          buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget buildBottomNavigation() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      //this is very important, without it the whole screen will be blurred
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white24,
              width: .5,
            ),
          ),
        ),
        height: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          //I'm using BackdropFilter for the blurring effect
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Opacity(
              opacity: 0.8,
              child: BottomNavigationBar(
                currentIndex: _selectedPage,
                onTap: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white38,
                selectedItemColor: greenSelect,
                selectedFontSize: 9,
                unselectedFontSize: 9,
                backgroundColor: mainColor,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.house_fill,
                      size: 22,
                    ),
                    label: "Inicio",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.search,
                      size: 22,
                    ),
                    label: "Pesquisar",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.square_list,
                      size: 22,
                    ),
                    label: "Minha Lista",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.profile_circled,
                      size: 22,
                    ),
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
}
