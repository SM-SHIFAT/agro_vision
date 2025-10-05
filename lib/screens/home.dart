import 'package:agro_vision/screens/plant_health/plant_health_screen.dart';
import 'package:flutter/material.dart';

import 'natural_events_screen.dart';
import '../widget/weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: const Text(
                        'AGRO VISION',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          height: 1.0,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Expanded(flex: 5, child: WeatherWidget()),
                  ],
                ),
                SizedBox(height: 20),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(38, 255, 255, 255),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Rounded corners (radius 10)
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WebViewPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Natural Events',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold, // Makes the text bold
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ), // Text is centered by default
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Rounded corners (radius 10)
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlantHealthScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Plant Health',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold, // Makes the text bold
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ), // Text is centered by default
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
