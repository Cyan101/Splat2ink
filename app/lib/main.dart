import 'package:flutter/material.dart';

import 'pages/game_modes.dart';
import 'pages/salmon_run.dart';



void main() => runApp(new AppMenu());

class AppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(icon: new Icon(Icons.format_paint)),
                new Tab(icon: new Image.asset('res/icons/salmon_run_alt.png')),
                new Tab(icon: new Icon(Icons.shop)),
              ],
            ),
            title: new Text('Splat2ink'),
          ),
          body: new TabBarView(
            children: [
              new GameModes(),
              new SalmonRun(),
              new Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
