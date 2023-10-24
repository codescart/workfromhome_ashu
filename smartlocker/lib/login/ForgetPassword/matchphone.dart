import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/login/ForgetPassword/forgetotp.dart';


class MatchPhone extends StatefulWidget {
  const MatchPhone({Key? key}) : super(key: key);

  @override
  State<MatchPhone> createState() => _MatchPhoneState();
}

class _MatchPhoneState extends State<MatchPhone> {
  final TextEditingController _mobile =TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              padding: EdgeInsets.only(top:100,bottom: 10,right: 30,left: 30),
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
                  child: TextFormField(
                    maxLength: 10,
                    controller: _mobile,
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
                  ),
                ),
                SizedBox(height: 10),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          matchPhone(_mobile.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0XFF3b9fbe),
                          ),
                          child:setUpButtonChild()
                      ),
                    )
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Go Back ?"),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
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

  matchPhone(String _mobile,) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.get(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/matchphone?mobile=$_mobile"),
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final userId = data['data']['id'];
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MatchOtp(
              phoneNo:_mobile,
              userId:userId,
          )
      )
      );
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
  Widget setUpButtonChild() {
    if (_isLoadingButton==false) {
      return  Text("Verify",
          style: TextStyle(fontSize: 25)
      );
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
}
