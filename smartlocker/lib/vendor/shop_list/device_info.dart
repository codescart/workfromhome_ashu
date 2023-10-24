// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartlocker/vendor/shop_list/vendor_device_view_list.dart';
//
//
// class DeviceInfo extends StatefulWidget {
//   final devicelist lock;
//   DeviceInfo(this.lock);
//
//   @override
//   State<DeviceInfo> createState() => _DeviceInfoState();
// }
//
// class _DeviceInfoState extends State<DeviceInfo> {
//   InputDecoration getInputDecoration(String hintext, IconData iconData) {
//     return InputDecoration(
//       counter: Offstage(),
//
//       enabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//         borderSide: BorderSide(color: Colors.white, width: 2),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//         borderSide: BorderSide(color: Colors.white, width: 2),
//       ),
//       border: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.0),
//         ),
//       ),
//       focusedErrorBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//         borderSide: BorderSide(color: Color(0xFFF65054)),
//       ),
//       errorBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//         borderSide: BorderSide(color: Color(0xFFF65054)),
//       ),
//       filled: true,
//       prefixIcon: Icon(
//         iconData,
//         color:  Color(0xFFebd197),
//       ),
//       hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
//       hintText: hintext,
//       // fillColor: kBackgroundColor,
//       contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//     );
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _displayName = TextEditingController();
//   final _goldColors = const [
//     Color(0xFFa2790d),
//     Color(0xFFebd197),
//     Color(0xFFa2790d),
//   ];
//   final _silverColors = const [
//     Color(0xFFAEB2B8),
//     Color(0xFFC7C9CB),
//     Color(0xFFD7D7D8),
//     Color(0xFFAEB2B8),
//   ];
//   // @override
//   // void initState() {
//   //   enterpriseData();
//   //   super.initState();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text("Device Detail"),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
//               ),
//               flexibleSpace: Container(
//                 decoration:BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors:  _goldColors ,
//                   ),
//                 ),
//               ),
//             ),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 40,),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     color: Colors.transparent,
//                     elevation:5,
//                     child: Container(
//                       width:double.infinity,
//                       height: 70,
//                       decoration:  BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors:  _silverColors ,
//                         ),
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(8,)),
//                       ),
//                       child:Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 38.0),
//                             child: Center(
//                                 child: Text("Add Name".toUpperCase(),
//                                   style: TextStyle(color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 25
//                                   ),
//                                 )
//
//                             ),
//                           ),
//                           Spacer(),
//                           IconButton(icon: Icon(Icons.edit), onPressed: () {  },)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   child: Text("Hardware Info",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w600),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     color: Colors.transparent,
//                     elevation:5,
//                     child: Container(
//                       width:double.infinity,
//                       // height: 200,
//                       decoration:  BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors:  _silverColors ,
//                         ),
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(8,)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 20,),
//                               Text("brand".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text("hardware".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text("manufacturer".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text("serialNumber".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text("model".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 20,),
//                               Text(widget.lock.brand,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text(widget.lock.hardware,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text(widget.lock.manufacturer,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text(widget.lock.serialNumber,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                               SizedBox(height: 10,),
//                               Text(widget.lock.model,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600),),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Padding(
//                 //       padding: const EdgeInsets.all(8.0),
//                 //       child: Card(
//                 //         color: Colors.transparent,
//                 //         elevation:12,
//                 //         child: InkWell(
//                 //           onTap: ()  {
//                 //             showDialog(
//                 //                 context: context,
//                 //                 builder:
//                 //                     (BuildContext context ) {
//                 //                   return Dialog(
//                 //                     shape:RoundedRectangleBorder(
//                 //                       borderRadius: BorderRadius.circular(16),
//                 //                     ),
//                 //                     elevation: 0,
//                 //                     backgroundColor: Colors.transparent,
//                 //                     child: Container(
//                 //                       padding: EdgeInsets.only(top: 10, bottom:10),
//                 //                       decoration: BoxDecoration(
//                 //                           borderRadius: BorderRadius.circular(16),
//                 //                           color: Colors.white,
//                 //                           border: Border.all(width: 5, color: Colors.black54)
//                 //                       ),
//                 //                       width: MediaQuery.of(context).size.width,
//                 //                       height: 200,
//                 //                       alignment: Alignment.bottomCenter,
//                 //                       // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
//                 //                       child: Column(
//                 //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //                         crossAxisAlignment: CrossAxisAlignment.center,
//                 //                         children: [
//                 //                           Container(
//                 //                             child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
//                 //                           ),
//                 //                           Container(
//                 //                             padding: EdgeInsets.all(10),
//                 //                             // color: Colors.black,
//                 //                             alignment: Alignment.center,
//                 //                             // height:MediaQuery.of(context).size.height/4 ,
//                 //                             width: MediaQuery.of(context).size.width/1.1,
//                 //                             child:Text("Are you sure?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
//                 //                             ),
//                 //                           ),
//                 //                           Row(
//                 //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //                             children: [
//                 //                               Container(width: 100, height: 40,
//                 //                                 child: ElevatedButton(onPressed: () {
//                 //                                   Navigator.pop(context);
//                 //                                 },
//                 //                                   style: ElevatedButton.styleFrom(
//                 //                                       primary: Colors.red
//                 //                                   ),
//                 //                                   child: Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.white),),),
//                 //                               ),
//                 //
//                 //                               Container(height: 40, width: 100,
//                 //                                 child: ElevatedButton(
//                 //                                     onPressed: ()
//                 //                                     {
//                 //                                       Removelock();
//                 //                                     },
//                 //                                     style: ElevatedButton.styleFrom(
//                 //                                         primary: Theme.of(context).primaryColor
//                 //                                     )
//                 //                                     , child: Text("Confirm",style: TextStyle(fontSize: 18),)),
//                 //                               )
//                 //                             ],
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                   );
//                 //                 }
//                 //
//                 //             );
//                 //           },
//                 //           child: Container(
//                 //             width:200,
//                 //             height: 50,
//                 //             decoration:  BoxDecoration(
//                 //               gradient: LinearGradient(
//                 //                 begin: Alignment.topLeft,
//                 //                 end: Alignment.bottomRight,
//                 //                 colors:  _goldColors ,
//                 //               ),
//                 //               borderRadius: BorderRadius.all(
//                 //                   Radius.circular(15,)),
//                 //             ),
//                 //             child:  Padding(
//                 //               padding: EdgeInsets.all(8),
//                 //               child: Center(
//                 //                 child: Text("Remove Lock",textAlign: TextAlign.center,
//                 //                     style: TextStyle(color: Colors.white,
//                 //                       fontWeight: FontWeight.bold,fontSize: 22,
//                 //                     )),
//                 //               ),
//                 //
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     Padding(
//                 //       padding: const EdgeInsets.all(8.0),
//                 //       child: Card(
//                 //         color: Colors.transparent,
//                 //         elevation:12,
//                 //         child: InkWell(
//                 //
//                 //           onTap: ()  {
//                 //             showDialog(
//                 //                 context: context,
//                 //                 builder:
//                 //                     (BuildContext context ) {
//                 //                   return Dialog(
//                 //                     shape:RoundedRectangleBorder(
//                 //                       borderRadius: BorderRadius.circular(16),
//                 //                     ),
//                 //                     elevation: 0,
//                 //                     backgroundColor: Colors.transparent,
//                 //                     child: Container(
//                 //                       padding: EdgeInsets.only(top: 10, bottom:10),
//                 //                       decoration: BoxDecoration(
//                 //                           borderRadius: BorderRadius.circular(16),
//                 //                           color: Colors.white,
//                 //                           border: Border.all(width: 5, color: Colors.black54)
//                 //                       ),
//                 //                       width: MediaQuery.of(context).size.width,
//                 //                       height: 250,
//                 //                       alignment: Alignment.bottomCenter,
//                 //                       // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
//                 //                       child: Form(
//                 //                         key: _formKey,
//                 //                         child: Column(
//                 //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //                           crossAxisAlignment: CrossAxisAlignment.center,
//                 //                           children: [
//                 //                             Container(
//                 //                               child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
//                 //                             ),
//                 //                             Container(
//                 //                               padding: EdgeInsets.all(10),
//                 //                               // color: Colors.black,
//                 //                               alignment: Alignment.center,
//                 //                               // height:MediaQuery.of(context).size.height/4 ,
//                 //                               width: MediaQuery.of(context).size.width/1.1,
//                 //                               child:Text("Are you sure?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
//                 //                               ),
//                 //                             ),
//                 //                             Align(
//                 //                               alignment: Alignment.centerLeft,
//                 //                               child: Padding(
//                 //                                 padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
//                 //                                 child: Text(
//                 //                                   'Password',
//                 //                                   style: TextStyle(
//                 //                                     fontSize: 16,
//                 //                                     fontWeight: FontWeight.w400,
//                 //                                   ),
//                 //                                 ),
//                 //                               ),
//                 //                             ),
//                 //                             Padding(
//                 //                               padding: const EdgeInsets.only(
//                 //                                   left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
//                 //                               child: TextFormField(
//                 //                                 cursorColor: Color(0xFFebd197),
//                 //                                 maxLength: 30,
//                 //                                 keyboardType: TextInputType.name,
//                 //                                 style: const TextStyle(fontSize: 14),
//                 //                                 decoration: getInputDecoration(
//                 //                                   'Enter Password',
//                 //                                   Icons.mobile_screen_share_outlined,
//                 //                                 ),
//                 //                                 controller: _displayName,
//                 //                                 validator: (value) {
//                 //                                   if (value == null || value.isEmpty) {
//                 //                                     return 'Please enter Display Name';
//                 //                                   }
//                 //                                   return null;
//                 //                                 },
//                 //                                 // keyboardType: TextInputType.name,
//                 //
//                 //                               ),
//                 //                             ),
//                 //                             Row(
//                 //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //                               children: [
//                 //                                 Container(width: 100, height: 40,
//                 //                                   child: ElevatedButton(onPressed: () {
//                 //                                     Navigator.pop(context);
//                 //                                   },
//                 //                                     style: ElevatedButton.styleFrom(
//                 //                                         primary: Colors.red
//                 //                                     ),
//                 //                                     child: Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.white),),),
//                 //                                 ),
//                 //
//                 //                                 Container(height: 40, width: 100,
//                 //                                   child: ElevatedButton(
//                 //                                       onPressed: () {
//                 //                                         lockDevice(_displayName.text);
//                 //                                       },
//                 //                                       style: ElevatedButton.styleFrom(
//                 //                                           primary: Theme.of(context).primaryColor
//                 //                                       )
//                 //                                       , child: Text("Confirm",style: TextStyle(fontSize: 18),)),
//                 //                                 )
//                 //                               ],
//                 //                             ),
//                 //                           ],
//                 //                         ),
//                 //                       ),
//                 //                     ),
//                 //                   );
//                 //                 }
//                 //
//                 //             );
//                 //           },
//                 //
//                 //           child: Container(
//                 //             width:200,
//                 //             height: 50,
//                 //             decoration:  BoxDecoration(
//                 //               gradient: LinearGradient(
//                 //                 begin: Alignment.topLeft,
//                 //                 end: Alignment.bottomRight,
//                 //                 colors:  _silverColors ,
//                 //               ),
//                 //               borderRadius: BorderRadius.all(
//                 //                   Radius.circular(15,)),
//                 //             ),
//                 //             child:  Padding(
//                 //               padding: EdgeInsets.all(8),
//                 //               child: Center(
//                 //                 child: Text("Lock Device",textAlign: TextAlign.center,
//                 //                     style: TextStyle(color: Colors.white,
//                 //                       fontWeight: FontWeight.bold,fontSize: 22,
//                 //                     )),
//                 //               ),
//                 //
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             )
//         )
//     );
//   }
//   // lockDevice(String _displayName) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final key = 'access';
//   //   final accesstoken = prefs.getString(key) ?? 0;
//   //   print(accesstoken);
//   //   var bhantu =widget.lock.name;
//   //   final response = await http.post(
//   //     Uri.parse("https://androidmanagement.googleapis.com/v1/$bhantu:issueCommand"),
//   //     headers: {
//   //       "Authorization":"Bearer $accesstoken",
//   //       "Accept": "application/json",
//   //       "Content-Type": "application/json"
//   //     },
//   //     body: json.encode({
//   //       "type":"RESET_PASSWORD",
//   //       "newPassword":_displayName
//   //     }),
//   //   );
//   //   if (response.statusCode == 200) {
//   //     Fluttertoast.showToast(
//   //         msg: "Locked Device Successfully",
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.CENTER,
//   //         timeInSecForIosWeb: 1,
//   //         backgroundColor: Colors.green,
//   //         textColor: Colors.white,
//   //         fontSize: 10.0);
//   //     Navigator.pop(context);
//   //   }else {
//   //     Fluttertoast.showToast(
//   //         msg: "Faild To Lock Device",
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.CENTER,
//   //         timeInSecForIosWeb: 1,
//   //         backgroundColor: Colors.red,
//   //         textColor: Colors.white,
//   //         fontSize: 10.0);
//   //     // throw Exception('Could not update data');
//   //   }
//   // }
//   // Removelock() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final key = 'access';
//   //   final accesstoken = prefs.getString(key) ?? 0;
//   //   var bhantu =widget.lock.name;
//   //   print(accesstoken);
//   //   final response = await http.post(
//   //     Uri.parse("https://androidmanagement.googleapis.com/v1/$bhantu:issueCommand"),
//   //     headers: {
//   //       "Authorization":"Bearer $accesstoken",
//   //       "Accept": "application/json",
//   //       "Content-Type": "application/json"
//   //     },
//   //     body: json.encode({
//   //       "type":"RESET_PASSWORD",
//   //       "newPassword":""
//   //     }),
//   //   );
//   //   // final dada = jsonDecode(response.body);
//   //   // print(dada);
//   //   // print('Ajay');
//   //   // print(response.statusCode);
//   //   if (response.statusCode == 200) {
//   //     Fluttertoast.showToast(
//   //         msg: "Remove Lock Successfully",
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.CENTER,
//   //         timeInSecForIosWeb: 1,
//   //         backgroundColor: Colors.green,
//   //         textColor: Colors.white,
//   //         fontSize: 10.0);
//   //     Navigator.pop(context);
//   //   }else {
//   //     Fluttertoast.showToast(
//   //         msg: "Faild To Remove Lock",
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.CENTER,
//   //         timeInSecForIosWeb: 1,
//   //         backgroundColor: Colors.red,
//   //         textColor: Colors.white,
//   //         fontSize: 10.0);
//   //     // throw Exception('Could not update data');
//   //   }
//   // }
// }
