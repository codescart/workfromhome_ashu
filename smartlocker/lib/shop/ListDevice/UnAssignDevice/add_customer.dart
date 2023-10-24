import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:smartlocker/shop/ListDevice/UnAssignDevice/add_imei_detail.dart';
import 'package:smartlocker/shop/ListDevice/UnAssignDevice/unassigndevice.dart';
import 'package:http/http.dart' as http;


class AddCustomer extends StatefulWidget {
  final unassignlist? deviceData;
  final String? ShopId;
   AddCustomer({ this.deviceData, this.ShopId});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

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
  final TextEditingController _customername = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _imeino1 = TextEditingController();
  final TextEditingController _imeino2 = TextEditingController();




  File? file;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String imeinum1 = '';
  String imeinum2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,size: 16,),),
        title: Text("Add Customer"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Stack(
                  children: [
                    file == null?CircleAvatar(
                      backgroundColor: Color(0xFFebd197),
                      radius: 60,
                    ):CircleAvatar(
                      backgroundImage:FileImage(file!),
                      radius: 60,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            _choose();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                     children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0,top: 15),
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
                        controller: _customername,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Name',
                          Icons.person,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Email',
                          Icons.email,
                        ),
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },

                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Mobile',
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
                          'Mobile No.',
                          Icons.phone,
                        ),
                        controller: _mobile,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Phone';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Custmer IMEI Number 1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.56,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              decoration: getInputDecoration(
                                'Custmer IMEI Number 1',
                                Icons.mobile_screen_share_rounded,
                              ),
                              controller: _imeino1,
                              keyboardType: TextInputType.number,
                              readOnly: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter IMEI';
                                }
                                return null;
                              },

                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            height: 45,
                            decoration:  BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors:  _goldColors ,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15,)),
                            ),
                            child: InkWell(
                              onTap: ()  async {
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  SimpleBarcodeScannerPage(),
                                    ));
                                setState(() {
                                  if (res is String) {
                                    _imeino1.text = res;
                                  }
                                });
                              },
                              child: Center(
                                child: Text("Scan",textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 22,
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Custmer IMEI Number 2',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.56,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              decoration: getInputDecoration(
                                'Custmer IMEI Number 2',
                                Icons.mobile_screen_share_rounded,
                              ),
                              controller: _imeino2,
                              keyboardType: TextInputType.number,
                              readOnly: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter IMEI';
                                }
                                return null;
                              },

                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            height: 45,
                            decoration:  BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors:  _goldColors ,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15,)),
                            ),
                            child: InkWell(
                              onTap: ()  async {
                                var ress = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  SimpleBarcodeScannerPage(),
                                    ));
                                setState(() {
                                  if (ress is String) {
                                    _imeino2.text = ress;
                                  }
                                });
                              },
                              child: Center(
                                child: Text("Scan",textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 22,
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation:12,
                    child: InkWell(
                      onTap: ()  {
                        if(file!=null) {
                          if (_formKey.currentState!.validate()) {
                            _addCustomer(_customername.text,_email.text,_mobile.text,_imeino1.text,_imeino2.text,);
                          }
                        }else{
                              Fluttertoast.showToast(
                                  msg: 'Image is Required',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.transparent,
                                  textColor: Colors.red,
                                  fontSize: 16.0);
                        }
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
                            child: _loading==false?Text("NEXT",textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ],
      ),
    );
  }


  bool _loading =false;
  _addCustomer(String _customername,String _email,String _mobile,String _imeino1,String _imeino2,) async {
    setState(() {
      _loading=true;
    });
    print('aaaaaaaaaaaaa');
   final shopId =widget.ShopId;
    print(shopId);
    print(_customername);
    print(_email);
    print(_mobile);
    print(_imeino1);
    print(_imeino2);
    print(widget.deviceData!.name);
    print(widget.deviceData!.brand);
    print(widget.deviceData!.hardware);
    print(widget.deviceData!.model);
    print(widget.deviceData!.serialNumber);
    print(widget.deviceData!.enrollmentTime);
    print(file!.path);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var url = Uri.parse('https://smartlockerindia.com/ajapi/device.php');
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers);
    request.fields["shop_id"]="$shopId";
    request.fields["name"]=_customername;
    request.fields["email"]=_email;
    request.fields["mobile"]=_mobile;
    request.fields["imei1"]=_imeino1;
    request.fields["imei2"]=_imeino2;
    request.fields["deviceID"]=widget.deviceData!.name;
    request.fields["deviceBrand"]=widget.deviceData!.brand;
    request.fields["deviceHard"]=widget.deviceData!.hardware;
    request.fields["deviceMan"]=widget.deviceData!.manufacturer;
    request.fields["deviceModel"]=widget.deviceData!.model;
    request.fields["deviceSno"]=widget.deviceData!.serialNumber;
    request.fields["deviceTime"]=widget.deviceData!.enrollmentTime;
    file!=null?
    request.files.add(await http.MultipartFile.fromPath('photo', file!.path)):'';
    final response = await request.send();
    print("ssssss");
    final responseString = await response.stream.bytesToString();
    final data = json.decode(responseString);
    print(data);
    print("fffff");
    if (data['status'] == '200') {
      setState(() {
        _loading=false;
      });
      final id = data['id'];
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EmiDetail(
        denId:id
      )));
    }
    else {
      setState(() {
        _loading=false;
      });
      Fluttertoast.showToast(
          msg: "Free device not available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }
}