import 'dart:async';

import 'package:flutter_devfest/agenda/day_event.dart';
import 'package:rxdart/rxdart.dart';

class DayBloc {
  static final _bloc = DayBloc._();
  DayEvent _dayEvent = FirstDayEvent();
  factory DayBloc() {
    return _bloc;
  }
  DayBloc._() {
    _events.stream.listen(_listenEvents);
    _uiEvents.sink.add(_dayEvent);
  }

  final _events = StreamController<DayEvent>();
  StreamSink<DayEvent> get events => _events.sink;

  final _uiEvents = PublishSubject<DayEvent>();
  Stream<DayEvent> get uiEvents => _uiEvents.stream;

  void _listenEvents(DayEvent event) {
    switch (_dayEvent.runtimeType) {
      case FirstDayEvent:
        {
          _uiEvents.sink.add(SecondDayEvent());
          _dayEvent = SecondDayEvent();
        }
        break;
      case SecondDayEvent:
        {
          _uiEvents.sink.add(FirstDayEvent());
          _dayEvent = FirstDayEvent();
        }
        break;
    }
  }

  /// don't dispose me. I am a singleton.
  dispose() {
    _uiEvents.close();
    _events.close();
  }
}
