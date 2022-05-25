import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:testing/models/account_model.dart';

class SoccerApi {
 static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",

    //Email: livescoreflutter@gmail.com
    'x-rapidapi-key': "1f94e4deb89e2668b9094aad2f453244",

    //To refresh the data from the api
    'x-rapidapi-refresh': "15",
  };

  Future<List<AccountStatus>> getAccountStatus() async {
    Response response = await get(
        Uri.parse("https://v3.football.api-sports.io/status"),
        headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> statusList = body['response'];
      print("Account Status: $body");
      List<AccountStatus> account = statusList
          .map((dynamic item) => AccountStatus.fromJson(item))
          .toList();
      return account;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
