import 'package:flutter/material.dart';
import 'helpers.dart';

class InfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Row(
        children: <Widget>[
          new Image.asset('res/icons/squid.png', height: 100.0),
          new Padding(padding: new EdgeInsets.only(left: 50.0)),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('Splat2ink'),
              new Text('Version - ${appVersion}', style: new TextStyle(fontSize: 15.0,),)
            ],
          )
        ],
      ),
      content: new Text(
          'Disclaimer: This app is NOT affiliated with Nintendo. All product names, logos, and brands are property of their respective owners.',
          style: new TextStyle(fontSize: 14.0)),
      actions: <Widget>[
        new FlatButton(onPressed: () {
          OpenUrl('https://paypal.me/crazyandroid101');
        }, child: new Text('Donate')),
        new FlatButton(onPressed: () {
          OpenUrl('https://github.com/Cyan101/Splat2ink');
        }, child: new Text('Source Code')),
      ],
    );
  }
}