import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UserLocation extends StatefulWidget {
  final String? UserId;
  UserLocation({this.UserId});
  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  @override
  void initState() {
    _viewlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Address"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _goldColors,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Full Address: ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text(
                data == null ? "" : data['fullAddress'],
                maxLines: 10,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            ElevatedButton(onPressed: (){
              _launchpolicy();
            }, child: Text('Track'))
          ],
        ),
      ),
    );
  }

  var data;
  _viewlocation() async {
    final userId = widget.UserId;
    final response = await http.get(
      Uri.parse(
          "https://smartlockerindia.com/ajapi/api/Mobile_app/getaddress?user_id=$userId"),
    );
    final datas = jsonDecode(response.body);
    print(datas);
    print('Ajay');
    print(response.statusCode);
    if (datas["error"] == '200') {
      setState(() {
        data = datas['data'];
      });
    } else {}
  }

  _launchpolicy() async {
    final flat=data['lat'];
    final flong=data['long'];
     var url = 'https://maps.google.com/?q=$flat,$flong';
    // const url = 'https://bharatekrishi.com/policy/privacy.html';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
