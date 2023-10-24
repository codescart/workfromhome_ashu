// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
// // class DeviceList extends StatefulWidget {
// //   final String? enterpriseId;
// //   DeviceList({this.enterpriseId,});
// //   @override
// //   State<DeviceList> createState() => _DeviceListState();
// // }
// //
// // class _DeviceListState extends State<DeviceList> with TickerProviderStateMixin {
// //   final _goldColors = const [
// //     Color(0xFFa2790d),
// //     Color(0xFFebd197),
// //     Color(0xFFa2790d),
// //   ];
// //   final _silverColors = const [
// //     Color(0xFFAEB2B8),
// //     Color(0xFFC7C9CB),
// //     Color(0xFFD7D7D8),
// //     Color(0xFFAEB2B8),
// //   ];
// //
// //
// //   InputDecoration getInputDecoration(String hintext, IconData iconData) {
// //     return InputDecoration(
// //       counter: Offstage(),
// //
// //       enabledBorder: const OutlineInputBorder(
// //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
// //         borderSide: BorderSide(color: Colors.white, width: 2),
// //       ),
// //       focusedBorder: const OutlineInputBorder(
// //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
// //         borderSide: BorderSide(color: Colors.white, width: 2),
// //       ),
// //       border: const OutlineInputBorder(
// //         borderSide: BorderSide(color: Colors.white),
// //         borderRadius: BorderRadius.all(
// //           Radius.circular(12.0),
// //         ),
// //       ),
// //       focusedErrorBorder: const OutlineInputBorder(
// //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
// //         borderSide: BorderSide(color: Color(0xFFF65054)),
// //       ),
// //       errorBorder: const OutlineInputBorder(
// //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
// //         borderSide: BorderSide(color: Color(0xFFF65054)),
// //       ),
// //       filled: true,
// //       prefixIcon: Icon(
// //         iconData,
// //         color:  Color(0xFFebd197),
// //       ),
// //       hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
// //       hintText: hintext,
// //       // fillColor: kBackgroundColor,
// //       contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
// //     );
// //   }
// //
// //   @override
// //   void initState() {
// //     _accessKoken();
// //     super.initState();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         appBar: AppBar(
// //           centerTitle: true,
// //           title: Text("Device List"),
// //           leading: IconButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //             icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
// //           ),
// //           flexibleSpace: Container(
// //             decoration:BoxDecoration(
// //               gradient: LinearGradient(
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //                 colors:  _goldColors ,
// //               ),
// //             ),
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             SizedBox(
// //               height: 20,
// //             ),
// //             Container(
// //               child: Padding(
// //                 padding: EdgeInsets.only(right: 10,left: 10),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: [
// //                     InkWell(
// //                       onTap:(){
// //                         _unassignDevice();
// //                       },
// //                       child: Container(
// //                         child: Text("UnAssign Device"),
// //                       ),
// //                     ),
// //                     InkWell(
// //                       onTap:(){
// //
// //                       },
// //                       child: Container(
// //                         child: Text("UnAssign Device"),
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //               )
// //             ),
// //           ],
// //         )
// //       ),
// //     );
// //   }
// //
// //
// //   // var finaltoken;
// //   // _accessKoken() async {
// //   //   final response = await http.get(
// //   //     Uri.parse("https://smartlockerindia.com/ajapi/api/outhlogin/curl.php"),
// //   //   );
// //   //   final data = jsonDecode(response.body);
// //   //   print(data);
// //   //   print('Ajay');
// //   //   print(response.statusCode);
// //   //   if (response.statusCode == 200) {
// //   //     final token = data['access_token'];
// //   //     setState(() {
// //   //       finaltoken = token;
// //   //     });
// //   //   }else {
// //   //   }
// //   // }
// //   //
// //
// //
// //
// //   // Future<List<deviceclist>> deviceList() async{
// //   //   final enterId = widget.enterpriseId;
// //   //   final response = await http.get(
// //   //     Uri.parse('https://androidmanagement.googleapis.com/v1/$enterId/devices'),
// //   //     headers: <String, String>{
// //   //       "Authorization":"Bearer $finaltoken",
// //   //       'Accept': 'application/json'
// //   //     },
// //   //   );
// //   //
// //   //   var data = json.decode(response.body)["devices"];
// //   //   print(data);
// //   //   print('dddddddddddddd');
// //   //   List<deviceclist> allround = [];
// //   //   for (Map o in data)  {
// //   //     deviceclist al = deviceclist(
// //   //         o["name"],
// //   //         o['enrollmentTime'],
// //   //         o["hardwareInfo"]["brand"],
// //   //         o["hardwareInfo"]["serialNumber"],
// //   //         o["hardwareInfo"]["hardware"],
// //   //         o["hardwareInfo"]["manufacturer"],
// //   //         o["hardwareInfo"]["model"]
// //   //     );
// //   //     allround.add(al);
// //   //   }
// //   //   return allround;
// //   // }
// //
// //
// //
// //
// //   Future<List<devicecdata>> deviceData() async{
// //     final prefs = await SharedPreferences.getInstance();
// //     final key = 'userId';
// //     final userId = prefs.getString(key) ?? 0;
// //     final response = await http.post(
// //       Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/device_list'),
// //       headers: <String, String>{
// //         'Accept': 'application/json'
// //           },
// //            body: json.encode({
// //                 "shop_id":"$userId",
// //               }),
// //          );
// //
// //     var data = json.decode(response.body)["user"];
// //     print(data);
// //     print('dddddddddddddd');
// //     List<devicecdata> allround = [];
// //     for (Map o in data)  {
// //       devicecdata al = devicecdata(
// //           o['id'],
// //           o['shop_id'],
// //           o['name'],
// //           o['email'],
// //           o['mobile'],
// //           o['imei1'],
// //           o['imei2'],
// //           o['deviceID'],
// //           o['deviceBrand'],
// //           o['deviceTime'],
// //           o['deviceHard'],
// //           o['deviceMan'],
// //           o['deviceModel'],
// //           o['deviceSno'],
// //           o['emi_Amount'],
// //           o['due_date'],
// //           o['no_of_ime'],
// //           o['last_ime_paydate'],
// //           o['no_of_payimi'],
// //           o['lock_unlock'],
// //           o['uninstall'],
// //           o['deletes'],
// //           o['photo'],
// //       );
// //       allround.add(al);
// //     }
// //     return allround;
// //   }
// // // var msg=false;
// // //   _checks(String sno,) async{
// // //     final response = await http.get(
// // //       Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/device_c?deviceSno=$sno'),
// // //     );
// // //     var data = json.decode(response.body);
// // //     if (data["error"] == "200") {
// // //      setState(() {
// // //        msg=true;
// // //      });
// // //     }
// // //
// // //   }
// //   _unassignDevice() {
// //     return Container(
// //       width:double.infinity,
// //       height: MediaQuery.of(context).size.height*0.5,
// //       child:Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: FutureBuilder<List<deviceclist>>(
// //             future: deviceList(),
// //             builder: (context, snapshot) {
// //               if (snapshot.hasData) {
// //                 return ListView.builder(
// //                     itemCount: snapshot.data!.length,
// //                     itemBuilder: ((context, index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(10.0),
// //                         child:InkWell(
// //                             onTap: (){
// //                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCustomer(
// //                               //
// //                               // )));
// //                             },
// //                             child: Container(
// //                               width:double.infinity,
// //                               height: 100,
// //                               decoration:  BoxDecoration(
// //                                 gradient: LinearGradient(
// //                                   begin: Alignment.topLeft,
// //                                   end: Alignment.bottomRight,
// //                                   colors:  _silverColors ,
// //                                 ),
// //                                 borderRadius: BorderRadius.all(
// //                                     Radius.circular(15,)),
// //                               ),
// //                               child:  Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                                 children: [
// //                                   Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       SizedBox(height: 20,),
// //                                       Icon(Icons.perm_device_info,size: 22,),
// //                                       SizedBox(height: 10,),
// //                                       Icon(Icons.date_range,size: 22,),
// //                                     ],
// //                                   ),
// //                                   Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       SizedBox(height: 20,),
// //                                       Text(snapshot.data![index].name==null?"Not avl":snapshot.data![index].name.toUpperCase(),
// //                                         textAlign: TextAlign.center,
// //                                         style: TextStyle(color: Colors.white,
// //                                           fontWeight: FontWeight.bold,fontSize: 18,
// //                                         ),),
// //                                       SizedBox(height: 10,),
// //                                       Text(snapshot.data![index].enrollmentTime==null?"Not avl":snapshot.data![index].enrollmentTime,textAlign: TextAlign.center,
// //                                         style: TextStyle(color: Colors.white,
// //                                           fontWeight: FontWeight.bold,fontSize: 18,
// //                                         ),),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                         ));
// //                     }
// //                     )
// //                 );
// //               }
// //               else if(snapshot.hasError){
// //                 return Center(child: Text( 'Devices not available .', style: TextStyle(fontSize: 20),));
// //               }
// //               else {
// //                 return  Center(child: CircularProgressIndicator(
// //                   color: Color(0xFFebd197),
// //                 ));
// //               }
// //
// //             }
// //         ),
// //       ),
// //     );
// //    }
// //
// //
// // }
// // // class deviceclist {
// // //   String name;
// // //   String enrollmentTime;
// // //   String brand;
// // //   String serialNumber;
// // //   String hardware;
// // //   String manufacturer;
// // //   String model;
// // //
// // //   deviceclist(
// // //       this.name,
// // //       this.enrollmentTime,
// // //       this.brand,
// // //       this.serialNumber,
// // //       this.hardware,
// // //       this.manufacturer,
// // //       this.model,
// // //       );
// // // }
// //
//
//
//
// // Positioned(
// //     right:0,
// //     child: IconButton(
// //       onPressed: ()
// //       {
// //         showDialog(
// //             context: context,
// //             builder:
// //                 (BuildContext context ) {
// //               return Dialog(
// //                 shape:RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16),
// //                 ),
// //                 elevation: 0,
// //                 backgroundColor: Colors.transparent,
// //                 child: Container(
// //                   padding: EdgeInsets.only(top: 10, bottom:10),
// //                   decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(16),
// //                       color: Colors.white,
// //                       border: Border.all(width: 5, color: Colors.black54)
// //                   ),
// //                   width: MediaQuery.of(context).size.width,
// //                   height: 200,
// //                   alignment: Alignment.bottomCenter,
// //                   // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Container(
// //                         child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
// //                       ),
// //                       Container(
// //                         padding: EdgeInsets.all(10),
// //                         // color: Colors.black,
// //                         alignment: Alignment.center,
// //                         // height:MediaQuery.of(context).size.height/4 ,
// //                         width: MediaQuery.of(context).size.width/1.1,
// //                         child:Text("Are you sure?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
// //                         ),
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           Container(width: 100, height: 40,
// //                             child: ElevatedButton(onPressed: () {
// //                               Navigator.pop(context);
// //                             },
// //                               style: ElevatedButton.styleFrom(
// //                                   primary: Colors.red
// //                               ),
// //                               child: Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.white),),),
// //                           ),
// //
// //                           Container(height: 40, width: 100,
// //                             child: ElevatedButton(
// //                                 onPressed: ()
// //                                 async {
// //                                   var deviceId = snapshot.data![index].name;
// //                                   final response = await http.delete(
// //                                     Uri.parse("https://androidmanagement.googleapis.com/v1/$deviceId"),
// //                                     headers: <String, String>{
// //                                       "Authorization":"Bearer $finaltoken",
// //                                       'Accept': 'application/json',
// //                                     },
// //                                   );
// //                                   if (response.statusCode == 200) {
// //                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DeviceList()));
// //                                   }
// //                                   else {
// //
// //                                   }
// //                                 },
// //                                 style: ElevatedButton.styleFrom(
// //                                     primary: Theme.of(context).primaryColor
// //                                 )
// //                                 , child: Text("Confirm",style: TextStyle(fontSize: 18),)),
// //                           )
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }
// //
// //         );
// //       },
// //
// //       icon: Icon(Icons.delete, color: Colors.red,),)
// // )
//
//
//
//
//
//
//
// class DeviceList extends StatefulWidget {
//   final String? enterpriseId;
//   DeviceList({this.enterpriseId,});
//
//   @override
//   State<DeviceList> createState() => _DeviceListState();
// }
//
//
// class _DeviceListState extends State<DeviceList> {
//
//
//
//
//   @override
//   void initState() {
//     _accessKoken();
//     super.initState();
//   }
//
//   final _silverColors = const [
//     Color(0xFFAEB2B8),
//     Color(0xFFC7C9CB),
//     Color(0xFFD7D7D8),
//     Color(0xFFAEB2B8),
//   ];
//   final _goldColors = const [
//     Color(0xFFa2790d),
//     Color(0xFFebd197),
//     Color(0xFFa2790d),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//                 appBar: AppBar(
//                 centerTitle: true,
//                  title: Text("Device List"),
//                   leading: IconButton(
//                    onPressed: () {
//                     Navigator.pop(context);
//                    },
//                     icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
//                    ),
//                    flexibleSpace: Container(
//                     decoration:BoxDecoration(
//                     gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors:  _goldColors ,
//                   ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               FutureBuilder<List<deviceclist>>(
//                   future: deviceList(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) print(snapshot.error);
//                     return snapshot.hasData
//                         ? ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       itemCount: snapshot.data!.length,
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         _checks(snapshot.data![index].serialNumber);
//                         return msg==true?Container():Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child:InkWell(
//                               onTap: (){
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCustomer(
//                                 //
//                                 // )));
//                               },
//                               child: Container(
//                                 width:double.infinity,
//                                 height: 100,
//                                 decoration:  BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors:  _silverColors ,
//                                   ),
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(15,)),
//                                 ),
//                                 child:  Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 20,),
//                                         Icon(Icons.perm_device_info,size: 22,),
//                                         SizedBox(height: 10,),
//                                         Icon(Icons.date_range,size: 22,),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 20,),
//                                         Text(snapshot.data![index].name==null?"Not avl":snapshot.data![index].name.toUpperCase(),
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontSize: 18,
//                                           ),),
//                                         SizedBox(height: 10,),
//                                         Text(snapshot.data![index].enrollmentTime==null?"Not avl":snapshot.data![index].enrollmentTime,textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontSize: 18,
//                                           ),),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ));
//                       },
//                     ):Center(child: CircularProgressIndicator(color: Color(0xFFebd197),),);
//                   }
//               ),
//
//
//               FutureBuilder<List<devicecdata>>(
//                   future: deviceData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) print(snapshot.error);
//                     return snapshot.hasData
//                         ? ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       itemCount: snapshot.data!.length,
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child:   Card(
//                             color: Colors.transparent,
//                             elevation:5,
//                             child: InkWell(
//                               onTap: (){
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceControal(
//                                 //   snapshot.data![index],
//                                 // )));
//                               },
//                               child: Container(
//                                 width:double.infinity,
//                                 height: 100,
//                                 decoration:  BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors:  _silverColors ,
//                                   ),
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(15,)),
//                                 ),
//                                 child:  Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 20,),
//                                         Icon(Icons.person,size: 22,),
//                                         SizedBox(height: 10,),
//                                         Icon(Icons.phone,size: 22,),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 20,),
//                                         Text(snapshot.data![index].name==null?"Not avl":snapshot.data![index].name!,
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontSize: 18,
//                                           ),),
//                                         SizedBox(height: 10,),
//                                         Text(snapshot.data![index].mobile==null?"Not avl":snapshot.data![index].mobile!,textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontSize: 18,
//                                           ),),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ):Center(child: CircularProgressIndicator(color: Color(0xFFebd197),),);
//                   }
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   var msg;
//   _checks(String sno,) async{
//     final response = await http.get(
//       Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/device_c?deviceSno=$sno'),
//     );
//     var data = json.decode(response.body);
//     print(data);
//     print("zzzzzzzzz");
//     if (data["error"] == "200") {
//       final fmsg=data["msg"];
//      setState(() {
//        msg=fmsg;
//      });
//     }
//
//   }
//
//
//   var finaltoken;
//   _accessKoken() async {
//     final response = await http.get(
//       Uri.parse("https://smartlockerindia.com/ajapi/api/outhlogin/curl.php"),
//     );
//     final data = jsonDecode(response.body);
//     print(data);
//     print('Ajay');
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       final token = data['access_token'];
//       setState(() {
//         finaltoken = token;
//       });
//     }else {
//     }
//   }
//   Future<List<deviceclist>> deviceList() async{
//     final enterId = widget.enterpriseId;
//     final response = await http.get(
//       Uri.parse('https://androidmanagement.googleapis.com/v1/$enterId/devices'),
//       headers: <String, String>{
//         "Authorization":"Bearer $finaltoken",
//         'Accept': 'application/json'
//       },
//     );
//
//     var data = json.decode(response.body)["devices"];
//     print(data);
//     print('dddddddddddddd');
//     List<deviceclist> allround = [];
//     for (Map o in data)  {
//       deviceclist al = deviceclist(
//           o["name"],
//           o['enrollmentTime'],
//           o["hardwareInfo"]["brand"],
//           o["hardwareInfo"]["serialNumber"],
//           o["hardwareInfo"]["hardware"],
//           o["hardwareInfo"]["manufacturer"],
//           o["hardwareInfo"]["model"]
//       );
//       allround.add(al);
//     }
//     return allround;
//   }
//
//   Future<List<devicecdata>> deviceData() async{
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'userId';
//     final userId = prefs.getString(key) ?? 0;
//     final response = await http.post(
//       Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/device_list'),
//       headers: <String, String>{
//         'Accept': 'application/json'
//           },
//            body: json.encode({
//                 "shop_id":"$userId",
//               }),
//          );
//
//     var data = json.decode(response.body)["user"];
//     print(data);
//     print('dddddddddddddd');
//     List<devicecdata> allround = [];
//     for (Map o in data)  {
//       devicecdata al = devicecdata(
//           o['id'],
//           o['shop_id'],
//           o['name'],
//           o['email'],
//           o['mobile'],
//           o['imei1'],
//           o['imei2'],
//           o['deviceID'],
//           o['deviceBrand'],
//           o['deviceTime'],
//           o['deviceHard'],
//           o['deviceMan'],
//           o['deviceModel'],
//           o['deviceSno'],
//           o['emi_Amount'],
//           o['due_date'],
//           o['no_of_ime'],
//           o['last_ime_paydate'],
//           o['no_of_payimi'],
//           o['lock_unlock'],
//           o['uninstall'],
//           o['deletes'],
//           o['photo'],
//       );
//       allround.add(al);
//     }
//     return allround;
//   }
// }
//
//
//
// class deviceclist {
//   String name;
//   String enrollmentTime;
//   String brand;
//   String serialNumber;
//   String hardware;
//   String manufacturer;
//   String model;
//
//   deviceclist(
//       this.name,
//       this.enrollmentTime,
//       this.brand,
//       this.serialNumber,
//       this.hardware,
//       this.manufacturer,
//       this.model,
//       );
// }
//
// class devicecdata {
//   String? id;
//   String? shopId;
//   String? name;
//   String? email;
//   String? mobile;
//   String? imei1;
//   String? imei2;
//   String? deviceID;
//   String? deviceBrand;
//   String? deviceTime;
//   String? deviceHard;
//   String? deviceMan;
//   String? deviceModel;
//   String? deviceSno;
//   String? emiAmount;
//   String? dueDate;
//   String? noOfIme;
//   String? lastImePaydate;
//   String? noOfPayimi;
//   String? lockUnlock;
//   String? uninstall;
//   String? deletes;
//   String? photo;
//
//   devicecdata(
//       this.id,
//         this.shopId,
//         this.name,
//         this.email,
//         this.mobile,
//         this.imei1,
//         this.imei2,
//         this.deviceID,
//         this.deviceBrand,
//         this.deviceTime,
//         this.deviceHard,
//         this.deviceMan,
//         this.deviceModel,
//         this.deviceSno,
//         this.emiAmount,
//         this.dueDate,
//         this.noOfIme,
//         this.lastImePaydate,
//         this.noOfPayimi,
//         this.lockUnlock,
//         this.uninstall,
//         this.deletes,
//         this.photo);}
//
//
