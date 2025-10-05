import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 132, 191, 135),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => WeatherProvider())],
        child: const HomeScreen(),
      ),
    );
  }
}
