import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/login/pin_login.dart';
import 'package:smartlocker/previcy_policy.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/assigndevice.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/lockdevice.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/unlockdevice.dart';
import 'package:smartlocker/shop/ListDevice/UnAssignDevice/unassigndevice.dart';
import 'package:smartlocker/shop/QrGenerate/qr_page.dart';
import 'package:http/http.dart' as http;

class ShopHome extends StatefulWidget {
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {

  @override
  void initState() {
    _shopProfile();
    super.initState();
  }

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
  Widget build(BuildContext context) {
    List<MenuTile> _menu = [
      MenuTile(title:"QR", iconData: Icons.qr_code_2, onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>QR_Code(shopId: data['shop_id'])));
      },),
      MenuTile(title:"UnAssign List", iconData: Icons.add_moderator, onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnAssignList(enterpriseId: data['shop_id'])));
      }),
      MenuTile(title:"Assign List", iconData: Icons.add_moderator, onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AssignList(enterpriseId: data['shop_id'])));
      }),
      MenuTile(title:"Lock Device",subtitle:data == null ? "" : data['blocked_devices'], onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LockDevice(enterpriseId: data['shop_id'])));
      }),
      MenuTile(title:"Unlock Device",subtitle:data == null ? "" : data['unblocked_devices'], onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnlockDevice(enterpriseId: data['shop_id'])));
      }),
      MenuTile(title:"Privacy Policy", iconData: Icons.policy, onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
      }),
      MenuTile(title:"LOG OUT", iconData: Icons.exit_to_app, onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('userType');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PinLogin()));
      }),
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: Image.asset("assets/images/mainlogo12.png"),
        title: Text("Smart Locker"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: Colors.transparent,
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 150,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: data == null
                              ? Container()
                              : data['photo'] == null
                                  ? Image.asset(
                                      'assets/images/mainlogo12.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      "https://smartlockerindia.com/ajapi/uploads/" +
                                          data['photo'],
                                      fit: BoxFit.fill,
                                    ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                data == null
                                    ? ""
                                    : data['username'] == null
                                        ? 'Shop Name'
                                        : data['username'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text(
                                data == null
                                    ? ""
                                    : data['mobile'] == null
                                        ? 'Shop Mobile'
                                        : "+91" + data['mobile'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                            Text(
                                data == null
                                    ? ""
                                    : data['mobile'] == null
                                    ? 'Shop Email'
                                    :"${data['email'].toString()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    padding: EdgeInsets.all(10),
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
                      children: [
                        Text(
                          "All Device",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data == null
                              ? ""
                              : data['total_device'] == null
                                  ? "0"
                                  : data['total_device'].toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 60,
                    width: 150,
                    padding: EdgeInsets.all(10),
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
                      children: [
                        Text(
                          "Free Device",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data == null
                              ? ""
                              : data['free_devices'] == null
                                  ? "0"
                                  : data['free_devices'].toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                  itemCount: _menu.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8.0),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 150),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: _menu[index].onTap as void
                      Function()?,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 12,
                        child: Container(
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
                            child: Column(
                              children: [
                                _menu[index].iconData!=null?Icon(
                                  _menu[index].iconData,
                                  size: 80,
                                  color: Colors.white,
                                ):Text(
                                  _menu[index].subtitle.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 70,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _menu[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    ));
  }

  var data;
  _shopProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": "$userId"
      }),
    );
    var datad = jsonDecode(response.body);
    print(datad);
    print('sssssssssss');
    if (datad['error'] == 200) {
      setState(() {
        data = datad['data'];
      });
    } else {}
  }
}
class MenuTile {
  String title;
  String? subtitle;
  IconData? iconData;
  Function onTap;
  MenuTile({required this.title,this.subtitle, this.iconData, required this.onTap});
}