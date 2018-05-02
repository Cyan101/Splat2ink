import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart'; // WARNING: Cached Images package can be bugged

class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new FutureBuilder<Map>(
          future: fetchData('store'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['store'];
              return new Column(
                children: storeItemCreator(data)
              );

            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: new Center(child: CircularProgressIndicator()));
          },
        ),
      ],
    );
  }
}
