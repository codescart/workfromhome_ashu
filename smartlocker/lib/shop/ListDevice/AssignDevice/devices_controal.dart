import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/shop/ListDevice/AssignDevice/assigndevice.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/update_customer.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/update_emi_detail.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/viewUserContact.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/viewUserLocation.dart';
import 'package:smartlocker/shop/QrGenerate/user_qr_page.dart';
import 'package:smartlocker/shop/shophome.dart';

class DeviceControal extends StatefulWidget {
  final devicecdata lockk;
  DeviceControal(
    this.lockk,
  );

  @override
  State<DeviceControal> createState() => _DeviceControalState();
}

class _DeviceControalState extends State<DeviceControal>
    with TickerProviderStateMixin {
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

  final TextEditingController _displayName = TextEditingController();
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];
  final _silverColors = const [
    Color(0xFFAEB2B8),
    Color(0xFFC7C9CB),
    Color(0xFFD7D7D8),
    Color(0xFFAEB2B8),
  ];

  @override
  void initState() {
    _accessKoken();
    super.initState();
  }

  // bool loading1=false;
  // bool loading2=false;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Customer Detail"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                User_QR_Page(UserId: widget.lockk.id)));
                  },
                  icon: Icon(Icons.qr_code_2, size: 30, color: Colors.white),
                ),
              ],
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
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 12,
                    child: widget.lockk.lockUnlock == "1"
                        ? InkWell(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "Device is allready unlock",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 10.0);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _silverColors,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  8,
                                )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.lock_open,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      Text("UnLock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 5,
                                                color: Colors.black54)),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        alignment: Alignment.bottomCenter,
                                        // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.warning_amber,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              // color: Colors.black,
                                              alignment: Alignment.center,
                                              // height:MediaQuery.of(context).size.height/4 ,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              child: Text(
                                                "Are you sure?",
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Removelock();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                      child: Text(
                                                        "Confirm",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _goldColors,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  8,
                                )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.lock_open,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      Text("UnLock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 12,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 5, color: Colors.black54)),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  alignment: Alignment.bottomCenter,
                                  // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.warning_amber,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        // color: Colors.black,
                                        alignment: Alignment.center,
                                        // height:MediaQuery.of(context).size.height/4 ,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Text(
                                          "Are you sure?",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 100,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  _deleatDevice();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Theme.of(context)
                                                        .primaryColor),
                                                child: Text(
                                                  "Confirm",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _goldColors,
                            ),
                            shape: BoxShape.circle
                            // borderRadius: BorderRadius.all(
                            //     Radius.circular(8,)),
                            ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 12,
                    child: widget.lockk.lockUnlock != "1"
                        ? InkWell(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "This device is allready locked",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 10.0);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _silverColors,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  8,
                                )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.lock_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text("Lock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 5,
                                                color: Colors.black54)),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 250,
                                        alignment: Alignment.bottomCenter,
                                        // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.warning_amber,
                                                  size: 50,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                // color: Colors.black,
                                                alignment: Alignment.center,
                                                // height:MediaQuery.of(context).size.height/4 ,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.1,
                                                child: Text(
                                                  "Are you sure?",
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 17.0, bottom: 5.0),
                                                  child: Text(
                                                    'Password',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    top: 0.0,
                                                    right: 15.0,
                                                    bottom: 8.0),
                                                child: TextFormField(
                                                  cursorColor:
                                                      Color(0xFFebd197),
                                                  maxLength: 30,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  decoration:
                                                      getInputDecoration(
                                                    'Enter Password',
                                                    Icons
                                                        .mobile_screen_share_outlined,
                                                  ),
                                                  controller: _displayName,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter Display Name';
                                                    }
                                                    return null;
                                                  },
                                                  // keyboardType: TextInputType.name,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.red),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          lockDevice(
                                                              _displayName
                                                                  .text);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                        child: Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _goldColors,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  8,
                                )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.lock_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text("Lock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, right: 20, left: 20),
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _silverColors,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                          8,
                        )),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  widget.lockk.deviceBrand!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  widget.lockk.deviceModel!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              child: TextButton(
                            onPressed: () {},
                            child: Text(
                              widget.lockk.lockUnlock != "1"
                                  ? 'Locked Device'
                                  : 'Device is Unlock',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Card(
                //     color: Colors.transparent,
                //     elevation:12,
                //     child: InkWell(
                //       onTap: ()  {
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>User_QR_Page(
                //           UserId:widget.lockk.id,)));
                //       },
                //       child: Container(
                //         width:double.infinity,
                //         height: 45,
                //         decoration:  BoxDecoration(
                //           gradient: LinearGradient(
                //             begin: Alignment.topLeft,
                //             end: Alignment.bottomRight,
                //             colors:  _goldColors ,
                //           ),
                //           borderRadius: BorderRadius.all(
                //               Radius.circular(15,)),
                //         ),
                //         child:  Padding(
                //           padding: EdgeInsets.all(8),
                //           child: Center(
                //             child: Text("Activate User",textAlign: TextAlign.center,
                //               style: TextStyle(color: Colors.white,
                //                 fontWeight: FontWeight.bold,fontSize: 22,
                //               ),),
                //           ),
                //
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _silverColors,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                        25,
                      )),
                    ),
                    indicatorPadding: EdgeInsets.only(right: 15, left: 15),
                    unselectedLabelColor: Color(0xFFebd197),
                    tabs: [
                      Tab(
                          child: Text(
                        "Emi Info",
                      )),
                      Tab(
                          child: Text(
                        "Owner Info",
                      )),
                      Tab(
                          child: Text(
                        "Device Info",
                      )),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _silverColors,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                8,
                              )),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "IMEI Amount : ".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Due Date : ".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Last EMI Pay Date : ".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Total no of EMI : ".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "No Of Paid EMI".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        widget.lockk == null
                                            ? Text("")
                                            : Text(
                                                widget.lockk.emiAmount == null
                                                    ? "Update"
                                                    : widget.lockk.emiAmount!,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        widget.lockk == null
                                            ? Text("")
                                            : Text(
                                                widget.lockk.dueDate == null
                                                    ? "Update"
                                                    : widget.lockk.dueDate!,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        widget.lockk == null
                                            ? Text("")
                                            : Text(
                                                widget.lockk.lastImePaydate ==
                                                        null
                                                    ? "Update Date"
                                                    : widget
                                                        .lockk.lastImePaydate!,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        widget.lockk == null
                                            ? Text("")
                                            : Text(
                                                widget.lockk.noOfIme == null
                                                    ? "Update"
                                                    : widget.lockk.noOfIme!,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        widget.lockk == null
                                            ? Text("")
                                            : Text(
                                                widget.lockk.noOfPayimi == null
                                                    ? "0"
                                                    : widget.lockk.noOfPayimi!,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 12,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateEmiDetail(
                                                      denId: widget.lockk.id,
                                                      duDate:
                                                          widget.lockk.dueDate,
                                                      lepDate:
                                                          widget.lockk.dueDate,
                                                      tnoEmi:
                                                          widget.lockk.dueDate,
                                                      nopEmi:
                                                          widget.lockk.dueDate,
                                                    )));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: _goldColors,
                                          ),
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(
                                            15,
                                          )),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              "UPDATE",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _silverColors,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                8,
                              )),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Full Name : ".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Email : ".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Mobile No : ".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "IMEI No : ".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "IMEI No : ".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Card(
                                            color: Colors.transparent,
                                            elevation: 12,
                                            child: InkWell(
                                              onTap: () {
                                                _getcontact();
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: _goldColors,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    15,
                                                  )),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                      "Get Contact",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: Colors.transparent,
                                            elevation: 12,
                                            child: InkWell(
                                              onTap: () {
                                                _getlocation();
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: _goldColors,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    15,
                                                  )),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                      "Get Location",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            widget.lockk.name!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.lockk.email!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.lockk.mobile!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.lockk.imei1!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.lockk.imei2!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Card(
                                            color: Colors.transparent,
                                            elevation: 12,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewContact(
                                                                userId: widget
                                                                    .lockk
                                                                    .id)));
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: _goldColors,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    15,
                                                  )),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                      "View Contact",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: Colors.transparent,
                                            elevation: 12,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserLocation(
                                                                UserId: widget
                                                                    .lockk
                                                                    .id)));
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.topLeft,
                                                    end: Alignment
                                                        .bottomRight,
                                                    colors: _goldColors,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    15,
                                                  )),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                      "View Location",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 12,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateCustomer(
                                                        denId: widget.lockk.id,
                                                        name: widget.lockk.name,
                                                        email:
                                                            widget.lockk.email,
                                                        phone:
                                                            widget.lockk.mobile,
                                                      )));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: _goldColors,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                              15,
                                            )),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                "Update",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _silverColors,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                8,
                              )),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "brand".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "hardware".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "manufacturer".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "serialNumber".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "model".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      widget.lockk.deviceBrand!,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.lockk.deviceHard!,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.lockk.deviceMan!,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.lockk.deviceSno!,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.lockk.deviceModel!,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  var finaltoken;
  _accessKoken() async {
    final response = await http.get(
      Uri.parse("https://smartlockerindia.com/ajapi/api/outhlogin/curl.php"),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('Ajay');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final token = data['access_token'];
      setState(() {
        finaltoken = token;
      });
    } else {}
  }

  lockDevice(String _displayName) async {
    var deviceId = widget.lockk.deviceID;
    print(deviceId);
    final response = await http.post(
      Uri.parse(
          "https://androidmanagement.googleapis.com/v1/$deviceId:issueCommand"),
      headers: {
        "Authorization": "Bearer $finaltoken",
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body:
          json.encode({"type": "RESET_PASSWORD", "newPassword": _displayName}),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("ccccccccc");
    if (response.statusCode == 200) {
      await http.post(
        Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/add_lock"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userid": widget.lockk.shopId,
          "devicesno": widget.lockk.deviceSno
        }),
      );
      Fluttertoast.showToast(
          msg: "Locked Device Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShopHome()));
    } else {
      Fluttertoast.showToast(
          msg: "Faild To Lock Device",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  Removelock() async {
    var deviceId = widget.lockk.deviceID;
    final response = await http.post(
      Uri.parse(
          "https://androidmanagement.googleapis.com/v1/$deviceId:issueCommand"),
      headers: {
        "Authorization": "Bearer $finaltoken",
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: json.encode({"type": "RESET_PASSWORD", "newPassword": ""}),
    );
    // final dada = jsonDecode(response.body);
    // print(dada);
    // print('Ajay');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      await http.post(
        Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/un_lock"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userid": widget.lockk.shopId,
          "devicesno": widget.lockk.deviceSno
        }),
      );
      Fluttertoast.showToast(
          msg: "Remove Lock Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShopHome()));
    } else {
      Fluttertoast.showToast(
          msg: "Faild To Remove Lock",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  _deleatDevice() async {
    var deviceId = widget.lockk.deviceID;
    final response = await http.delete(
      Uri.parse("https://androidmanagement.googleapis.com/v1/$deviceId"),
      headers: {
        "Authorization": "Bearer $finaltoken",
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    // final dada = jsonDecode(response.body);
    // print(dada);
    // print('Ajay');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Device Delete Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pop(context);
    } else {
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

  _getcontact() async {
    print('bbbbbb');
    final response = await http.post(
      Uri.parse(
          "https://smartlockerindia.com/ajapi/api/Mobile_app/contactstatus"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"userid": widget.lockk.id}),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('tttttttttttttttt');
    if (data["error"] == "200") {
      Fluttertoast.showToast(
          msg: "Wait For Two Minutes",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }

  _getlocation() async {
    print('vvvvvvvvv');
    final response = await http.post(
      Uri.parse(
          "https://smartlockerindia.com/ajapi/api/Mobile_app/locationstatus"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"userid": widget.lockk.id}),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('tttttttttttttttt');
    if (data["error"] == "200") {
      Fluttertoast.showToast(
          msg: 'Wait For Two Minutes"',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }
}
