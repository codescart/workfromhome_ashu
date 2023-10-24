import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreens extends StatefulWidget {
  final bool popsop;

  HomeScreens({Key? key, required this.popsop}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  void initState() {
    pjl();
    getdeta();
    super.initState();
  }

  @override
  pjl() {
    // print('pankaj');
    // print(widget.popsop);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.popsop == false
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                    'Smart Locker needs your contact access to get contact leads'),
                content: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset('assets/contact.jpeg')
                        ],
                      ),
                    )),
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'DENY',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Permission.contacts.request();
                      Navigator.pop(context);
                      pjl2();
                    },
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            )
          : "";
    });
  }

  pjl2() {
    // print('pankaj');
    // print(widget.popsop);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.popsop == false
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                    'Smart Locker needs your background location to track your realtime field work location'),
                content: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset('assets/backg.jpeg')
                        ],
                      ),
                    )),
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'DENY',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Permission.location.request();
                      await Permission.locationAlways.request();
                      pjl3();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            )
          : "";
    });
  }

  pjl3() {
    // print('pankaj');
    // print(widget.popsop);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.popsop == false
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                    'Smart Locker needs your background overlay to send you push work notifications'),
                content: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset('assets/noti.jpeg')
                        ],
                      ),
                    )),
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'DENY',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Permission.systemAlertWindow.request();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('popsop', true);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            )
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 12,
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data == null
                              ? ""
                              : "Your phone has been locked as you did't repay your installment by the due date. To unlock your phone. call " +
                                  data['uname'] +
                                  ".",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 12,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black54, width: 2),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Text(
                              'This Device is Managed',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -80,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/logo.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: _callNumber,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 12,
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                              data == null
                                  ? 'Not Available'
                                  : data['dmobile'] == null
                                      ? 'Not Available'
                                      : data['dmobile'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ],
                      )),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your Device Assign successful!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          _launchEmail();
                        },
                        child: Text(
                          "Privacy Policy !",
                          style: TextStyle(color: Color(0xff31ffe7)),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _callNumber() async {
    // print("ssssssssssss");
    final number = data['dmobile']; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  var data;
  var datal;
  getdeta() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? "0";
    final response = await http.post(Uri.parse(
        "https://smartlockerindia.com/ajapi/api/Mobile_app/datauser?userid=$userId"));
    final datad = jsonDecode(response.body);
    // print(datad);
    // print("uuuuuuuuuuuuu");
    if (datad["error"] == 200) {
      setState(() {
        datal = datad['data'];
        data = datal[0];
        // print(datal);
        // print(data);
        // print("kkkkkkkkkkk");
      });
    } else {}
  }

  _launchEmail() async {
    const url = 'https://smartlockerindia.com/Privacypolicy.php/Privacy_policy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
