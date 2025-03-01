import 'dart:async';
import 'package:flutter_devfest/home/home_provider.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  final IHomeProvider _homeProvider = Injector().currentHomeProvider;
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      var sessionsData = await _homeProvider.getSessions();
      var speakersData = await _homeProvider.getSpeakers();
      var teamsData = await _homeProvider.getTeams();
      final sponsorDdata = await _homeProvider.getSponsors();
      return InHomeState(
        sponsorData: sponsorDdata,
        speakersData: speakersData,
        sessionsData: sessionsData,
        teamsData: teamsData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
  }
}
