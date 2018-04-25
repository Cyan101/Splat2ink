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
          title: new Text('Splat2Ink'),
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FutureBuilder<Map>(
              future: fetchData(),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.hasData) {
                  var regular_data = snapshot.data['schedules']['regular'];
                  return new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/regular.png'),
                          title: new Text('Regular Mode'),
                          subtitle: new Text(
                              regular_data[0.toString()]['stage_1']['name'] + ' & ' + regular_data[1.toString()]['stage_2']['name']),
                          trailing: new Text('Xh XXmin'),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          regular_data[0.toString()]['stage_1']['image'])
                              ),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          regular_data[1.toString()]['stage_2']['image'])
                              )
                            ]
                        )
                      ],
                    ),
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
