class MatchPredictions {
  Predictions? predictions;
  Comparison? comparison;

  MatchPredictions({this.predictions, this.comparison});

  MatchPredictions.fromJson(Map<String, dynamic> json) {
    predictions = json['predictions'] != null
        ? Predictions.fromJson(json['predictions'])
        : null;
    comparison = json['comparison'] != null
        ? Comparison.fromJson(json['comparison'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictions != null) {
      data['predictions'] = predictions!.toJson();
    }
    if (comparison != null) {
      data['comparison'] = comparison!.toJson();
    }
    return data;
  }
}

class Predictions {
  Winner? winner;
  bool? winOrDraw;
  String? underOver;
  Goals? goals;
  String? advice;
  Percent? percent;

  Predictions(
      {this.winner,
      this.winOrDraw,
      this.underOver,
      this.goals,
      this.advice,
      this.percent});

  Predictions.fromJson(Map<String, dynamic> json) {
    winner = json['winner'] != null ? Winner.fromJson(json['winner']) : null;
    winOrDraw = json['win_or_draw'];
    underOver = json['under_over'];
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    advice = json['advice'];
    percent =
        json['percent'] != null ? Percent.fromJson(json['percent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (winner != null) {
      data['winner'] = winner!.toJson();
    }
    data['win_or_draw'] = winOrDraw;
    data['under_over'] = underOver;
    if (goals != null) {
      data['goals'] = goals!.toJson();
    }
    data['advice'] = advice;
    if (percent != null) {
      data['percent'] = percent!.toJson();
    }
    return data;
  }
}

class Winner {
  int? id;
  String? name;
  String? comment;

  Winner({this.id, this.name, this.comment});

  Winner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['comment'] = comment;
    return data;
  }
}

class Goals {
  String? home;
  String? away;

  Goals({this.home, this.away});

  Goals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    return data;
  }
}

class Percent {
  String? home;
  String? draw;
  String? away;

  Percent({this.home, this.draw, this.away});

  Percent.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    draw = json['draw'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['draw'] = draw;
    data['away'] = away;
    return data;
  }
}

class Comparison {
  Goals? form;
  Goals? att;
  Goals? def;
  Goals? poissonDistribution;
  Goals? h2h;
  Goals? goals;
  Goals? total;

  Comparison(
      {this.form,
      this.att,
      this.def,
      this.poissonDistribution,
      this.h2h,
      this.goals,
      this.total});

  Comparison.fromJson(Map<String, dynamic> json) {
    form = json['form'] != null ? Goals.fromJson(json['form']) : null;
    att = json['att'] != null ? Goals.fromJson(json['att']) : null;
    def = json['def'] != null ? Goals.fromJson(json['def']) : null;
    poissonDistribution = json['poisson_distribution'] != null
        ? Goals.fromJson(json['poisson_distribution'])
        : null;
    h2h = json['h2h'] != null ? Goals.fromJson(json['h2h']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    total = json['total'] != null ? Goals.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (form != null) {
      data['form'] = form!.toJson();
    }
    if (att != null) {
      data['att'] = att!.toJson();
    }
    if (def != null) {
      data['def'] = def!.toJson();
    }
    if (poissonDistribution != null) {
      data['poisson_distribution'] = poissonDistribution!.toJson();
    }
    if (h2h != null) {
      data['h2h'] = h2h!.toJson();
    }
    if (goals != null) {
      data['goals'] = goals!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    return data;
  }
}
