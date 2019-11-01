import 'package:flutter/material.dart';
import 'package:flutter_devfest/map/map_page.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: DevScaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: TabBarView(
              children: <Widget>[
                MapPage(isFirstDay: true),
                MapPage(isFirstDay: false)
              ],
            ),
          ),
          title: "Locate Us",
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'First day',
              ),
              Tab(
                text: 'Second day',
              )
            ],
          ),
        ));
  }
}
