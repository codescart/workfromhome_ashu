import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({Key? key}) : super(key: key);

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  @override
  void initState() {
    getdeta();
    super.initState();
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
              )
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
}
