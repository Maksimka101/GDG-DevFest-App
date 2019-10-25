import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/day_bloc.dart';
import 'package:flutter_devfest/agenda/day_event.dart';
import 'package:flutter_devfest/map/map_page.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map';

  @override
  Widget build(BuildContext context) {
    final bloc = DayBloc();
    return DevScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: StreamBuilder<DayEvent>(
          stream: bloc.uiEvents,
          builder: (c, daySnap) {
            return MapPage(
                isFirstDay: daySnap.data.runtimeType == FirstDayEvent);
          },
        ),
      ),
      title: "Locate Us",
      fab: FloatingActionButton.extended(
          onPressed: () => bloc.events.add(ChangeDayEvent()),
          label: Text('Change day')),
    );
  }
}
