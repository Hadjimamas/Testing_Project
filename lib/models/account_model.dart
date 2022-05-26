class AccountDetails {
  Response? response;

  AccountDetails({this.response});

  AccountDetails.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  Account? account;
  Subscription? subscription;
  Requests? requests;

  Response({this.account, this.subscription, this.requests});

  Response.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    requests =
        json['requests'] != null ? Requests.fromJson(json['requests']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    if (requests != null) {
      data['requests'] = requests!.toJson();
    }
    return data;
  }
}

class Account {
  String? firstname;
  String? lastname;
  String? email;

  Account({this.firstname, this.lastname, this.email});

  Account.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    return data;
  }
}

class Subscription {
  String? plan;
  String? end;
  bool? active;

  Subscription({this.plan, this.end, this.active});

  Subscription.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    end = json['end'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan'] = plan;
    data['end'] = end;
    data['active'] = active;
    return data;
  }
}

class Requests {
  int? current;
  int? limitDay;

  Requests({this.current, this.limitDay});

  Requests.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    limitDay = json['limit_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['limit_day'] = limitDay;
    return data;
  }
}
