import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/login/ForgetPassword/matchphone.dart';
import 'package:smartlocker/shop/shophome.dart';
import 'package:smartlocker/vendor/vendor_home.dart';

class PinLogin extends StatefulWidget {
  @override
  _PinLoginState createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  final _formKey = GlobalKey<FormState>();
  final _mobileNumber = TextEditingController();
  final _pin = TextEditingController();
  bool _isLoadingButton = false;
  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      counter: Offstage(),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        borderSide: BorderSide(color: Colors.white, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        borderSide: BorderSide(color: Colors.white, width: 1),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: Color(0XFF3b9fbe),
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 10, right: 30, left: 30),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileNumber,
                        maxLength: 10,
                        cursorColor: Color(0XFF3b9fbe),
                        decoration: getInputDecoration(
                            "Mobile Number", Icons.phone_android),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        controller: _pin,
                        cursorColor: Color(0XFF3b9fbe),
                        maxLength: 6,
                        decoration: getInputDecoration("PIN", Icons.password),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your PIN';
                          } else if (value.length != 6) {
                            return 'Please enter a valid 6-digit PIN';
                          }
                          return null;
                        },
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 12,
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                pinlogin(_mobileNumber.text, _pin.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0XFF3b9fbe),
                                ),
                                child: setUpButtonChild()),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forget Password ?"),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MatchPhone()));
                    }, child: Text("Click here !"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_isLoadingButton == false) {
      return Text("Sign In", style: TextStyle(fontSize: 25));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }

  pinlogin(
    String _mobileNumber,
    String _pin,
  ) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.post(
      Uri.parse(
          "https://smartlockerindia.com/ajapi/api/Mobile_app/app_login"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "mobile":_mobileNumber,
        "pin":_pin
      }),
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final prefs = await SharedPreferences.getInstance();
      final key = 'userId';
      final userId = data['data']['id'];
      prefs.setString(key, userId);
      final prefs1 = await SharedPreferences.getInstance();
      final key1 = 'userType';
      final userType = data['data']['type'];
      prefs1.setString(key1, userType);
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      data['data']['type'] == "2"
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ShopHome()))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => VendorHome()));
    } else {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
