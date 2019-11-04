import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_screen.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondDayPage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Tools.multiColors[Random().nextInt(4)],
            labelStyle: TextStyle(
              fontSize: 12,
            ),
            isScrollable: false,
            tabs: <Widget>[
              Tab(
                child: Text("Oka"),
                icon: Icon(
                  FontAwesomeIcons.mobile,
                  size: 12,
                ),
              ),
              Tab(
                child: Text("Volga"),
                icon: Icon(
                  FontAwesomeIcons.chrome,
                  size: 12,
                ),
              ),
            ],
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                SessionScreen(
                  trackName: 'Oka',
                  homeBloc: homeBloc,
                ),
                SessionScreen(
                  trackName: 'Volga',
                  homeBloc: homeBloc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
