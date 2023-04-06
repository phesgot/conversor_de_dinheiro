import 'dart:convert';
import 'package:http/http.dart' as http;

const String uri = 'https://api.hgbrasil.com/finance?key=59d2b077';

class finance {
  Future<Map> getData() async {
    final response = await http.get(Uri.parse(uri));
    return jsonDecode(response.body);
  }
}
