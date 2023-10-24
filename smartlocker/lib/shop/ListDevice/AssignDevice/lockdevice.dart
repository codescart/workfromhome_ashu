import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/devices_controal.dart';



class LockDevice extends StatefulWidget {
  final String? enterpriseId;
  LockDevice({this.enterpriseId});
  @override
  State<LockDevice> createState() => _LockDeviceState();
}



class _LockDeviceState extends State<LockDevice> {
  final _silverColors = const [
    Color(0xFFAEB2B8),
    Color(0xFFC7C9CB),
    Color(0xFFD7D7D8),
    Color(0xFFAEB2B8),
  ];
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Lock Device"),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<List<devicecdata>>(
                      future: deviceData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:   Card(
                                color: Colors.transparent,
                                elevation:5,
                                child: InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceControal(
                                    //   snapshot.data![index],
                                    // )));
                                  },
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
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20,),
                                            Icon(Icons.person,size: 22,),
                                            SizedBox(height: 10,),
                                            Icon(Icons.phone,size: 22,),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20,),
                                            Text(snapshot.data![index].name==null?"Not avl":snapshot.data![index].name!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.bold,fontSize: 18,
                                              ),),
                                            SizedBox(height: 10,),
                                            Text(snapshot.data![index].mobile==null?"Not avl":snapshot.data![index].mobile!,textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.bold,fontSize: 18,
                                              ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ):Center(child: CircularProgressIndicator(color: Color(0xFFebd197),),);
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Future<List<devicecdata>> deviceData() async{
    final response = await http.post(
      Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/alllockdevices'),
      headers: <String, String>{
        'Accept': 'application/json'
      },
      body: json.encode({
        "shop_id":widget.enterpriseId,
      }),
    );

    var data = json.decode(response.body)["data"];
    print(data);
    print('dddddddddddddd');
    List<devicecdata> allround = [];
    for (Map o in data)  {
      devicecdata al = devicecdata(
        o['id'],
        o['shop_id'],
        o['name'],
        o['email'],
        o['mobile'],
        o['imei1'],
        o['imei2'],
        o['deviceID'],
        o['deviceBrand'],
        o['deviceTime'],
        o['deviceHard'],
        o['deviceMan'],
        o['deviceModel'],
        o['deviceSno'],
        o['emi_Amount'],
        o['due_date'],
        o['no_of_ime'],
        o['last_ime_paydate'],
        o['no_of_payimi'],
        o['lock_unlock'],
        o['uninstall'],
        o['deletes'],
        o['photo'],
      );
      allround.add(al);
    }
    return allround;
  }
}



class devicecdata {
  String? id;
  String? shopId;
  String? name;
  String? email;
  String? mobile;
  String? imei1;
  String? imei2;
  String? deviceID;
  String? deviceBrand;
  String? deviceTime;
  String? deviceHard;
  String? deviceMan;
  String? deviceModel;
  String? deviceSno;
  String? emiAmount;
  String? dueDate;
  String? noOfIme;
  String? lastImePaydate;
  String? noOfPayimi;
  String? lockUnlock;
  String? uninstall;
  String? deletes;
  String? photo;

  devicecdata(
      this.id,
      this.shopId,
      this.name,
      this.email,
      this.mobile,
      this.imei1,
      this.imei2,
      this.deviceID,
      this.deviceBrand,
      this.deviceTime,
      this.deviceHard,
      this.deviceMan,
      this.deviceModel,
      this.deviceSno,
      this.emiAmount,
      this.dueDate,
      this.noOfIme,
      this.lastImePaydate,
      this.noOfPayimi,
      this.lockUnlock,
      this.uninstall,
      this.deletes,
      this.photo);}








