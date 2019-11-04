import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorItem extends StatelessWidget {
  final TypedSponsors typedSponsors;
  SponsorItem({this.typedSponsors});

  _launchSponsorUrl(String url) {
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          typedSponsors.title == '' ? 'Other' : typedSponsors.title,
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 25),
        ),
        ...typedSponsors.typedSponsors
            .map<Widget>((sponsor) => Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () => _launchSponsorUrl(sponsor.url),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        child: sponsor.logo.contains('svg')
                            ? SvgPicture.network(sponsor.logo, fit: BoxFit.scaleDown,)
                            : CachedNetworkImage(
                                fit: BoxFit.scaleDown,
                                imageUrl: sponsor.logo,
                                placeholder: (c, _) => SizedBox(
                                    height: 60, child: Text(sponsor.name)),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ))
            .toList()
      ],
    );
  }
}
