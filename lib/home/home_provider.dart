import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/network/firebase_repository.dart';
import 'package:flutter_devfest/network/i_client.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';

abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();

  Future<SessionsData> getSessions();

  Future<TeamsData> getTeams();

  Future<SponsorData> getSponsors();
}

/// Firebase home provider
class FHomeProvider implements IHomeProvider {
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  @override
  Future<SessionsData> getSessions() async {
    return await _firebaseRepository.sessions;
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    return await _firebaseRepository.speakers;
  }

  @override
  Future<TeamsData> getTeams() async {
    return await _firebaseRepository.teams;
  }

  @override
  Future<SponsorData> getSponsors() async {
    return await _firebaseRepository.sponsors;
  }

}

class HomeProvider implements IHomeProvider {
  IClient _client;

  static final String kConstGetSpeakersUrl =
      "${Devfest.baseUrl}/speaker-kol.json";

  //! Not Working
  static final String kConstGetFirstDaySessionsUrl =
      "${Devfest.baseUrl}/session-kol.json";

  static final String kConstGetSecondDaySessionsUrl =
      '${Devfest.baseUrl}/session-kol.json';

  //! Not Working
  static final String kConstGetTeamsUrl = "${Devfest.baseUrl}/team-kol.json";

  HomeProvider() {
    _client = Injector().currentClient;
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    var result = await _client.getAsync<SpeakersData>(kConstGetSpeakersUrl);
    if (result.networkServiceResponse.success) {
      SpeakersData res = SpeakersData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SessionsData> getSessions() async {
    var result = await _client.getAsync<SessionsData>(kConstGetFirstDaySessionsUrl);
    if (result.networkServiceResponse.success) {
      SessionsData res = SessionsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<TeamsData> getTeams() async {
    var result = await _client.getAsync<TeamsData>(kConstGetTeamsUrl);
    if (result.networkServiceResponse.success) {
      TeamsData res = TeamsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SponsorData> getSponsors() {
    
    return null;
  }
}
