import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class SalmonRun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new FutureBuilder<Map>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var salmonRunData =
              snapshot.data['salmon_run']['detailed'][0];
              return new Column(
                children: <Widget>[
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/salmon_run.png'),
                          title: new Text('Salmon Run',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: new Text(salmonRunData['stage']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing:
                          new Text(timeLeft(salmonRunData['time_end'])),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new Image.network(
                                      'https://app.splatoon2.nintendo.net' +
                                          salmonRunData['stage']['image'])),
                              new Padding(padding: new EdgeInsets.all(2.0)),
                            ]),
                        new Row(
                          // Put all weapons in here
                        )
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(6.0)),

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
