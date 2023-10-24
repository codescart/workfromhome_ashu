// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartlocker/vendor/shop_list/get_enterprise_data.dart';
// import 'package:smartlocker/vendor/vendor_home.dart';
//
// class SalesShopList extends StatefulWidget {
//   final String? para;
//   final String? id;
//
//   SalesShopList({Key? key, this.para, this.id}) : super(key: key);
//
//   @override
//   State<SalesShopList> createState() => _SalesShopListState();
// }
//
// class _SalesShopListState extends State<SalesShopList> {
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
//           title: Text("Shop List"),
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
//         body: FutureBuilder<List<shoplist>>(
//             future: _shopData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) print(snapshot.error);
//               return snapshot.hasData
//                   ? ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: ((context, index) {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child:   Card(
//                             color: Colors.transparent,
//                             elevation:5,
//                             child: Container(
//                               width:double.infinity,
//                               height: 100,
//                               decoration:  BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors:  _silverColors ,
//                                 ),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(15,)),
//                               ),
//                               child:  Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: 20,),
//                                       Icon(Icons.account_circle,size: 22,),
//                                       SizedBox(height: 10,),
//                                       Icon(Icons.email_outlined,size: 22,),
//                                     ],
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: 20,),
//                                       Text(snapshot.data![index].username!,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(color: Colors.white,
//                                           fontWeight: FontWeight.bold,fontSize: 18,
//                                         ),),
//                                       SizedBox(height: 10,),
//                                       Text(snapshot.data![index].mobile!,textAlign: TextAlign.center,
//                                         style: TextStyle(color: Colors.white,
//                                           fontWeight: FontWeight.bold,fontSize: 18,
//                                         ),),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                   )
//               ):Center(child: CircularProgressIndicator(
//                 color: Color(0xFFebd197),
//               ));
//             }
//         ),
//       ),
//     );
//   }
//   Future<List<shoplist>> _shopData() async {
//     print('raja');
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'userId';
//     final userId = prefs.getString(key) ?? "0";
//     print(userId);
//     final paras=widget.para ==null?'id=$userId':
//     widget.para!+widget.id!;
//     var url = Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/alssuserlist?$paras&type=2");
//     print(url);
//     var response = await http.get(url);
//     var data = json.decode(response.body)['user'];
//     print(data);
//     print('janu');
//     List<shoplist> allround = [];
//     for (var o in data) {
//       shoplist al = shoplist(
//         o["id"],
//         o["dname"],
//         o["contact_email"],
//         o["dp_officername"],
//         o["dp_officer_phone"],
//         o["dp_officer_email"],
//         o["r_officer_name"],
//         o["r_officer_phone"],
//         o["r_officer_email"],
//         o["shop_id"],
//         o["user_id"],
//         o["status"],
//         o["username"],
//         o["type"],
//         o["mobile"],
//         o["email"],
//         o["address"],
//         o["total_device"],
//         o["blocked_devices"],
//         o["unblocked_devices"],
//         o["free_devices"],
//       );
//       allround.add(al);
//     }
//     return allround;
//   }
// }
//
//
//
// class shoplist {
//   String? id;
//   String? dname;
//   String? contact_email;
//   String? dp_officername;
//   String? dp_officer_phone;
//   String? dp_officer_email;
//   String? r_officer_name;
//   String? r_officer_phone;
//   String? r_officer_email;
//   String? shop_id;
//   String? user_id;
//   String? status;
//   String? username;
//   String? type;
//   String? mobile;
//   String? email;
//   String? address;
//   String? total_device;
//   String? blocked_devices;
//   String? unblocked_devices;
//   String? free_devices;
//
//
//   shoplist(
//       this.id,
//       this.dname,
//       this.contact_email,
//       this.dp_officername,
//       this.dp_officer_phone,
//       this.dp_officer_email,
//       this.r_officer_name,
//       this.r_officer_phone,
//       this.r_officer_email,
//       this.shop_id,
//       this.user_id,
//       this.status,
//       this.username,
//       this.type,
//       this.mobile,
//       this.email,
//       this.address,
//       this.total_device,
//       this.blocked_devices,
//       this.unblocked_devices,
//       this.free_devices);
// }