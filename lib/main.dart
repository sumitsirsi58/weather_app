import 'package:flutter/material.dart';
import 'package:weather_app/ui/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _requestLocationPermission();
  runApp(MyApp());
}

Future<void> _requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isDenied || status.isPermanentlyDenied) {
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
