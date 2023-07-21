import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MacAddress extends StatefulWidget {
  const MacAddress({super.key});

  @override
  State<MacAddress> createState() => _MacAddressState();
}

class _MacAddressState extends State<MacAddress> {
  static const platform =
      MethodChannel('com.example.attendance_by_biometrics/mac');
  String batteryLevel = 'Unknown battery level.';
  var androidIdPlugin = const AndroidId();

  Future<void> getBatteryLevel() async {
    await androidIdPlugin.getId().then((value) {
      print(value);
    });

    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((e) {
      setState(() {
        batteryLevel = "Failed to get battery level: '${e.messag}'.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
