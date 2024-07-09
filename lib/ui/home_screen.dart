import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../route/route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String city = "";
  Map? data;

  @override
  void initState() {
    super.initState();

    var cityName = [
      "Mumbai",
      "Delhi",
      "Bhiwani",
      "Chennai",
      "Chandigarh",
      "Loharu"
    ];
    final _random = Random();
    city = cityName[_random.nextInt(cityName.length)];

    Future.delayed(Duration.zero, () {
      data = ModalRoute.of(context)?.settings.arguments as Map?;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    String temp = data!["temp_Value"]?.toString() ?? "NA";
    String air = data!["air_Value"]?.toString() ?? "NA";
    if (temp != "NA" && temp.length > 4) {
      temp = temp.substring(0, 4);
      air = air.substring(0, 4);
    }

    String icon = data!["icon_Value"]?.toString() ?? "";
    String hum = data!["hum_Value"]?.toString() ?? "NA";
    String des = data!["des_Value"]?.toString() ?? "NA";
    String main = data!["main_Value"]?.toString() ?? "NA";
    String getCity = data!["city_Value"]?.toString() ?? "NA";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue[800]!,
                      Colors.blue[300]!,
                    ])),
            child: Column(
              children: <Widget>[
                Container(
                  //Search Container
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(' ', '') == '') {
                              print("Blank Search");
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, Routes.LOADING_ACTIVITY, arguments: {
                                "searchText": searchController.text
                              });
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: const Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ))),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city ...",
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (value == '') {
                              print("Please Enter Text To Search");
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, Routes.LOADING_ACTIVITY, arguments: {
                                "searchText": searchController.text
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //Cloud Container
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            if (icon.isNotEmpty)
                              Image.network(
                                  "http://openweathermap.org/img/wn/$icon@2x.png"),
                            Column(
                              children: [
                                Text(
                                  "$des ",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "in $getCity",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //Temp Container
                        height: 270,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(4, 4, 20, 20),
                              child: Icon(
                              WeatherIcons.thermometer,
                              size: 40,
                               ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " $temp",
                                  style: const TextStyle(fontSize: 70),
                                ),
                                const Text(
                                  "C",
                                  style: TextStyle(fontSize: 32),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        //Humidity Container
                        height: 180,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    WeatherIcons.day_windy,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "$air ",
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "km/hr",
                              style: TextStyle(fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //Air Speed Container
                        height: 180,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      WeatherIcons.thermometer,
                                      size: 40,
                                    ),
                                  ),
                                ]
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "$hum ",
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Percent",
                              style: TextStyle(fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
