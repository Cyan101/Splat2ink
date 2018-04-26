import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SalmonRun extends StatefulWidget {
  @override
  createState() => new SalmonRunState();
}

class SalmonRunState extends State<SalmonRun> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new FutureBuilder<Map>(
          future: fetchData('salmon_run'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var salmonRunData = snapshot.data['detailed'][0];
              var salmonRunData2 = snapshot.data['detailed'][1];
              return new Column(
                children: <Widget>[
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/salmon_run.png'),
                          title: new Text('Salmon Run',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text(salmonRunData['stage']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing: new Text(salmonRunOutCheck(
                              salmonRunData['time_start'],
                              salmonRunData['time_end'])),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new CachedNetworkImage(
                                      placeholder:
                                          new CircularProgressIndicator(),
                                      imageUrl: baseUrl +
                                          salmonRunData['stage']['image'])),
                            ]),
                        weaponCardBuild(salmonRunData['weapons']),
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Image.asset('res/icons/salmon_run.png'),
                          title: new Text('Salmon Run',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text(salmonRunData2['stage']['name'],
                              style: new TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 15.0)),
                          trailing: new Text(salmonRunOutCheck(
                              salmonRunData2['time_start'],
                              salmonRunData2['time_end'])),
                        ),
                        new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new CachedNetworkImage(
                                      placeholder:
                                          new CircularProgressIndicator(),
                                      imageUrl: baseUrl +
                                          salmonRunData2['stage']['image'])),
                            ]),
                        weaponCardBuild(salmonRunData2['weapons']),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
