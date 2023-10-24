import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/vendor/shop_list/shop_list.dart';


class UpdateEnterprise extends StatefulWidget {
  final String? userId;
  final String? Name;
  final String? Email;
  final String? Phone;
  UpdateEnterprise({this.Name, this.Email, this.Phone, this.userId});

  @override
  State<UpdateEnterprise> createState() => _UpdateEnterpriseState();
}

class _UpdateEnterpriseState extends State<UpdateEnterprise> {
  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      counter: Offstage(),

      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color:  Color(0xFFebd197),
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();


  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Update Shop Data"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
              ),
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
            body: ListView(
              children: [
                SizedBox(height: 20),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        cursorColor: Color(0xFFebd197),
                        maxLength: 30,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          "Name",
                          Icons.person,
                        ),
                        controller: _name..text=widget.Name!,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        cursorColor: Color(0xFFebd197),
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 40,
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Email',
                          Icons.mail_outline_outlined,
                        ),
                        controller: _email..text=widget.Email!,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        cursorColor: Color(0xFFebd197),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          "Phone",
                          Icons.phone,
                        ),
                        controller: _phone..text=widget.Phone!,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation:12,
                    child: InkWell(
                      onTap: ()  {
                        _update(_name.text,_email.text,_phone.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      },
                      child: Container(
                        width:double.infinity,
                        height: 50,
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:  _goldColors ,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15,)),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text("Update Shop Data",textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 22,
                                )),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          )
      ),
    );
  }
  _update(String _name,String _email,String _phone,) async {
    final response = await http.post(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/update_profile"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
          "id":widget.userId,
          "username":_name,
          "email":_email,
          "mobile":_phone,
      }),
    );
    print('rrrrrrrrrr');
    final data = jsonDecode(response.body)['data'];
    print(data);
    print('xxxxxx');
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Update Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ShopList()));
    } else {
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}









