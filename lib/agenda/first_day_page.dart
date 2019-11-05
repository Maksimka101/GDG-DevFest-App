import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_screen.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/utils/tools.dart';

class FirstDayPage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                child: Text(
                  "Conference room",
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text("Room 1"),
              ),
              Tab(
                child: Text("Room 2"),
              ),
              Tab(
                child: Text("Room 3"),
              ),
            ],
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                SessionScreen(
                  trackName: 'Conference Room',
                  homeBloc: homeBloc,
                ),
                SessionScreen(
                  trackName: 'Room 1',
                  homeBloc: homeBloc,
                ),
                SessionScreen(
                  trackName: 'Room 2',
                  homeBloc: homeBloc,
                ),
                SessionScreen(
                  trackName: 'Room 3',
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
