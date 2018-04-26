import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class Countdown extends AnimatedWidget {
  Countdown({ Key key, this.animation }) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 150.0),
    );
  }
}

class Test extends StatefulWidget {
  @override
  createState() => new TestState();
}

class TestState extends State<Test> with TickerProviderStateMixin  {
  AnimationController _controller;
  static const int kStartValue = 100;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
      new Card(child: new Countdown(
        animation: new StepTween(
          begin: kStartValue,
          end: 5).animate(_controller),
        ),
      )
    ]
    );
  }
}
