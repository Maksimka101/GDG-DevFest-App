import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_detail.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/utils/tools.dart';

class SessionList extends StatelessWidget {
  final List<Session> allSessions;

  const SessionList({Key key, @required this.allSessions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allSessions.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: InkWell(
            onTap: () {
              /// Если у сесси есть изображение, значит это не сессия,
              /// а объявление (к примеру о еде) и поэтому оно не должно
              /// быть кликабельным
              if (allSessions[i].sessionImage == null)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionDetail(
                      session: allSessions[i],
                    ),
                  ),
                );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (allSessions[i].sessionImage == null &&
                          allSessions[i].speakers.isNotEmpty)
                        Hero(
                          tag: allSessions[i].speakers.first.speakerName,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                                allSessions[i].speakers.first.speakerImage),
                          ),
                        ),
                      if (allSessions[i].speakers.length > 1 &&
                          allSessions[i].sessionImage == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                                allSessions[i].speakers[1].speakerImage),
                          ),
                        ),
                      if (allSessions[i].sessionImage != null)
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              allSessions[i].sessionImage),
                        )
                    ],
                  ),
                ),
                Flexible(
                  child: ListTile(
                    // dense: true,
                    isThreeLine: true,
                    trailing: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "${allSessions[i].sessionStartTime}\n",
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: allSessions[i].sessionEndTime,
                            style:
                                Theme.of(context).textTheme.subtitle.copyWith(
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text:
                            "${allSessions[i].sessionTitle}${allSessions[i].speakers.isNotEmpty ? '\n' : ''}",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                              text: allSessions[i]
                                  .speakers
                                  .map<String>((speaker) => speaker.speakerName)
                                  .toList()
                                  .join(' and '),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(
                                    fontSize: 14,
                                    color:
                                        Tools.multiColors[Random().nextInt(4)],
                                  ),
                              children: []),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      /// Если у сесси есть изображение, значит это не сессия,
                      /// а объявление (к примеру о еде) и поэтому я показываю
                      /// описание объявления
                      /// Иначе я смотрю сколько на сессии докладчиков
                      /// и вывожу его/их описание
                      allSessions[i].sessionImage == null
                          ? (allSessions[i].speakers.length == 1
                              ? allSessions[i].speakers.first.speakerDesc
                              : allSessions[i].speakers.fold<String>(
                                  '',
                                  (prev, speaker) =>
                                      prev +
                                      '\n${speaker.speakerName}: ${speaker.speakerDesc}'))
                          : allSessions[i].sessionDesc,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 10.0,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
