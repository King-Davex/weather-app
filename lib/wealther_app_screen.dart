import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/hourly_forcast_item_card.dart';
import 'package:weather_app/secret.dart';
import 'package:weather_app/temperature.dart';


class WeathwerAPPScreen extends StatefulWidget {
  const WeathwerAPPScreen({super.key});

  @override
  State<WeathwerAPPScreen> createState() => _WeathwerAPPScreenState();
}

class _WeathwerAPPScreenState extends State<WeathwerAPPScreen> {
  double temp = 0;
  String city = 'London';
  Future<Map<String, dynamic>> weatherForecast() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$secretKey',
        ),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherForecast(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (asyncSnapshot.hasError) {
          return Text(asyncSnapshot.error.toString());
        }

        final data = asyncSnapshot.data!;
        temp = data['list'][0]['main']['temp'];
        final cloudDiscription = data['list'][0]['weather'][0]['main'];
        final cloudIcon = data['list'][0]['weather'][0]['main'];
        final humidity = data['list'][0]['main']['humidity'];
        final windSpeed = data['list'][0]['wind']['speed'];
        final presure = data['list'][0]['main']['pressure'];

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Weather App',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [IconButton(onPressed: () {
              setState(() {
                
              });
            }, icon: Icon(Icons.refresh))],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                temp.toString(),
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),
                              Icon(
                                cloudIcon == 'Clouds' || cloudIcon == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 45,
                              ),

                              const SizedBox(height: 10),
                              Text(cloudDiscription),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Weather Forcast',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForcast = data['list'][index + 1];
                      final hourlyTimeForcast = hourlyForcast['dt_txt'];
                      final hourlyTemp = hourlyForcast['main']['temp'];
                      final horlyCloud = hourlyForcast['weather'][0]['main'];
                      final time = DateTime.parse(hourlyTimeForcast);
                      return HourlyForcastItemCard(
                        time: DateFormat.Hm().format(time),
                        icon: horlyCloud == 'Clouds' || horlyCloud == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        temp: hourlyTemp.toString(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Temperature(
                      icon: Icons.water_drop,
                      temp: 'Humidity',
                      number: humidity.toString(),
                    ),
                    Temperature(
                      icon: Icons.air,
                      temp: 'Wind Speed',
                      number: windSpeed.toString(),
                    ),
                    Temperature(
                      icon: Icons.beach_access,
                      temp: 'pressure',
                      number: presure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
