//import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'package:android_id/android_id.dart';
import 'package:attendance_by_biometrics/added_points.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'checking.dart';
import 'states.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class BiometricsCubit extends Cubit<BiometricsStates> {
  BiometricsCubit() : super(BiometricsInitStates());

  static BiometricsCubit get(context) => BlocProvider.of(context);
  //BIOMETRICS
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;
  String timeAndDate = "";

  setTimeAndDate() {
    DateTime whenCheckd = DateTime.now();
    timeAndDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(whenCheckd);
    emit(Authenticated());
  }

  Future<void> canCheck(context) async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      null;
      // Fluttertoast.showToast(
      //   backgroundColor: Colors.black,
      //   fontSize: 25,
      //   msg: "BIOMETRICS AVAILABLE",
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.CENTER,
      // );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.black,
        fontSize: 25,
        msg: "BIOMETRICS UNAVAILABLE",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      ).then((value) {
        SystemNavigator.pop();
      });
    }
  }

  Future<void> authenticate() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      try {
        _isAuthenticated = await auth.authenticate(
            localizedReason: 'Please authenticate to access your account',
            options: const AuthenticationOptions(
                biometricOnly: true, stickyAuth: true));
      } catch (e) {
        print(e);
      }
      if (_isAuthenticated) {
        // User  authenticate
        setTimeAndDate();
      } else {
        // User did not authenticate
      }
    } else {
      // Fingerprint authentication is not available on this device
      // You can show an error message or navigate back to the previous screen
    }
  }

  LocationPermission? permission;
  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        backgroundColor: Colors.black,
        fontSize: 15,
        msg: "Location services are disabled. Please enable the services",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          backgroundColor: Colors.black,
          fontSize: 15,
          msg: "Location permissions are denied",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        ).then((value) async {
          Future.delayed(const Duration(seconds: 2), () async {
            await Geolocator.openAppSettings();
            //await Geolocator.openLocationSettings();
          });
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        backgroundColor: Colors.black,
        fontSize: 15,
        msg:
            "Location permissions are permanently denied, we cannot request permissions.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      ).then((value) async {
        Future.delayed(const Duration(seconds: 2), () async {
          await Geolocator.openAppSettings();
          //await Geolocator.openLocationSettings();
        });
      });
      return false;
    }
    //permission granted
    return true;
  }

  void openMap(double latitude, double longitude) async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//37.422251,-122.084879
//31.927791,35.900282
//31.923888,35.905617 home
  List<Map<String, dynamic>>? point = [];
  addPoint({required String latAndLong, required String distance}) {
    latAndLong = latAndLongController.text;
    distance = distanceController.text;
    Map<String, dynamic> formData = {
      'latandlong': latAndLong,
      'distance': distance,
    };
    point!.add(formData);
    latAndLongController.clear();
    distanceController.clear();
  }

  double distanceInMeters = 0;
  List splitLatAndLong = [];

  Future<void> getMyLocation() async {
    splitLatAndLong = point![0]["latandlong"]!.split(',');
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    distanceInMeters = Geolocator.distanceBetween(latitude, longitude,
        double.parse(splitLatAndLong[0]), double.parse(splitLatAndLong[1]));
    debugPrint('Distance from user to destination: $distanceInMeters meters');
  }

  bool inRange = false;
  String? status;
  void startListening({required String latLong, required String distance}) {
    splitLatAndLong = latLong.split(',');
    debugPrint(splitLatAndLong.toString());
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
            locationSettings: AndroidSettings(
                accuracy: LocationAccuracy.best,
                intervalDuration: const Duration(seconds: 1)))
        .listen((Position position) {
      distanceInMeters = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          double.parse(splitLatAndLong[0]),
          double.parse(splitLatAndLong[1]));
      if (distanceInMeters <= int.parse(distance)) {
        debugPrint("BEFORE: $inRange");
        debugPrint("AFTER: $inRange");
        debugPrint(position.toString());
        debugPrint(distanceInMeters.toString());
        emit(EnterStates(inRange = true, status = "IN RANGE"));
      } else {
        emit(ExitStates(inRange = false, status = "OUT OF RANGE"));
      }
    });
  }

  int bottomBarIndx = 0;
  List<Widget> screens = [const CheckingScreen(), const AddedPoints()];
  void changeScreenIndex(int index) {
    bottomBarIndx = index;
    emit(AppChangeBottomNavBarState());
  }

  TextEditingController distanceController = TextEditingController();
  TextEditingController latAndLongController = TextEditingController();
  List<Map<String, dynamic>> dataList = [];
  late Future<Item> futureAlbum;
  String data = "hi";

  Future<void> fetchData() async {
    try {
      debugPrint("1111 is done");
      final response =
          await http.get(Uri.parse('http://192.168.1.22:5000/get'));
      debugPrint("2222 is done");
      if (response.statusCode == 200) {
        // Data retrieval successful
        final jsonData = json.decode(response.body);
        // Process and use the retrieved data as needed
        data = jsonData.toString();
        print(data);

        emit(AppChangeBottomNavBarState());
      } else {
        // Data retrieval failed
        print('Data retrieval failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred during data retrieval
      data = "did not work";
      emit(AppChangeBottomNavBarState());
      print('An error occurred during data retrieval: $error');
    }
  }

  Future<void> insertData() async {
    final url = Uri.parse(
        'http://192.168.1.22:5000/insert'); // Replace with your server's IP address and port
    try {
      final data = {
        'desc': latAndLongController
            .text, // Replace with the data you want to insert
      };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        // Data insertion successful
        print('Data insertion successful');
      } else {
        // Data insertion failed
        print('Data insertion failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred during the HTTP POST request
      print('An error occurred during data insertion: $error');
    }
  }

  String macAddress = "";
  var androidIdPlugin = const AndroidId();
  void mac() async {
    await androidIdPlugin.getId().then((value) {
      debugPrint("AndroidID: $value");
    });
    List<NetworkInterface> interfaces = await NetworkInterface.list();
    for (NetworkInterface interface in interfaces) {
      macAddress = interface.addresses.join(':');
      print(macAddress);
    }
  }
}

class Item {
  final int id;
  final String desc;
  const Item({
    required this.id,
    required this.desc,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      desc: json['desc'],
    );
  }
}
//<uses-permission android:name="LOCAL_MAC_ADDRESS"/>