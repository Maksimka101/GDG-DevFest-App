import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "/team";

  void _launch(String url) {
    launch(url);
  }
  
  Widget socialActions(Team team) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (team.fbUrl != null)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 15,
                ),
                onPressed: () {
                  _launch(team.fbUrl);
                },
              ),
            if (team.twitterUrl != null)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 15,
                ),
                onPressed: () {
                  _launch(team.twitterUrl);
                },
              ),
            if (team.vkUrl != null)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.vk,
                  size: 15,
                ),
                onPressed: () {
                  _launch(team.vkUrl);
                },
              ),
            if (team.githubUrl != null)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.github,
                  size: 15,
                ),
                onPressed: () {
                  _launch(team.githubUrl);
                },
              ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var teams = state.teamsData.teams;
    return DevScaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          return Card(
            elevation: 0.0,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: teams[i].image,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                teams[i].name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 5,
                                color: Tools.multiColors[Random().nextInt(4)],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            teams[i].job,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Text(
//                            teams[i].contribution,
//                            style: Theme.of(context).textTheme.caption,
//                          ),
                          if (teams[i].fbUrl != null ||
                              teams[i].githubUrl != null ||
                              teams[i].vkUrl != null ||
                              teams[i].twitterUrl != null)
                          socialActions(teams[i]),
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
        itemCount: teams.length,
      ),
      title: "Team",
    );
  }
}
