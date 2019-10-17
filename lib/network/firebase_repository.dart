import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/team.dart';

class FirebaseRepository {
  final _firestore = Firestore.instance;
  static final _repositorySingleton = FirebaseRepository._();

  factory FirebaseRepository() {
    return _repositorySingleton;
  }

  FirebaseRepository._();

  Future<SessionsData> get sessions async {
    return SessionsData(sessions: []);
  }

  Future<TeamsData> get teams async {
    return TeamsData(teams: []);
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
