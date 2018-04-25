import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map> fetchData() async {
  final response =
  await http.get('https://pastebin.com/raw/vMfccA3Z');
  final responseJson = json.decode(response.body);

  return responseJson;
}


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Splat2Ink',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Game Modes: '),
        ),
        body: new ListView(
          children: <Widget>[
            new FutureBuilder<Map>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var regularData = snapshot.data['schedules']['regular'];
                  var rankedData = snapshot.data['schedules']['ranked'];
                  var leagueData = snapshot.data['schedules']['league'];
                  return new Column(
                    children: <Widget>[
                  new Card(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        leading: new Image.asset('res/icons/regular.png'),
                        title: new Text('Regular Mode - ' + regularData[0.toString()]['game_type']),
                        subtitle: new Text(
                            regularData[0.toString()]['stage_1']['name'] + ' & ' + regularData[1.toString()]['stage_2']['name']),
                        trailing: new Text('Xh XXmin'),
                      ),
                      new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Flexible(
                                child: new Image.network(
                                    'https://app.splatoon2.nintendo.net' +
                                        regularData[0.toString()]['stage_1']['image'])
                            ),
                            new Padding(padding: new EdgeInsets.all(2.0)),
                            new Flexible(
                                child: new Image.network(
                                    'https://app.splatoon2.nintendo.net' +
                                        regularData[1.toString()]['stage_2']['image'])
                            )
                          ]
                      )
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
                          title: new Text('Ranked Mode - ' + rankedData[0.toString()]['game_type']),
                          subtitle: new Text(
                              rankedData[0.toString()]['stage_1']['name'] + ' & ' + rankedData[1.toString()]['stage_2']['name']),
                          trailing: new Text('Xh XXmin'),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          rankedData[0.toString()]['stage_1']['image'])
                              ),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          rankedData[1.toString()]['stage_2']['image'])
                              )
                            ]
                        )
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
                          title: new Text('League Mode - ' + leagueData[0.toString()]['game_type']),
                          subtitle: new Text(
                              leagueData[0.toString()]['stage_1']['name'] + ' & ' + leagueData[1.toString()]['stage_2']['name']),
                          trailing: new Text('Xh XXmin'),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          leagueData[0.toString()]['stage_1']['image'])
                              ),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          leagueData[1.toString()]['stage_2']['image'])
                              )
                            ]
                        )
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
        ),
      ),
    );
  }
}
