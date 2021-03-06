import 'dart:async';

import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> get() async {
    var url = "https://loripsum.net/api";
    var response = await http.get(url);
    String text = response.body;
    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");
    return text;
  }
}

class ApiBloc {
  final StreamController<String> _streamController = StreamController<String>();
  static String textCache;
  Stream<String> get stream => _streamController.stream;

  fetch() async {

    String text = textCache ?? await LoripsumApi.get();
    textCache = text;
    _streamController.add(text);
  }

  void diposed() {
    _streamController.close();
  }
}
