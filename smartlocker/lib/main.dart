import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/shop/shophome.dart';
import 'package:smartlocker/splashscreen.dart';
import 'package:smartlocker/vendor/vendor_home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
  final type = prefs.getString('userType');
  runApp( MyApp(userId: userId,type: type,));
}

class MyApp extends StatefulWidget {
  final String? userId;
  final String? type;
  MyApp({Key? key,this.userId, this.type}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.userId == null?SplashScreen():widget.type == '2'?ShopHome():VendorHome()
    );
  }

}





