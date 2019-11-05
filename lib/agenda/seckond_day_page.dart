import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_screen.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/utils/tools.dart';

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
              ),
              Tab(
                child: Text("Volga"),
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
