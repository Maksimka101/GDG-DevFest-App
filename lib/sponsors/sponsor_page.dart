import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/home/home_state.dart';
import 'package:flutter_devfest/sponsors/sponsors_item.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";
  
  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeBloc();
    final state = homeBloc.currentState as InHomeState;
    final sponsors = state.sponsorData.typedSponsors;
    return DevScaffold(
      body: ListView.builder(
        itemCount: sponsors.length,
        itemBuilder: (c, index) => SponsorItem(typedSponsors: sponsors[index],),
      ),
      title: "Sponsors",
    );
  }
}

class SponsorImage extends StatelessWidget {
  final String imgUrl;

  const SponsorImage({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          height: 200.0,
          width: 200.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
