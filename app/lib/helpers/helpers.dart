import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Map> fetchData(toFetch) async {
  final response = await http.get(
      'http://splat2.ink/api/' + toFetch); //replace url with base url + toFetch
  final responseJson = json.decode(response.body);

  return responseJson;
}

timeLeft(endTime) {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  endTime = endTime * 1000;
  var remainingMin = (endTime - currentTime) / 1000 / 60;
  return minToHours(remainingMin);
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

const baseUrl = 'http://splat2.ink';
