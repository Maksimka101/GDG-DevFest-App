import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_screen.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
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
            Tab(
              child: Text("Confirence room", textAlign: TextAlign.center,),
              icon: Icon(
                FontAwesomeIcons.cloud,
                size: 12,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            SessionScreen(
              sessionName: 'Room 1',
              homeBloc: _homeBloc,
            ),
            SessionScreen(
              sessionName: 'Room 2',
              homeBloc: _homeBloc,
            ),
            SessionScreen(
              sessionName: 'Room 3',
              homeBloc: _homeBloc,
            ),
            SessionScreen(
              sessionName: 'Conference Room',
              homeBloc: _homeBloc,
            ),
          ],
        ),
//        fab: FloatingActionButton.extended(
//          label: Text(''),
//        ),
      ),
    );
  }
}
