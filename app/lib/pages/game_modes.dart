import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

//class GameModes extends StatefulWidget {
//  @override
//  createState() => new GameModesState();
//}
//class GameModesState extends State<GameModes> {

class GameModes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new FutureBuilder<Map>(
          future: fetchData('schedules'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var regularData = snapshot.data['regular'][0];
              var rankedData = snapshot.data['ranked'][0];
              var leagueData = snapshot.data['league'][0];
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
                          trailing: new Text(timeLeft(regularData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: imageRowBuild(
                                regularData['stage_1']['image'],
                                regularData['stage_2']['image']))
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
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
                          trailing: new Text(timeLeft(rankedData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: imageRowBuild(
                                rankedData['stage_1']['image'],
                                rankedData['stage_2']['image']))
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
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
                          trailing: new Text(timeLeft(leagueData['time_end'])),
                        ),
                        new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: imageRowBuild(
                                leagueData['stage_1']['image'],
                                leagueData['stage_2']['image']))
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Padding(padding: EdgeInsets.only(top: 15.0),child: new Center(child: CircularProgressIndicator()));
          },
        ),
      ],
    );
  }
}
