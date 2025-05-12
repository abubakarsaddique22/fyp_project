import 'dart:convert';
import 'package:http/http.dart' as http;
import 'response.dart';

class modelapi {
  Future<String> predictiondata(final object) async {
    final url = Uri.http("127.0.0.1:8000",'/predict');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(object));
      if(response.statusCode==200){

        final data=jsonDecode(response.body);
        return data["prediction_range"];
      }

    return "something went wrong";
  }

   

Future<List<Property>> recommanddata(final object) async {
  final url = Uri.http("127.0.0.1:8000", "/recommend");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(object),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Property.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch recommendations: ${response.statusCode}");
  }
}

}
