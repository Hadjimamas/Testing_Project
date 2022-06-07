/***
 HeadToHead(apiLink: homeId-awayId);
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_live_score/api_manager.dart';
import 'package:flutter_live_score/fixtures/fixtures_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_live_score/screens.dart';
import 'package:lottie/lottie.dart';

///Head to Head data
class HeadToHead extends StatefulWidget {
  final String apiLink;

  const HeadToHead({Key key, this.apiLink}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  HeadToHeadState createState() => HeadToHeadState(apiLink);
}

class HeadToHeadState extends State<HeadToHead> {
  final String apiLink;

  HeadToHeadState(this.apiLink);

  BannerAd inlineAd;
  bool inLineAdLoaded = false;
  static const AdRequest request = AdRequest(
      keywords: ['Livescore', 'Cyprus', 'Football', 'Scores', 'Teams'],
      nonPersonalizedAds: false);

  void loadInlineBannerAd() {
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: [
        '6DD9DB7D2871BFBBF4B4567E79E52D77',
        '796C8B7AE79BFCEEDC30C6217567CAFF'
      ],
    ));
    inlineAd = BannerAd(
      size: AdSize.banner,
      request: request,
      adUnitId: 'ca-app-pub-9099266456341997/1159426392',
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          inLineAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('Ad Failed to load ${error.message}');
      }),
    );
    inlineAd.load();
  }

  @override
  void initState() {
    loadInlineBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SoccerApi().getFixtures(apiLink),
        //Here we will call our getFixtures method,
        builder: (context, snapshot) {
          //the future builder is very interesting to use when you work with api
          if (snapshot.hasData) {
            var dataLength = (snapshot.data).length;
            print("Total Data => $dataLength");
            return headToHeadBody(snapshot.data, context);
          } else {
            return loadingIndicator();
          }
        }, // here we will built the app layout
      ),
    );
  }

  Widget headToHeadBody(List<FixturesData> allMatches, BuildContext context) {
    ScrollController listScrollController = ScrollController();
    /*** To add all the matches on the above list widget ***/
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //appBar(allMatches, context),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: allMatches.isNotEmpty
                    ? DraggableScrollbar.arrows(
                  alwaysVisibleScrollThumb: true,
                  controller: listScrollController,
                  child: ListView.separated(
                    controller: listScrollController,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: allMatches.length,
                    itemBuilder: (context, index) {
                      // Sorting the matches by timestamp
                      allMatches.sort((a, b) => a.fixture.timestamp
                          .compareTo(b.fixture.timestamp));
                      if (inLineAdLoaded && index == 0) {
                        return Column(
                          children: [
                            headToHeadTile(allMatches[index], context),
                            Container(
                              child: AdWidget(ad: inlineAd),
                              width: inlineAd.size.width.toDouble(),
                              height: inlineAd.size.height.toDouble(),
                              alignment: Alignment.bottomCenter,
                            ),
                          ],
                        );
                      } else {
                        return headToHeadTile(allMatches[index], context);
                      }
                    },
                    separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1,
                          color: Color(0xFF00BFFF),
                        );
                      },
                  ),
                )
                    : LottieBuilder.network(
                    'https://assets7.lottiefiles.com/packages/lf20_suhe7qtm.json'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



final DateFormat formatterDateTime = DateFormat('EEE HH:mm dd/MM/yyyy');

/// Head to Head matches between two teams
Widget headToHeadTile(FixturesData match, BuildContext context) {
  /* here you call some data from the api to print them */
  var round = match.league.round;
  var homeGoal = match.goal.home;
  var awayGoal = match.goal.away;
  var timestamp = match.fixture.timestamp;
  var elapsedTime = match.fixture.status.elapsedTime;
  var shortTime = match.fixture.status.short;
  var longTime = match.fixture.status.long;
  String referee = match.fixture.referee;
  String stadium = match.fixture.venue.name;
  //Converting the Timestamp into Date and Time
  final DateTime matchTimestamp =
  DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final String matchDateTime = formatterDateTime.format(matchTimestamp);
  stadium ??= 'Not Available';
  referee ??= 'Not Available';
  elapsedTime ??= 0;
  homeGoal ??= 0;
  awayGoal ??= 0;
  String score, time;
  if (match.home.name == 'Omonia Nicosia') {
    match.home.logoUrl =
    'https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/AC_Omonia_logo.svg/1200px-AC_Omonia_logo.svg.png';
  } else if (match.away.name == 'Omonia Nicosia') {
    match.away.logoUrl =
    'https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/AC_Omonia_logo.svg/1200px-AC_Omonia_logo.svg.png';
  }
  if (longTime == "Match Finished" || shortTime == "HT") {
    time = shortTime;
    score = "$homeGoal - $awayGoal";
  } else if (elapsedTime > 0 && longTime != "Match Finished") {
    time = "$elapsedTime'";
    score = "$homeGoal - $awayGoal";
  } else {
    time = shortTime;
    score = matchDateTime;
  }
  return GestureDetector(
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchFixture(
            time: time,
            score: score,
            homeTeam: match.home.name,
            awayTeam: match.away.name,
            homeLogo: match.home.logoUrl,
            awayLogo: match.away.logoUrl,
            fixtureId: match.fixture.id,
            homeId: match.home.id,
            awayId: match.away.id,
            round: round,
            kickOff: matchDateTime,
            referee: referee,
            stadium: stadium,
          ),
        ),
      ),
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        //color: const Color(0xFF44484A),
        //background color of the items in the list view
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            //Row 1 To display teams and score
            children: [
              Expanded(
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  match.home.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ), //Set the name of the home team
              ),
              Image.network(
                match.home.logoUrl,
                width: 30.0,
              ), //Set the logo of the home team
              Expanded(
                child: Text(
                  score,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ), //Set the score and the time of the game
              ),
              Image.network(
                match.away.logoUrl,
                width: 30.0,
              ), //Set the logo of the away team
              Expanded(
                child: Text(
                  match.away.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
 ***/