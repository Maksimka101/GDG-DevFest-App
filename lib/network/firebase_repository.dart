import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/team.dart';

class FirebaseRepository {
  final _firestore = Firestore.instance;
  static const firstDaySessionsDate = '2019-11-15';
  static const secondDaySessionsDate = '2019-11-16';
  static final _repositorySingleton = FirebaseRepository._();

  factory FirebaseRepository() {
    return _repositorySingleton;
  }

  FirebaseRepository._();

  Future<Session> _getSession(String id) async {
    final sessionDoc =
        await _firestore.collection('sessions').document(id).get();
    final session =
        Session.fromFirestoreJson(sessionDoc.data, sessionDoc.documentID);
    if (sessionDoc['speakers'] != null)
      for (final speakerId in sessionDoc['speakers'])
        session.speakers.add(await _getSpeaker(speakerId));
    return session;
  }

  Future<SessionsData> get sessions async {
    DocumentSnapshot scheduleSnap = await _firestore
        .collection('schedule')
        .document(FirebaseRepository.firstDaySessionsDate)
        .get();
    final tracks = scheduleSnap.data['tracks'];
    final sessions = <Session>[];
    for (final timeSlot in scheduleSnap.data['timeslots']) {
      final currentSession = timeSlot['sessions'];
      for (int i = 0; i < currentSession.length; i++) {
        final session =
            await _getSession(currentSession[i]['items'].first.toString());
        session.track = tracks[i]['title'];
        session.sessionStartTime = timeSlot['startTime'];
        session.sessionEndTime = timeSlot['endTime'];
        sessions.add(session);
      }
    }
    return SessionsData(sessions: sessions);
  }

  Future<TeamsData> get teams async {
    final teamDoc = await _firestore
        .collection('team')
        .document('0')
        .collection('members')
        .getDocuments();
    return TeamsData(
        teams: teamDoc.documents
            .map((member) => Team.fromFirestoreJson(member.data))
            .toList());
  }

  Future<Speaker> _getSpeaker(String id) async {
    final speaker = await _firestore.collection('speakers').document(id).get();
    return Speaker.fromFirestoreJson(speaker.data, speaker.documentID);
  }

  Future<SpeakersData> get speakers async {
    final speakersDoc = await _firestore.collection('speakers').getDocuments();
    return SpeakersData(
      speakers: speakersDoc.documents
          .map<Speaker>((speakerDoc) =>
              Speaker.fromFirestoreJson(speakerDoc.data, speakerDoc.documentID))
          .toList(),
    );
  }
}
