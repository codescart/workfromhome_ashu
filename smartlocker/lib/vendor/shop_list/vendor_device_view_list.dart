// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartlocker/vendor/shop_list/device_info.dart';
//
// class DeviceViewList extends StatefulWidget {
//   final String? EnterpriseId;
//    DeviceViewList({this.EnterpriseId});
//
//   @override
//   State<DeviceViewList> createState() => _DeviceViewListState();
// }
//
// class _DeviceViewListState extends State<DeviceViewList> {
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
//
//
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
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("View Device"),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white),
//           ),
//           flexibleSpace: Container(
//             decoration:BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors:  _goldColors ,
//               ),
//             ),
//           ),
//         ),
//         body: FutureBuilder<List<devicelist>>(
//             future: device(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: ((context, index) {
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child:   Card(
//                               color: Colors.transparent,
//                               elevation:5,
//                               child: InkWell(
//                                 onTap: (){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceInfo(
//                                     snapshot.data![index],
//                                   )));
//                                 },
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       width:double.infinity,
//                                       height: 100,
//                                       decoration:  BoxDecoration(
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                           colors:  _silverColors ,
//                                         ),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15,)),
//                                       ),
//                                       child:  Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Column(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(height: 20,),
//                                               Icon(Icons.account_circle,size: 22,),
//                                               SizedBox(height: 10,),
//                                               Icon(Icons.email_outlined,size: 22,),
//                                             ],
//                                           ),
//                                           Column(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(height: 20,),
//                                               Text(snapshot.data![index].state==null?"Not avl":snapshot.data![index].state.toUpperCase(),
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(color: Colors.white,
//                                                   fontWeight: FontWeight.bold,fontSize: 18,
//                                                 ),),
//                                               SizedBox(height: 10,),
//                                               Text(snapshot.data![index].name==null?"Not avl":snapshot.data![index].name,textAlign: TextAlign.center,
//                                                 style: TextStyle(color: Colors.white,
//                                                   fontWeight: FontWeight.bold,fontSize: 18,
//                                                 ),),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Positioned(
//                                         right:0,
//                                         child: IconButton(
//                                           onPressed: ()
//                                           {
//                                             showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context ) {
//                                                   return Dialog(
//                                                     shape:RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(16),
//                                                     ),
//                                                     elevation: 0,
//                                                     backgroundColor: Colors.transparent,
//                                                     child: Container(
//                                                       padding: EdgeInsets.only(top: 10, bottom:10),
//                                                       decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius.circular(16),
//                                                           color: Colors.white,
//                                                           border: Border.all(width: 5, color: Colors.black54)
//                                                       ),
//                                                       width: MediaQuery.of(context).size.width,
//                                                       height: 200,
//                                                       alignment: Alignment.bottomCenter,
//                                                       // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
//                                                       child: Column(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                                         children: [
//                                                           Container(
//                                                             child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
//                                                           ),
//                                                           Container(
//                                                             padding: EdgeInsets.all(10),
//                                                             // color: Colors.black,
//                                                             alignment: Alignment.center,
//                                                             // height:MediaQuery.of(context).size.height/4 ,
//                                                             width: MediaQuery.of(context).size.width/1.1,
//                                                             child:Text("Are you sure?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
//                                                             ),
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                             children: [
//                                                               Container(width: 100, height: 40,
//                                                                 child: ElevatedButton(onPressed: () {
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                   style: ElevatedButton.styleFrom(
//                                                                       primary: Colors.red
//                                                                   ),
//                                                                   child: Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.white),),),
//                                                               ),
//
//                                                               Container(height: 40, width: 100,
//                                                                 child: ElevatedButton(
//                                                                     onPressed: ()
//                                                                     async {
//                                                                       final prefs = await SharedPreferences.getInstance();
//                                                                       final key = 'access';
//                                                                       final accesstoken = prefs.getString(key) ?? 0;
//                                                                       var enterId = snapshot.data![index].name;
//                                                                       final response = await http.delete(
//                                                                         Uri.parse("https://androidmanagement.googleapis.com/v1/$enterId"),
//                                                                         headers: <String, String>{
//                                                                           "Authorization":"Bearer $accesstoken",
//                                                                           'Accept': 'application/json',
//                                                                         },
//                                                                       );
//                                                                       if (response.statusCode == 200) {
//                                                                         Navigator.pop(context);
//                                                                       }
//                                                                       else {
//
//                                                                       }
//                                                                     },
//                                                                     style: ElevatedButton.styleFrom(
//                                                                         primary: Theme.of(context).primaryColor
//                                                                     )
//                                                                     , child: Text("Confirm",style: TextStyle(fontSize: 18),)),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }
//
//                                             );
//                                           },
//
//                                           icon: Icon(Icons.delete, color: Colors.red,),)
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                     )
//                 );
//               }
//               else if(snapshot.hasError){
//                 return Center(child: Text( 'Devices not available .', style: TextStyle(fontSize: 20),));
//               }
//               else {
//                 return  Center(child: CircularProgressIndicator(
//                   color: Color(0xFFebd197),
//                 ));
//               }
//
//             }
//         ),
//       ),
//     );
//   }
//   Future<List<devicelist>> device() async{
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'access';
//     final accesstoken = prefs.getString(key) ?? 0;
//     final enterpriseId = widget.EnterpriseId;
//     final response = await http.get(
//       Uri.parse('https://androidmanagement.googleapis.com/v1/$enterpriseId/devices'),
//       headers: <String, String>{
//         "Authorization":"Bearer $accesstoken",
//         'Accept': 'application/json'
//       },
//     );
//
//     var data = json.decode(response.body)["devices"];
//     print(data);
//     List<devicelist> allround = [];
//     for (Map o in data)  {
//       devicelist al = devicelist(
//           o["name"],
//           o["state"],
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
// }
// class devicelist {
//   String name;
//   String state;
//   String brand;
//   String serialNumber;
//   String hardware;
//   String manufacturer;
//   String model;
//
//   devicelist(
//       this.name,
//       this.state,
//       this.brand,
//       this.serialNumber,
//       this.hardware,
//       this.manufacturer,
//       this.model,
//       );
// }
//
//
//
