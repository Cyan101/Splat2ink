import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class GameModes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new FutureBuilder<Map>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var regularData =
                  snapshot.data['schedules']['regular'][0.toString()];
              var rankedData =
                  snapshot.data['schedules']['ranked'][0.toString()];
              var leagueData =
                  snapshot.data['schedules']['league'][0.toString()];
              return new Column(
                children: <Widget>[
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/regular.png'),
                          title: new Text(
                              'Regular Mode - ' + regularData['game_type'],
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text(
                              regularData['stage_1']['name'] +
                                  ' & ' +
                                  regularData['stage_2']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing:
                              new Text(timeLeft(regularData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          regularData['stage_1']['image'])),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          regularData['stage_2']['image']))
                            ])
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(6.0)),
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/ranked.png'),
                          title: new Text(
                              'Ranked Mode - ' + rankedData['game_type'],
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text(
                              rankedData['stage_1']['name'] +
                                  ' & ' +
                                  rankedData['stage_2']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing:
                              new Text(timeLeft(rankedData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          rankedData['stage_1']['image'])),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          rankedData['stage_2']['image']))
                            ])
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(6.0)),
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/league.png'),
                          title: new Text(
                              'League Mode - ' + leagueData['game_type'],
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text(
                              leagueData['stage_1']['name'] +
                                  ' & ' +
                                  leagueData['stage_2']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing:
                              new Text(timeLeft(leagueData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          leagueData['stage_1']['image'])),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          leagueData['stage_2']['image']))
                            ])
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
