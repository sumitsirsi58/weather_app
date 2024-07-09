import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {
  String location;
  String temp = "";
  String humidity = "";
  String airSpeed = "";
  String description = "";
  String main = "";
  String icon = "";

  Worker({required this.location});

  Future<void> getData() async {
    String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=YOUR_API_KEY";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        temp = data['main']['temp'].toString();
        humidity = data['main']['humidity'].toString();
        airSpeed = data['wind']['speed'].toString();
        description = data['weather'][0]['description'];
        main = data['weather'][0]['main'];
        icon = data['weather'][0]['icon'];
      } else {
        print("Failed to load weather data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
