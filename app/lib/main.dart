import 'package:flutter/material.dart';

import 'helpers/helpers.dart';
import 'helpers/info_dialog.dart';
import 'pages/game_modes.dart';
import 'pages/salmon_run.dart';
import 'pages/store.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Splat2ink',
      color: Color.fromRGBO(29, 85, 211, 1.0),
      home: new AppMenu()));
}

class AppMenu extends StatefulWidget {
  @override
  createState() => new AppMenuState();
}

class AppMenuState extends State<AppMenu> {
//class AppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.book),
                onPressed: () {
                  routeBuilder(
                      context: context,
                      child: LicensePage(
                          applicationName: 'Splat2ink',
                          applicationVersion: 'v' + appVersion));
                }),
            new IconButton(
                icon: new Icon(Icons.info),
                onPressed: () {
                  routeBuilder(context: context, child: InfoDialog());
                })
          ],
          bottom: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.format_paint)),
              new Tab(icon: new Icon(Icons.local_atm)),
              new Tab(icon: new Icon(Icons.shop)),
            ],
          ),
          title: new Text('Splat2ink'),
        ),
        body: new TabBarView(
          children: [
            new GameModes(),
            new SalmonRun(),
            new Store(),
          ],
        ),
      ),
    );
  }
}
