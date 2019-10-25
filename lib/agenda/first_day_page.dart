import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/day_bloc.dart';
import 'package:flutter_devfest/agenda/day_event.dart';
import 'package:flutter_devfest/agenda/session_screen.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstDayPage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: DevScaffold(
        title: "Agenda",
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[Random().nextInt(4)],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text("Conference room", textAlign: TextAlign.center,),
              icon: Icon(
                FontAwesomeIcons.cloud,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Room 1"),
              icon: Icon(
                FontAwesomeIcons.mobile,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Room 2"),
              icon: Icon(
                FontAwesomeIcons.chrome,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Room 3"),
              icon: Icon(
                FontAwesomeIcons.map,
                size: 12,
              ),
            ),
          ],
        ),
        body: TabBarView(
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
          fab: FloatingActionButton.extended(
            heroTag: 'ChangeDayFAB',
            label: Text('Second day'),
            onPressed: () {
              DayBloc().events.add(FirstDayEvent());
            },
          ),
      ),
    );
  }
}
