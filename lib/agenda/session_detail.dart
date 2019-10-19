import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetail extends StatelessWidget {
  static const String routeName = "/session_detail";
  final Session session;

  SessionDetail({Key key, @required this.session}) : super(key: key);

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].githubUrl);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  /// it is the sum of avatar radius + sizedBox h +
                  /// texts font size + random number
                  height: 100*2 + 10 + 16 + 14.0,
                  /// it is the width - padding
                  width: MediaQuery.of(context).size.width - 18*2,
                  child: PageView(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Hero(
                            tag: session.speakers.first.speakerImage,
                            child: CircleAvatar(
                              radius: 100.0,
                              backgroundImage: CachedNetworkImageProvider(
                                session.speakers.first.speakerImage,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${session.speakers.first.speakerName}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.title.copyWith(
                              fontSize: 16,
                              height: 1,
                              color: Tools.multiColors[Random().nextInt(4)],
                            ),
                          ),
                          Text(
                            "${session.speakers.first.speakerDesc}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontSize: 14,
                                  height: 1,
                                  color: Tools.multiColors[Random().nextInt(4)],
                                ),
                          ),
                        ],
                      ),
                      if (session.speakers.length > 1)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 100.0,
                              backgroundImage: CachedNetworkImageProvider(
                                session.speakers[1].speakerImage,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${session.speakers[1].speakerName}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.title.copyWith(
                                fontSize: 16,
                                height: 1,
                                color: Tools.multiColors[Random().nextInt(4)],
                              ),
                            ),
                            Text(
                              "${session.speakers[1].speakerDesc}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.title.copyWith(
                                fontSize: 14,
                                height: 1,
                                color: Tools.multiColors[Random().nextInt(4)],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                "${session.sessionTitle}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                session.sessionDesc,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
//              socialActions(context),
            ],
          ),
        ),
      ),
      title: 'Session',
    );
  }
}
