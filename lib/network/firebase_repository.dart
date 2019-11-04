import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';

class FirebaseRepository {
  final _firestore = Firestore.instance;
  final Map<String, Session> _sessions = <String, Session>{};
  final Map<String, Speaker> _speakers = <String, Speaker>{};
  static const firstDaySessionsDate = '2019-11-15';
  static const secondDaySessionsDate = '2019-11-16';
  static final _repositorySingleton = FirebaseRepository._();

  factory FirebaseRepository() {
    return _repositorySingleton;
  }

  FirebaseRepository._();

  Future<void> _loadSpeakers() async {
    var speakersSnapshot =
        await _firestore.collection('speakers').getDocuments();
    for (var speakerSnap in speakersSnapshot.documents)
      _speakers[speakerSnap.documentID] = Speaker.fromFirestoreJson(
        speakerSnap.data,
        speakerSnap.documentID,
      );
  }

  Future<void> _loadSessions() async {
    var sessionsSnapshot =
        await _firestore.collection('sessions').getDocuments();
    for (var sessionDoc in sessionsSnapshot.documents) {
      var session =
          Session.fromFirestoreJson(sessionDoc.data, sessionDoc.documentID);
      if (sessionDoc['speakers'] != null)
        for (final speakerId in sessionDoc['speakers'])
          session.speakers.add(_speakers[speakerId]);
      _sessions[sessionDoc.documentID] = session;
    }
  }

  Future<SessionsData> get sessions async {
    await _loadSpeakers();
    await _loadSessions();
    final sessions = <Session>[];
    for (final sessionDay in [
      FirebaseRepository.firstDaySessionsDate,
      FirebaseRepository.secondDaySessionsDate
    ]) {
      DocumentSnapshot scheduleSnap =
          await _firestore.collection('schedule').document(sessionDay).get();
      final tracks = scheduleSnap.data['tracks'];
      for (final timeSlot in scheduleSnap.data['timeslots']) {
        final currentSession = timeSlot['sessions'];
        for (int i = 0; i < currentSession.length; i++) {
          final session =
              _sessions[currentSession[i]['items'].first.toString()].copy();
          session.track = tracks[i]['title'];
          session.sessionStartTime = timeSlot['startTime'];
          session.sessionEndTime = timeSlot['endTime'];
          if (session.sessionImage != null) {
            for (final track in tracks) {
              sessions.add(session.copy()..track = track['title']);
            }
          } else {
            sessions.add(session);
          }
        }
      }
    }
    _sessions.clear();
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

  Future<SpeakersData> get speakers async {
    var speakers = _speakers.values.toList();
    _speakers.clear();
    return SpeakersData(speakers: speakers);
  }

  Future<SponsorData> get sponsors async {
    final typedSponsors = <TypedSponsors>[];
    final sponsorsDoc = await _firestore.collection('partners').getDocuments();
    for (final sponsors in sponsorsDoc.documents) {
      final typedSponsor = TypedSponsors(title: sponsors['title']);
      final sponsorItems = await _firestore
          .collection('partners')
          .document(sponsors.documentID)
          .collection('items')
          .getDocuments();
      for (final sponsor in sponsorItems.documents) {
        typedSponsor.typedSponsors.add(Sponsor.fromFirestore(sponsor.data));
      }
      typedSponsors.add(typedSponsor);
    }
    return SponsorData(typedSponsors);
  }
}
