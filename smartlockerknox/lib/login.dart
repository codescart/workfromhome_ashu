import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlockerknox/mainhome.dart';
import 'package:url_launcher/url_launcher.dart';


class LoginPage extends StatefulWidget {
  final bool popsop;
  LoginPage({Key? key, required this.popsop}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        // color: kTextLowBlackColor,
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }
  final _formKey = GlobalKey<FormState>();
  final _mobleno = TextEditingController();
  bool _loading=false;

  final _goldColors = const[Color(0xfff56942), Color(0xffff3134)];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 30, // Changing Drawer Icon Size
                  ),
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            backgroundColor: Color(0xffC4EBF2),
            title: Text("Smart Locker Knox",style: TextStyle(color: Colors.black),),
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: [
             IconButton( onPressed: () {
             }, icon: Icon(Icons.save_alt,color: Colors.black,),)
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {

                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xffC4EBF2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png",height: 150,width: 150,),
                  Form(
                      key: _formKey,
                      child:Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 17.0, bottom: 5.0,top: 15),
                              child: Text(
                                'Match User ID',
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
                              maxLength: 10,
                              style: const TextStyle(fontSize: 14),
                              decoration: getInputDecoration(
                                'User ID',
                                Icons.phone,
                              ),
                              controller: _mobleno,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter User Phone No.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.transparent,
                      elevation:12,
                      child: InkWell(
                        onTap: ()  {
                          if (_formKey.currentState!.validate()) {
                            _matchcustomer(_mobleno.text);
                          }
                        },
                        child: Container(
                          width:double.infinity,
                          height: 50,
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _goldColors,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(15,)),
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: _loading==false?Text("Match Customer",textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 22,
                                ),):CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton (
                      onPressed: (){
                        _launchEmail();
                      },
                      child: Text("Privacy Policy !",style: TextStyle(
                        color: Color(0xffff3134)
                      ),)),
                  TextButton(
                      onPressed: (){
                        _scanQr();
                      },
                      child: Text("login with Qr",style: TextStyle(
                          color: Color(0xffff3134)
                      ),))
                ],
              ),
            ),
          ),
        )
    );
  }


  _matchcustomer(String _mobleno) async {
    // print('ffffffff');
    setState(() {
      _loading=true;
    });
    final response = await http.post(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/keymatch"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "phone":_mobleno
      }),
    );
    final data = jsonDecode(response.body);
    if (data["error"]=="200") {
      setState(() {
        _loading=false;
      });
      final prefs = await SharedPreferences.getInstance();
      final key = 'userId';
      final userId = data['data']['id'];
      prefs.setString(key, userId);
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreens(popsop:widget.popsop)));
    }else {
      setState(() {
        _loading=false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  _launchEmail() async {
    const url = 'https://smartlockerindia.com/Privacypolicy.php/Privacy_policy';
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }


  var _scanBarcode = '';
  void _scanQr() async{
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      _matchcustomer(_scanBarcode);
    });
    super.initState();
  }
}
