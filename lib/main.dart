import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimerPage(),
    );
  }
}

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: const Center(
        child: TimerWidget(),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;

  late Timer _timer;

  void _timerSetup() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        milliseconds++;
        if (milliseconds == 1000) {
          milliseconds = 0;
          seconds++;
          if (seconds == 60) {
            seconds = 0;
            minutes++;
            if (minutes == 60) {
              minutes = 0;
              hours++;
            }
          }
        }
      });
    });
  }

  void pauseTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    _timerSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$hours:$minutes:$seconds:$milliseconds'),
        MaterialButton(onPressed: pauseTimer, child: const Text('Pause')),
        MaterialButton(onPressed: pauseTimer, child: const Text('play')),
      ],
    );
  }
}
