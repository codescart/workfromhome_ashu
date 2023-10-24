import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/vendor/vendor_home.dart';

class TransferBall extends StatefulWidget {
  @override
  _TransferBallState createState() => _TransferBallState();
}

class _TransferBallState extends State<TransferBall> {
  bool _isTextFieldEnabled = true;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final _userphone =TextEditingController();
  final  _useradddevice =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _globalkey = GlobalKey<FormState>();
  bool _isLoadingButton = false;
  bool _loading = false;
  bool _buttonloading = false;
  bool _button1loading = false;

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }
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
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Balance Transfer"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:  _goldColors ,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 10,
                      controller: _userphone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (value.length != 10) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0XFF3b9fbe),
                      decoration: getInputDecoration(
                          "Mobile Number",
                          Icons.phone_android
                      ),
                      enabled: _isTextFieldEnabled,
                      focusNode: _focusNode1,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  _button1loading==false?Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _matchPhone(_userphone.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0XFF3b9fbe),
                            ),
                            child:_isLoadingButton==false?Text("Verify",
                                style: TextStyle(fontSize: 25)
                            ):CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                        ),
                      )
                  ):Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black26,
                          ),
                          child:Text("Verify",
                              style: TextStyle(fontSize: 25)
                          )
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            dataa==null?Container():Text(dataa["username"].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0),
            Form(
              key: _globalkey,
              child: Expanded(
                child: TextFormField(
                  maxLength: 6,
                  controller: _useradddevice,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter No. of Devices';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Color(0XFF3b9fbe),
                  decoration: getInputDecoration(
                      "No.of Device",
                      Icons.phone_android
                  ),
                  enabled: !_isTextFieldEnabled,
                  focusNode: _focusNode2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TransferBall()));
                      },
                      child: Container(
                          height: 50,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0XFF3b9fbe),
                          ),
                          child:Text("Reset",
                              style: TextStyle(fontSize: 25)
                          )
                      ),
                    )
                ),
                _buttonloading==false?Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    child: Container(
                        height: 50,
                        width: 130,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black26,
                        ),
                        child:Text("Transfer",
                            style: TextStyle(fontSize: 25)
                        )
                    )
                ):
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    child: InkWell(
                      onTap: () {
                        if (_globalkey.currentState!.validate()) {
                          _balltransfer(_useradddevice.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0XFF3b9fbe),
                          ),
                          child:_loading==false?Text("Transfer",
                              style: TextStyle(fontSize: 25)
                          ):CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  var dataa;
  _matchPhone(String _userphone,) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.get(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/transfermatch?mobile=$_userphone"),
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _isLoadingButton = false;
        _buttonloading=true;
        _button1loading=true;
        _isTextFieldEnabled = false;
        dataa = data['data'];
      });
      _focusNode2.requestFocus();
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
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
  _balltransfer(String _useradddevice,) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final fmobile=dataa["mobile"];

    setState(() {
      _loading = true;
    });
    final response = await http.get(
        Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/balancetransfer?uid=$userId&tid=$fmobile&piece=$_useradddevice")
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _loading = false;
        _isTextFieldEnabled = false;
        dataa = data['data'];
      });
      _focusNode2.requestFocus();
      Fluttertoast.showToast(
          msg: "Transfer successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VendorHome()));
    } else {
      setState(() {
        _loading = false;
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
