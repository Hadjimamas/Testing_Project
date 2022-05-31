class Standings {
  League? league;

  Standings({
    this.league,
  });

  Standings.fromJson(Map<String, dynamic> json) {
    league = (json['league'] as Map<String,dynamic>?) != null ? League.fromJson(json['league'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['league'] = league?.toJson();
    return json;
  }
}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  List<dynamic>? standings;

  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.standings,
  });

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    country = json['country'] as String?;
    logo = json['logo'] as String?;
    flag = json['flag'] as String?;
    season = json['season'] as int?;
    standings = json['standings'] as List?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['country'] = country;
    json['logo'] = logo;
    json['flag'] = flag;
    json['season'] = season;
    json['standings'] = standings;
    return json;
  }
}