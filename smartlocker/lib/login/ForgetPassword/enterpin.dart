import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartlocker/login/pin_login.dart';
import 'package:http/http.dart'as http;

class ForgetPasswordPage extends StatefulWidget {
  final String? userId;
  ForgetPasswordPage({this.userId});
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _newPin = '';
  String _confirmPin = '';

  bool _isLoadingButton=false;
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
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        cursorColor: Color(0XFF3b9fbe),
                        maxLength: 6,
                        decoration: getInputDecoration(
                          "New PIN",
                          Icons.password
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new PIN';
                          } else if (value.length != 6) {
                            return 'Please enter a valid 6-digit PIN';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _newPin = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 6,
                        cursorColor: Color(0XFF3b9fbe),
                        decoration: getInputDecoration(
                            "Confirm PIN",
                            Icons.password
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new PIN';
                          } else if (value.length != 6) {
                            return 'Please enter a valid 6-digit PIN';
                          } else if (value != _newPin) {
                            return 'The entered PINs do not match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _confirmPin = value;
                          });
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
                                _changePin(_confirmPin);
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
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget setUpButtonChild() {
    if (_isLoadingButton == false) {
      return Text("Save", style: TextStyle(fontSize: 25));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
  _changePin(String _confirmPin,) async {
    print("ajay");
    final fuserId=widget.userId;
    print(fuserId);
    print("rohit");
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.get(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/update_password?userid=$fuserId&pin=$_confirmPin"),
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PinLogin()));
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
