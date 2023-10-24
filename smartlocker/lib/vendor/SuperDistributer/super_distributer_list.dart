import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/vendor/Drstributer/distributer_list.dart';

class SuperDistributer extends StatefulWidget {
  const SuperDistributer({Key? key}) : super(key: key);

  @override
  State<SuperDistributer> createState() => _SuperDistributerState();
}

class _SuperDistributerState extends State<SuperDistributer> {
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Super Distributer"),
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
        body: FutureBuilder<List<superdist>>(
            future: _superDist(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Distributer(para:'supdist=', id:snapshot.data![index].id)));
                          },
                          child: Card(
                            color: Colors.transparent,
                            elevation:5,
                            child: Container(
                                width:double.infinity,
                                height: 100,
                                decoration:  BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors:  _silverColors ,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15,)),
                                ),
                                child: ListTile(
                                    title: Container(
                                      // padding:EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.account_circle,size: 22,),
                                          Icon(Icons.phone,size: 22,)
                                        ],
                                      ),
                                    ),
                                    leading: Padding(
                                      padding:EdgeInsets.only(top:5),
                                      child:  Container(
                                          width:150,
                                          height:70,
                                          decoration:  BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors:  _goldColors ,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15,)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Avalable Balance",style: TextStyle(fontWeight: FontWeight.bold)),
                                              Text("${snapshot.data![index].free_devices}"),
                                            ],
                                          )
                                      ),
                                    ),
                                    trailing: Container(
                                      // padding:EdgeInsets.only(top: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:CrossAxisAlignment.end,
                                        children: [
                                          Text("${snapshot.data![index].username}"),
                                          Text("+91 "+"${snapshot.data![index].mobile}"),
                                        ],
                                      ),
                                    )
                                )
                            ),
                          ),
                        )
                    );
                  }
                  )
              ):Center(child: CircularProgressIndicator(
                color: Color(0xFFebd197),
              ));
            }
        ),
      ),
    );
  }
}




Future<List<superdist>> _superDist() async {
  print('raja');
  final prefs = await SharedPreferences.getInstance();
  final key = 'userId';
  final userId = prefs.getString(key) ?? "0";
  var url = Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/alssuserlist?id=$userId&type=3");
  print(url);
  var response = await http.get(url);
  var data = json.decode(response.body)['user'];
  print(data);
  print('janu');
  List<superdist> allround = [];
  for (var o in data) {
    superdist al = superdist(
      o["id"],
      o["dname"],
      o["contact_email"],
      o["dp_officername"],
      o["dp_officer_phone"],
      o["dp_officer_email"],
      o["r_officer_name"],
      o["r_officer_phone"],
      o["r_officer_email"],
      o["shop_id"],
      o["user_id"],
      o["status"],
      o["username"],
      o["type"],
      o["mobile"],
      o["email"],
      o["address"],
      o["total_device"],
      o["blocked_devices"],
      o["unblocked_devices"],
      o["free_devices"],
      o["supdis"],
      o["dist"],
      o["sales"],
    );
    allround.add(al);
  }
  return allround;
}

class superdist {
  String? id;
  String? dname;
  String? contact_email;
  String? dp_officername;
  String? dp_officer_phone;
  String? dp_officer_email;
  String? r_officer_name;
  String? r_officer_phone;
  String? r_officer_email;
  String? shop_id;
  String? user_id;
  String? status;
  String? username;
  String? type;
  String? mobile;
  String? email;
  String? address;
  String? total_device;
  String? blocked_devices;
  String? unblocked_devices;
  String? free_devices;
  String? supdis;
  String? dist;
  String? sales;


  superdist(
      this.id,
      this.dname,
      this.contact_email,
      this.dp_officername,
      this.dp_officer_phone,
      this.dp_officer_email,
      this.r_officer_name,
      this.r_officer_phone,
      this.r_officer_email,
      this.shop_id,
      this.user_id,
      this.status,
      this.username,
      this.type,
      this.mobile,
      this.email,
      this.address,
      this.total_device,
      this.blocked_devices,
      this.unblocked_devices,
      this.free_devices,
      this.supdis,
      this.dist,
      this.sales,
      );
}