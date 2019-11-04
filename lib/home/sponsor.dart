class SponsorData {
  final List<TypedSponsors> typedSponsors;

  SponsorData(this.typedSponsors);
}

class TypedSponsors {
  String title;
  List<Sponsor> typedSponsors = [];
  TypedSponsors({this.title});
}

class Sponsor {
  String name;
  String url;
  String logo;

  Sponsor({this.name, this.url, this.logo});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    logo = json['logo'];
  }

  Sponsor.fromFirestore(Map json)
      : name = json['name'],
        logo = json['logoUrl'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['logo'] = this.logo;
    return data;
  }
}
