//import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:attendance_by_biometrics/added_points.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'checking.dart';
import 'states.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:geolocator/geolocator.dart';

class BiometricsCubit extends Cubit<BiometricsStates> {
  BiometricsCubit() : super(BiometricsInitStates());

  static BiometricsCubit get(context) => BlocProvider.of(context);

  //DEVICE ID ==>

  String deviceId = "";
  Future<String?> getDeviceId(context) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.android) {
        // Get Android ID
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print("AndroidID: ${androidInfo.id}");
        deviceId = androidInfo.id;
        return androidInfo.id;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        // Get iOS ID
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print("IosID: ${iosInfo.identifierForVendor}");
        deviceId = iosInfo.identifierForVendor!;
        return iosInfo.identifierForVendor;
      }
    } catch (e) {
      print("Error getting device ID: $e");
    }
    return null;
  }

  //LANGUAGE ==>

  String language = "Ar";
  Locale? locale;

  Future<void> setLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getLang = prefs.getString('language');
    if (getLang != null && getLang.isNotEmpty) {
      language = getLang;
    }
  }

  //DATABASE ==>

  Database? db;
  bool isEmpty = true;
  List<Map> user = [];
  Future<void> createDb() async {
    // Open the database.
    db = await openDatabase(
      'attendanceDb.db',
      version: 1,
      onCreate: (db, version) {
        debugPrint("DB created");
        // Create the table.
        db.execute(
            'CREATE TABLE employee (employee_id INTEGER PRIMARY KEY AUTOINCREMENT,desc VARCHAR NOT NULL)');
        debugPrint("table created");
      },
      onOpen: (db) async {
        debugPrint("DB opend");
        getDataFromDatabase(db, "employee").then((value) {
          user = value;
          emit(GetData());
          print("user : ${value.toString()}");
        });
      },
    );
  }

  Future<List<Map>> getDataFromDatabase(database, tableName) async {
    return database.rawQuery('SELECT * FROM $tableName ');
  }

  Future<void> insertToDatabase({
    required String desc,
  }) async {
    await db?.transaction((txn) {
      txn.rawInsert('INSERT INTO employee(desc) VALUES("$desc")').then((value) {
        getDataFromDatabase(db, "employee").then((value) {
          user = value;
          emit(GetData());
          print("user : ${value.toString()}");
        });
      });

      return Future.delayed(
        const Duration(microseconds: 0),
        () {},
      );
    });
    return Future.delayed(const Duration(microseconds: 0));
  }

  Future<bool> isTableEmpty() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Get the path to the database directory
    String databasesPath = await getDatabasesPath();
    // Join the database path with the database file name
    String dbPath = join(databasesPath, 'attendanceDb.db');
    // Open the database
    Database db = await openDatabase(dbPath);
    //Get the count of rows in the table
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM employee'));
    // Check if the count is greater than zero
    //bool hasData = count! > 0;
    if (count == 0) {
      isEmpty = true;
      return true;
    } else {
      isEmpty = false;
      return false;
    }
  }

  //API ==>

  String data = "hi";
  Map? employeeInfo;

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.22:5000/get'));
      if (response.statusCode == 200) {
        // Data retrieval successful
        final jsonData = json.decode(response.body);
        // Process and use the retrieved data as needed
        data = jsonData.toString();
        print(data);
        emit(AppChangeBottomNavBarState());
      } else {
        // Data retrieval failed
        Fluttertoast.showToast(
          msg: language == "En"
              ? "Data retrieval failed with status code: ${response.statusCode}"
              : "فشل استرجاع البيانات: ${response.statusCode}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      // Error occurred during data retrieval
      data = "did not work";
      Fluttertoast.showToast(
        msg: language == "En"
            ? "An error occurred during data retrieval: $error"
            : "حدث خطأ اثناء استرجاع البيانات: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      emit(AppChangeBottomNavBarState());
    }
  }

  Future<void> insertData({required Map data}) async {
    final url = Uri.parse(
        'http://192.168.1.22:5000/insert_all'); // Replace with your server's IP address and port
    try {
      // final data = {
      //   "table_name": "table_test",
      //   "columns": {
      //     '[desc]': latAndLongController.text,
      //   }
      //   // Replace with the data you want to insert
      // };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        // Data insertion successful
        Fluttertoast.showToast(
          msg: language == "En"
              ? "Data insertion successful"
              : "تم ادخال البيانات",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        // Data insertion failed
        Fluttertoast.showToast(
          msg: language == "En"
              ? "Data insertion failed with status code: ${response.statusCode}"
              : "فشل ادخال البيانات: ${response.statusCode}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      // Error occurred during the HTTP POST request
      Fluttertoast.showToast(
        msg: language == "En"
            ? "An error occurred during data insertion: $error"
            : "حدث خطأ خلال ادخال البيانات: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> getEmployee({required String id}) async {
    http
        .get(Uri.parse('http://192.168.1.22:5000/get_employee/$id'))
        .then((value) {
      if (value.statusCode == 200) {
        // Data retrieval successful
        final jsonData = json.decode(value.body);
        // Process and use the retrieved data as needed
        employeeInfo = jsonData;
        print(employeeInfo.toString());
        employeeIdController.clear();
        passwordController.clear();
        emit(AppChangeBottomNavBarState());
      } else {
        // Data retrieval failed
        Fluttertoast.showToast(
          msg: language == "En" ? "ID not found" : "هذا الرقم غير موجود",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: language == "En"
            ? "An error occurred during data retrieval: $error"
            : "حدث خطأ خلال ادخال البيانات: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      emit(AppChangeBottomNavBarState());
    });
  }

  Future<void> yellow() async {
    final url = Uri.parse(
        'https://api.yallow.com/a/8a79c4b07aa8b8ca05530c156edb28b28217f23f96fed6ff5ff088b49955eae7/order/add'); // Replace with your server's IP address and port
    try {
      final data = {
        'pickup_lat': '31.952329',
        'pickup_lng': '35.932154',
        'preparation_time': '30',
        'lat': '31.9625314016',
        'lng': '35.8901908945',
        'customer_phone': '0796340951',
        'customer_name': '',
      };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        // Data insertion successful
        print('Data insertion successful: ${response.body}');
      } else {
        // Data insertion failed
        print('Data insertion failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred during the HTTP POST request
      print('An error occurred during data insertion: $error');
    }
  }

  //AUTHENTICATION ==>

  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;
  LocationPermission? permission;

  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: language == "En"
            ? "Location services are disabled. Please enable the services"
            : "خدمة الموقع معطلة الرجاء تفعيل هذه الخدمة",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          msg: language == "En"
              ? "Location permissions are denied settings will open"
              : "خدمة الموقع معطلة سيتم فتح الاعدادات",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
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
        msg: language == "En"
            ? "Location permissions are permanently denied, we cannot request permissions."
            : "",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      ).then((value) async {
        Future.delayed(const Duration(seconds: 2), () async {
          await Geolocator.openAppSettings();
          //await Geolocator.openLocationSettings();
        });
      });
      return false;
    }
    //permission granted
    startListening();
    return true;
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
        msg: language == "En" ? "BIOMETRICS UNAVAILABLE" : "البصمه غير متاحه",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      ).then((value) {
        SystemNavigator.pop();
      });
    }
  }

  Future<bool> authenticate() async {
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
        return true;
      } else {
        // User did not authenticate
        return false;
      }
    } else {
      // Fingerprint authentication is not available on this device
      // You can show an error message or navigate back to the previous screen
      return false;
    }
  }

  //IMAGE ==>

  File? imageFile;

  Future<void> selectImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera access
    );
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      imageFile = File(pickedFile.path);
      await saveImagePath(imagePath);
      emit(ImagePicked());
    } else {
      imageFile = null;
    }
  }

  Future<void> saveImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', imagePath);
  }

  Future<void> loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profilePicturePath = prefs.getString('imagePath');
    if (profilePicturePath != null && profilePicturePath.isNotEmpty) {
      imageFile = File(profilePicturePath);
    }
  }

  //LOCATION ==>

  double distanceInMeters = 0;
  List splitLatAndLong = [];
  List<Map<String, dynamic>> point = [
    {"latandlong": "37.428851,-122.080056", "distance": 100.0},
    {"latandlong": "31.923888,35.905617", "distance": 1900.0},
    {"latandlong": "37.422251,-122.080056", "distance": 50.0},
    {"latandlong": "37.422238,-122.083751", "distance": 500.0},
    {"latandlong": "31.923888,35.905617", "distance": 1697.0},
    {"latandlong": "37.422251,-122.080056", "distance": 50.0},
    {"latandlong": "31.923888,35.905617", "distance": 1400.0},
  ];
  bool inRange = false;
  String? status;
  String closePoint = "";

  addPoint({required String latAndLong, required String distance}) {
    latAndLong = latAndLongController.text;
    distance = distanceController.text;
    Map<String, dynamic> formData = {
      'latandlong': latAndLong,
      'distance': distance,
    };
    point.add(formData);
    latAndLongController.clear();
    distanceController.clear();
  }

  Future<void> getMyLocation() async {
    splitLatAndLong = point[0]["latandlong"]!.split(',');
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    distanceInMeters = Geolocator.distanceBetween(latitude, longitude,
        double.parse(splitLatAndLong[0]), double.parse(splitLatAndLong[1]));
    debugPrint('Distance from user to destination: $distanceInMeters meters');
  }

  StreamSubscription<Position>? positionStream;

  Future<void> startListening() async {
    positionStream = Geolocator.getPositionStream(
            locationSettings: AndroidSettings(
                accuracy: LocationAccuracy.best,
                intervalDuration: const Duration(hours: 1)))
        .listen((Position position) {
      for (var element in point) {
        debugPrint(
            "latandlong:: ${element["latandlong"]} dis:: ${element["distance"]}");
        splitLatAndLong = element["latandlong"].split(',');
        debugPrint(splitLatAndLong.toString());
        distanceInMeters = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            double.parse(splitLatAndLong[0]),
            double.parse(splitLatAndLong[1]));
        if (distanceInMeters <= element["distance"]) {
          debugPrint("in range: ${element["latandlong"]}");
          closePoint = element["latandlong"];
          emit(EnterStates(inRange = true, status = "IN RANGE"));
          positionStream!.pause();
          break;
        } else {
          emit(ExitStates(inRange = false, status = "OUT OF RANGE"));
          debugPrint("out of range: ${element["latandlong"]}");
          if (point.indexOf(element) == point.length - 1) {
            distanceInMeters = 0;
            positionStream!.pause();
            break;
          }
        }
      }
    });
  }

  //SCREENS ==>

  int bottomBarIndx = 0;
  List<Widget> screens = [const CheckingScreen(), const AddedPoints()];

  //CONTROLLERS ==>

  TextEditingController employeeIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController latAndLongController = TextEditingController();

  //TIME AND DATE ==>

  String timeAndDate = "";

  setTimeAndDate() {
    DateTime whenCheckd = DateTime.now();
    timeAndDate = DateFormat('yyyy-MM-dd - kk:mm:ss').format(whenCheckd);
    saveCheckingTime(timeAndDate);
    emit(Authenticated());
  }

  Future<void> saveCheckingTime(String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('time', time);
  }

  Future<void> loadCheckingTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTime = prefs.getString('time');
    if (getTime != null && getTime.isNotEmpty) {
      timeAndDate = getTime;
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