import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/vendor/Drstributer/distributer_list.dart';
import 'package:smartlocker/vendor/SalesPerson/salse_person_list.dart';
import 'package:smartlocker/vendor/SuperDistributer/super_distributer_list.dart';
import 'package:smartlocker/vendor/create/secondscreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
        color: Color(0xFFebd197),
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoadingButton = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  String? role;

  @override
  void initState() {
    pj();
    super.initState();
  }

  var rs = '0';
  pj() async {
    final prefs1 = await SharedPreferences.getInstance();
    final key1 = prefs1.getString('userType') ?? '0';
    setState(() {
      rs = key1;
    });
  }

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
              title: Text("Create Shop"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _goldColors,
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            file == null
                                ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: Text(
                                "Choose Image",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            )
                                : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                file!,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFebd197),
                                    borderRadius: BorderRadius.circular(50)),
                                child: IconButton(
                                  onPressed: () {
                                    _choose();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              'Name',
                              Icons.mobile_screen_share_outlined,
                            ),
                            controller: _name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Shop Name';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.name,
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
                              'Phone',
                              Icons.mail_outline_outlined,
                            ),
                            controller: _phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Phone';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.name,
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
                            maxLength: 50,
                            style: const TextStyle(fontSize: 14),
                            decoration: getInputDecoration(
                              'Email',
                              Icons.person,
                            ),
                            controller: _email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.name,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                            child: Text(
                              'Address',
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
                            keyboardType: TextInputType.text,
                            maxLength: 150,
                            style: const TextStyle(fontSize: 14),
                            decoration: getInputDecoration(
                              'Address',
                              Icons.phone_android,
                            ),
                            controller: _address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Address';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.name,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                            child: Text(
                              'Pin',
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
                            keyboardType: TextInputType.number,
                            maxLength: 150,
                            style: const TextStyle(fontSize: 14),
                            decoration: getInputDecoration(
                              'Pin',
                              Icons.phone_android,
                            ),
                            controller: _pin,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Pin';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.name,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                            child: Text(
                              ' Select Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        rs == '1'
                            ? Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  'Select Role',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: [
                                  {"name": "Super Distributer", "role": "3"},
                                  {"name": "Distributer", "role": "4"},
                                  {"name": "Shop", "role": "2"},
                                  {"name": "Sales Person", "role": "5"},
                                ]
                                    .map((items) => DropdownMenuItem<String>(
                                  value: items['role'].toString(),
                                  child: Text(
                                    items['name'].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                            : rs == '3'
                            ? Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 0.0,
                              right: 15.0,
                              bottom: 8.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  'Select Role',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: [
                                  {"name": "Distributer", "role": "4"}
                                ]
                                    .map((items) =>
                                    DropdownMenuItem<String>(
                                      value: items['role'].toString(),
                                      child: Text(
                                        items['name'].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                value: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                            : rs == '4'
                            ? Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 0.0,
                              right: 15.0,
                              bottom: 8.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  'Select Role',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                    Theme.of(context).hintColor,
                                  ),
                                ),
                                items: [
                                  {"name": "Shop", "role": "2"},
                                  {
                                    "name": "Sales Person",
                                    "role": "5"
                                  },
                                ]
                                    .map((items) =>
                                    DropdownMenuItem<String>(
                                      value: items['role']
                                          .toString(),
                                      child: Text(
                                        items['name'].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                value: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 0.0,
                              right: 15.0,
                              bottom: 8.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  'Select Role',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                    Theme.of(context).hintColor,
                                  ),
                                ),
                                items: [
                                  {"name": "Shop", "role": "2"},
                                ]
                                    .map((items) =>
                                    DropdownMenuItem<String>(
                                      value: items['role']
                                          .toString(),
                                      child: Text(
                                        items['name'].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                value: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 12,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _enterpriseData(
                              _name.text, _phone.text, _email.text, _address.text,_pin.text);
                        } else {}
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _goldColors,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(
                            15,
                          )),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(child: setUpButtonChild()),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget setUpButtonChild() {
    if (_isLoadingButton == false) {
      return Text("Create",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }

  //
  // File? file;
  // final picker = ImagePicker();
  // void _choose() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
  //   setState(() {
  //     if (pickedFile != null) {
  //       file = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  var mydata;
  File? file;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        mydata = img64;
        print('Abhinav');
        print(img64);
        print('Thi');
      } else {
        print('No image selected.');
      }
    });
  }

  _enterpriseData(
      String _name,
      String _phone,
      String _email,
      String _address,
      String _pin,
      ) async {
    print(_name);
    print(_phone);
    print(_email);
    print(_address);
    print(mydata);
    print("object");
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? "0";
    print(userId);
    print("raja");
    setState(() {
      _isLoadingButton = true;
    });
    print('ggggggggggggg');
    final response = await http.post(
      Uri.parse("https://smartlockerindia.com/ajapi/api/add_shop.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "created_by": userId,
        "username": _name,
        "mobile": _phone,
        "email": _email,
        "address": _address,
        "pin":_pin,
        "type": role,
        "photo": mydata
      }),
    );
    print('bbbbb');
    final data = jsonDecode(response.body);
    print(data);
    print('ssssss');
    if (data["success"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final shopId = data["data"]['id'];
      final Type = data["data"]['type'];
      Type == '2'
          ? Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SecondScreen(
                  userName: _name,
                  userPhone: _phone,
                  shopEmail: _email,
                  shopId: shopId)))
          : Type == '3'
          ? Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SuperDistributer()))
          : Type == '4'
          ? Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Distributer()))
          : Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SalesPerson()));
    } else {
      setState(() {
        _isLoadingButton = false;
      });
      print("data");
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

// _enterpriseData(String _name,String _phone,String _email,String _address,) async {
//   setState(() {
//     _isLoadingButton = true;
//   });
//   final prefs = await SharedPreferences.getInstance();
//   final key = 'userId';
//   final userId = prefs.getString(key) ?? "0";
//   print(userId);
//   print("raja");
//   Map<String, String> headers = {
//     'Content-Type': 'multipart/form-data',
//   };
//   var url = Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/add_shop');
//   var request = http.MultipartRequest('POST', url)
//     ..headers.addAll(headers);
//   request.fields["created_by"]=userId;
//   request.fields["username"]=_name;
//   request.fields["mobile"]=_phone;
//   request.fields["email"]=_email;
//   request.fields["address"]=_address;
//   request.fields["type"]=role!;
//   file!=null?
//   request.files.add(await http.MultipartFile.fromPath('photo', file!.path)):'';
//   final response = await request.send();
//   var responseString = await response.stream.bytesToString();
//   var data = json.decode(responseString);
//   print("ssssss");
//   print(data);
//   if (data["error"] == "200") {
//     setState(() {
//       _isLoadingButton = false;
//     });
//     final shopId = data["country"]['id'];
//     role=='2'?
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SecondScreen(userName:_name,userPhone:_phone,shopEmail:_email,shopId:shopId)))
//         :role=='3'?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SuperDistributer()))
//         :role=='4'?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Distributer()))
//         :Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SalesPerson()));
//   }
//   else {
//     setState(() {
//       _isLoadingButton = false;
//     });
//     print("data");
//     Fluttertoast.showToast(
//         msg: data["msg"],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 10.0);
//   }
// }
}
