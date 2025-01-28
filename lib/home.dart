import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/hourly_card.dart';
import 'package:weather_app/widgets/item_information.dart';
import 'package:weather_app/widgets/key.dart';
import 'package:weather_app/widgets/weather_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
late Future<Map<String,dynamic>> weather;

  Future<Map<String, dynamic>> getData() async {
    try {
      String CityName = 'London';
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$CityName&APPID=$ApiKey"));
      final data = jsonDecode(response.body);
      if (data['cod'] != "200") {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    weather = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  weather = getData();
                });
              },
              icon: Icon(Icons.refresh)),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
          future:  weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            final data = snapshot.data!;
            final currentTemp = data['list'][0]['main']['temp'];
            final currentSky = data['list'][0]['weather'][0]['main'];
            final currentHumidity = data['list'][0]['main']['humidity'];
            final currentWindSpeed = data['list'][0]['wind']['speed'];
            final currentPressure = data['list'][0]['main']['pressure'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //weather card
                  WeatherCard(
                    temp: '$currentTemp K',
                    icon: currentSky == 'Clouds' || currentSky == 'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                    label: '$currentSky',
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //weather foreCast
                  Text(
                    'Hourly ForeCast',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 1; i <= 5; i++)
                          HourlyCard(
                              time: DateFormat.j().format(
                                  DateTime.parse(data['list'][i]['dt_txt'])),
                              icon: data['list'][i]['weather'][0]['main'] ==
                                          'Clouds' ||
                                      data['list'][i]['weather'][0]['main'] ==
                                          'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              temperature:
                                  data['list'][i]['main']['temp'].toString()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //additional Info
                  Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemInformation(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$currentHumidity',
                      ),
                      ItemInformation(
                        icon: Icons.wind_power,
                        label: 'Wind speed',
                        value: '$currentWindSpeed',
                      ),
                      ItemInformation(
                        icon: Icons.air,
                        label: 'Pressure',
                        value: '$currentPressure',
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
