import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_list.dart';
import 'package:flutter_devfest/home/index.dart';

class SessionScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final String trackName;

  const SessionScreen({Key key, this.homeBloc, @required this.trackName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var allSessions = state.sessionsData.sessions;
    var requiredSessions = allSessions.where((s) {
      return s.track == trackName;
    }).toList();
    return SessionList(
      allSessions: requiredSessions,
    );
  }
}
