import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/route/route.dart';

import '../worker/worker.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingActivityState createState() => _LoadingActivityState();
}

class _LoadingActivityState extends State<LoadingScreen> {
  String temp = "";
  String humidity = "";
  String airSpeed = "";
  String description = "";
  String main = "";
  String location = "";
  String icon = "";
  String city = "Bhiwani";

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    setState(() {
      temp = instance.temp;
      humidity = instance.humidity;
      airSpeed = instance.airSpeed;
      description = instance.description;
      main = instance.main;
      icon = instance.icon;
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.HOME_ACTIVITY, arguments: {
        "temp_Value": temp,
        "hum_Value": humidity,
        "air_Value": airSpeed,
        "des_Value": description,
        "main_Value": main,
        "icon_Value": icon,
        "city_Value": city,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Map search = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
      if (search.isNotEmpty) {
        city = search["searchText"] ?? city;
      }
      startApp(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset("/images/download (2).png", height: 240, width: 240),
              const SizedBox(height: 16),
              const Text("Weather App",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              const SizedBox(height: 30),
              const SpinKitWave(
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[200],
    );
  }
}
