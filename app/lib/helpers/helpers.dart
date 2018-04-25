import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<Map> fetchData() async {
  final response = await http.get('https://pastebin.com/raw/vMfccA3Z'); //replace url with base url + toFetch
  final responseJson = json.decode(response.body);

  return responseJson;
}

timeLeft(endTime) {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  endTime = endTime * 1000;
  var remainingMin = (endTime - currentTime) / 1000 / 60;
  var remainingHours = 0;
  while (remainingMin >= 60) {
    remainingHours++;
    remainingMin = remainingMin - 60;
  }
  return remainingHours.toStringAsFixed(0) + 'h ' + remainingMin.toStringAsFixed(0) + 'min';
}