import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mitra/models/weather_model.dart';
import 'package:krishi_mitra/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String sunImage = "assets/lottie/sun.json";
  String sunnyImage = "assets/lottie/sunny.json";
  String coldImage = "assets/lottie/cold.json";

  final _weatherService = WeatherService("b7d637612f80ad43ab6237152bf8d0ae");
  WeatherModel? _weathermodel;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weathermodel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(state.toString()),
        // Text(_weathermodel?.cityName ?? "loading city.."),
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 130,
          decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.circular(90)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 70,
                  child: _weathermodel?.temperature.round() != null
                      ? _weathermodel!.temperature.round() > 30
                          ? SizedBox(
                              width: 70,
                              child: Lottie.asset(sunImage),
                            )
                          : _weathermodel!.temperature.round() > 20
                              ? SizedBox(
                                  width: 70,
                                  child: Lottie.asset(sunnyImage),
                                )
                              : SizedBox(
                                  width: 70,
                                  child: Lottie.asset(coldImage),
                                )
                      : Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Lottie.asset("assets/icons/loading_.json")
                        ,),
                      ),),
              const SizedBox(
                width: 10,
              ),
              Text(
                "tempreture".tr,
                style: TextStyle(
                  color: Colors.green.shade200,
                  fontSize: 17,
                ),
              ),
              Text(
                (_weathermodel?.temperature.round() == null)
                    ? "loading.."
                    : "${_weathermodel?.temperature.round()}°C",
                style: TextStyle(
                  color: Colors.green.shade200,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
