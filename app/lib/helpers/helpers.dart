import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://app.splatoon2.nintendo.net';
const appVersion = '1.1';

Future<Map> fetchData(toFetch) async {
  var reqHeaders = {'User-Agent': 'Splat2ink App'};
  if (Globals.httpCache.containsKey(toFetch)) {
    print('Data already saved');
    return Globals.httpCache[toFetch];
  } else {
    final response =
        await http.get('http://splat2.ink/api/' + toFetch, headers: reqHeaders);
    final responseJson = json.decode(response.body);
    Globals.httpCache[toFetch] = responseJson;
    print('Live data saved and grabbed');
    return responseJson;
  }
}

imageRowBuild(image1, image2) {
  return <Widget>[
    new Flexible(
        child: new CachedNetworkImage(
            placeholder: new Center(child: CircularProgressIndicator()),
            imageUrl: baseUrl + image1)),
    new Padding(padding: new EdgeInsets.all(2.0)),
    new Flexible(
        child: new CachedNetworkImage(
            placeholder: new Center(child: CircularProgressIndicator()),
            imageUrl: baseUrl + image2))
  ];
}

minToHours(timeMin) {
  var timeHours = 0;
  while (timeMin >= 60) {
    timeHours++;
    timeMin = timeMin - 60;
  }
  return timeHours.toStringAsFixed(0) +
      'h ' +
      timeMin.toStringAsFixed(0) +
      'min';
}

salmonRunOutCheck(timeStart, timeEnd) {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  timeStart = timeStart * 1000;
  timeEnd = timeEnd * 1000;
  if (timeStart > currentTime) {
    var minTilRelease = (timeStart - currentTime) / 1000 / 60;
    return "Upcoming In: " + minToHours(minTilRelease.round());
  } else {
    var remainingMin = timeEnd / 1000;
    return timeLeft(remainingMin.round());
  }
}

storeItemCreator(storeData) {
  var times = storeData.length;
  var listOfCards = <Widget>[];
  for (var i = 0; i < times; i++) {
    var data = storeData[i];
    listOfCards.add(new Card(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 18.0)),
              new Text(data['name'],
                  style:
                      new TextStyle(fontSize: 25.0, fontFamily: 'Quicksand')),
              new CachedNetworkImage(imageUrl: baseUrl + data['thumbnail']),
              new Row(
                children: <Widget>[
                  new Image.asset(
                    'res/icons/coin.png',
                    height: 38.0,
                  ),
                  new Text(' ${data['price']}',
                      style: new TextStyle(
                          fontSize: 24.0, fontFamily: 'Quicksand')),
                ],
              ),
              new Padding(padding: EdgeInsets.only(bottom: 15.0)),
            ],
          ),
          new Column(children: <Widget>[
            new CachedNetworkImage(imageUrl: baseUrl + data['brand']['image']),
            new CachedNetworkImage(imageUrl: baseUrl + data['skill']['image']),
            new Row(
              children: <Widget>[
                new Image.asset(
                  'res/icons/star.png',
                  height: 50.0,
                ),
                new Text('x${data['stars']}',
                    style: new TextStyle(fontSize: 22.0, height: 1.4))
              ],
            )
          ])
        ],
      ),
    ));
  }

  return listOfCards;
}

timeLeft(endTime) {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  endTime = endTime * 1000;
  var remainingMin = (endTime - currentTime) / 1000 / 60;
  return minToHours(remainingMin);
}

weaponCardBuild(weaponArray) {
  var cardList = <Widget>[];
  for (var i = 0; i < 4; i++) {
    cardList.add(new Expanded(
      child: new Card(
          color: Colors.blueGrey,
          child: new CachedNetworkImage(
              placeholder: new Center(child: CircularProgressIndicator()),
              imageUrl: baseUrl + weaponArray[i]['thumbnail'])),
    ));
  }
  return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: cardList);
}

void routeBuilder({BuildContext context, Widget child}) {
  showDialog(context: context, builder: (BuildContext context) => child);
}

OpenUrl(link) async {
  var url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//starCreator(amount) {
//  var starList = <Widget>[];
//  for (var i = 0; i < amount; i++) {
//    starList.add(
//      new Icon(Icons.star)
//    );
//  }
//  return starList;
//}

class Globals {
  static var httpCache = {};
}
