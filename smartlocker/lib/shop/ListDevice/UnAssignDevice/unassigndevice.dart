import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:smartlocker/shop/ListDevice/UnAssignDevice/add_customer.dart';



class UnAssignList extends StatefulWidget {
  final String? enterpriseId;
  UnAssignList({this.enterpriseId,});

  @override
  State<UnAssignList> createState() => _UnAssignListState();
}



class _UnAssignListState extends State<UnAssignList> {
  @override
  void initState() {

    _accessKoken();
   
    super.initState();
  }

  // List<unassignlist> cartItems = [];
  List<unassignlist> allround = [];

  fetchItems(finaltoken) async {
    final enterId = widget.enterpriseId;
    print(enterId);
    print("raja");
    final response = await http.get(
      Uri.parse('https://androidmanagement.googleapis.com/v1/$enterId/devices'),
      headers: <String, String>{
        "Authorization":"Bearer $finaltoken",
        'Accept': 'application/json'
      },
    );
    final items = json.decode(response.body)['devices'];
    for (var i = 0; i < items.length; i++) {

      final fid= items[i]["hardwareInfo"]["serialNumber"];
      final response = await http.get(
        Uri.parse(
            'https://smartlockerindia.com/ajapi/api/Mobile_app/device_c?deviceSno=$fid'),
      );
      final data = json.decode(response.body);
      print(data);


      if (data["error"] != "200") {

        setState(() {
          allround.add(
              unassignlist(


              )

          );
        });
      }

    }

  }
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
          title: Text("UnAssign List"),
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
        body: ListView(
          children: [
            for (var i = 0; i < allround.length; i++)
              Padding(
              padding: const EdgeInsets.all(10.0),
              child:   Card(
                color: Colors.transparent,
                elevation:5,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCustomer(
                      deviceData:allround[i],
                      ShopId:widget.enterpriseId,
                    )));
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
                            Text(allround[i].brand==null?"Not avl":allround[i].brand,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 18,
                              ),),
                            SizedBox(height: 10,),
                            Text(allround[i].enrollmentTime==null?"Not avl":allround[i].enrollmentTime!,textAlign: TextAlign.center,
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
            )
          ],
        )
      ),
    );
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
      fetchItems(finaltoken);
    }else {
    }
  }
}



class unassignlist {
  String name;
  String enrollmentTime;
  String brand;
  String serialNumber;
  String hardware;
  String manufacturer;
  String model;
  unassignlist({required this.name, required this.enrollmentTime, required this.brand, required this.serialNumber, required this.hardware, required this.manufacturer, required this.model});
}






