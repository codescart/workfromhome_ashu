import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QR_Code extends StatefulWidget {
  final String? shopId;
  QR_Code({ this.shopId});
  @override
  State<QR_Code> createState() => _QR_CodeState();
}

class _QR_CodeState extends State<QR_Code> {

  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  @override
  void initState() {
    _accessKoken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Enroll Device"),
        flexibleSpace: Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:  _goldColors ,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 18,),),
      ),
      body: Center(
        child: Container(
          child: QrImageView(
            data: qrs==null?'hi': qrs.toString(),
            size: 0.7 * MediaQuery.of(context).size.width,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }

  var qrs;
  _accessKoken() async {
    final prefs= await SharedPreferences.getInstance();
    final qrsd= prefs.getString('qrcodes')??'0';
  if(qrsd!='0'){
    setState(() {
      qrs=qrsd;
    });

  }else{
    print('norepeat');
    final response = await http.get(
      Uri.parse("https://smartlockerindia.com/ajapi/api/outhlogin/curl.php"),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('Ajay');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final token = data['access_token'];
      final fshipId= widget.shopId;
      final response = await http.post(
        Uri.parse("https://androidmanagement.googleapis.com/v1/$fshipId/enrollmentTokens"),
        headers: {
          "Authorization":"Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "duration": "900000000s",
          "policyName":"$fshipId/policies/myPolicy"
        }),
      );
      final dada = jsonDecode(response.body);
      print(dada);
      print("dddddddddddd");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Qr Generate Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 10.0);
        setState(() {
          qrs=dada['qrCode'];
        });
        prefs.setString('qrcodes', qrs);

      }else {
        Fluttertoast.showToast(
            msg: "Faild To Create ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);
      }
    }else {
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  }

}
