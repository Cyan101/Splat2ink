import 'package:flutter/material.dart';

import 'pages/game_modes.dart';
import 'pages/salmon_run.dart';
import 'pages/store.dart';

void main() => runApp(new AppMenu());



//class AppMenu extends StatefulWidget {
//  @override
//  createState() => new AppMenuState();
//}
//class AppMenuState extends State<AppMenu> {

class AppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Splat2ink',
      color: Color.fromRGBO(29, 85, 211, 1.0),
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
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
      ),
    );
  }
}
