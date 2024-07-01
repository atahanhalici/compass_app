import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compass App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Compass App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? heading = 0;
  double? maniHeading = 0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
        if (heading! < 0) {
          maniHeading = heading! + 360;
        } else {
          maniHeading = heading;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            /* heading!.ceil() >= -23 &&
                    heading!.ceil() <
                        23 /* ||
                    heading!.ceil() >= 338*/
                ? "North"
                : heading!.ceil() >= 23 && heading!.ceil() < 68
                    ? "Northeast"
                    : heading!.ceil() >= 68 && heading!.ceil() < 113
                        ? "East"
                        : heading!.ceil() >= 113 && heading!.ceil() < 158
                            ? "Southeast"
                            : heading!.ceil() >= 158 && heading!.ceil() < -158
                                ? "South"
                                : heading!.ceil() >= -158 &&
                                        heading!.ceil() < -113
                                    ? "Southwest"
                                    : heading!.ceil() >= -113 &&
                                            heading!.ceil() < -68
                                        ? "West"
                                        : heading!.ceil() >= -68 &&
                                                heading!.ceil() < -23
                                            ? "Nortwest"
                                            : "Unknown",
*/
            (maniHeading!.ceil() >= 0 && maniHeading!.ceil() < 22.5 ||
                    maniHeading!.ceil() >= 337.5)
                ? "North"
                : (maniHeading!.ceil() >= 22.5 && maniHeading!.ceil() < 67.5)
                    ? "Northeast"
                    : (maniHeading!.ceil() >= 67.5 &&
                            maniHeading!.ceil() < 112.5)
                        ? "East"
                        : (maniHeading!.ceil() >= 112.5 &&
                                maniHeading!.ceil() < 157.5)
                            ? "Southeast"
                            : (maniHeading!.ceil() >= 157.5 &&
                                    maniHeading!.ceil() < 202.5)
                                ? "South"
                                : (maniHeading!.ceil() >= 202.5 &&
                                        maniHeading!.ceil() < 247.5)
                                    ? "Southwest"
                                    : (maniHeading!.ceil() >= 247.5 &&
                                            maniHeading!.ceil() < 292.5)
                                        ? "West"
                                        : (maniHeading!.ceil() >= 292.5 &&
                                                maniHeading!.ceil() < 337.5)
                                            ? "Northwest"
                                            : "Unknown",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            /*  heading!.ceil() < 0
                ? (heading!.ceil() + 360).toString()
                : (heading!.ceil()).toString(),*/
            maniHeading!.ceil().toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                    angle: ((heading ?? 0) * (pi / 180) * -1),
                    child: Image.asset("assets/cadrant.png")),
                Transform.rotate(
                  angle: ((heading ?? 0) * (pi / 180) * -1),
                  child: Image.asset(
                    "assets/compass.png",
                    scale: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          const Text(
            "© 2024 fivehub.com",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
