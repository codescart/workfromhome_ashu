import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/login/pin_login.dart';
import 'package:smartlocker/previcy_policy.dart';
import 'package:smartlocker/TransjectionHistory/transjection_history.dart';
import 'package:smartlocker/vendor/Drstributer/distributer_list.dart';
import 'package:smartlocker/vendor/SalesPerson/salse_person_list.dart';
import 'package:smartlocker/vendor/SuperDistributer/super_distributer_list.dart';
import 'package:smartlocker/vendor/create/firstscreen.dart';
import 'package:smartlocker/vendor/shop_list/shop_list.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/vendor/transferbalance.dart';

class VendorHome extends StatefulWidget {
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      counter: Offstage(),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: Color(0xFFebd197),
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  final TextEditingController _admadddevice = TextEditingController();
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
    _shopProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<MenuTile> _menu = [
      MenuTile(1, "Create", Icons.add, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }),
      MenuTile(2, "Super Distributer", Icons.people, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SuperDistributer()));
      }),
      MenuTile(3, "Distributer", Icons.people, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Distributer()));
      }),
      MenuTile(4, "shop", Icons.shop_2_outlined, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopList()));
      }),
      MenuTile(5, "Sales Persion", Icons.people, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SalesPerson()));
      }),
      MenuTile(6, "Add Balance", Icons.account_balance, () {
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
                      border: Border.all(width: 5, color: Colors.black54)),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  alignment: Alignment.bottomCenter,
                  // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                          child: Text(
                            'Add Number of Approve Device',
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
                          cursorColor: Color(0xFFebd197),
                          maxLength: 30,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontSize: 14),
                          decoration: getInputDecoration(
                            "Add Number Of Device ",
                            Icons.add,
                          ),
                          controller: _admadddevice,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  var finaltext = _admadddevice.text;
                                  print(finaltext);
                                  print("zzzzzzz");
                                  final response = await http.get(Uri.parse(
                                      "https://smartlockerindia.com/ajapi/api/Mobile_app/add_balance?piece=$finaltext"));
                                  final data = jsonDecode(response.body);
                                  print(data);
                                  print("bbbbbbbb");
                                  if (response.statusCode == 200) {
                                    Fluttertoast.showToast(
                                        msg: "Add Success",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VendorHome()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Server Error",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(fontSize: 18),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
      MenuTile(7, "Balance Transfer", Icons.account_balance, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransferBall()));
      }),
      MenuTile(8, "Transaction History", Icons.history, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransjectionHistory()));
      }),
      MenuTile(9, "Privacy Policy", Icons.policy, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
      }),
      MenuTile(10, "LOG OUT", Icons.exit_to_app, () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('userType');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PinLogin()));
      }),
    ];
    List<MenuTile> _menu3 = [
      MenuTile(1, "Create", Icons.add, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }),
      MenuTile(3, "Distributer", Icons.people, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Distributer()));
      }),
      MenuTile(7, "Balance Transfer", Icons.account_balance, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransferBall()));
      }),
      MenuTile(8, "Transaction History", Icons.history, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransjectionHistory()));
      }),
      MenuTile(9, "Privacy Policy", Icons.policy, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
      }),
      MenuTile(10, "LOG OUT", Icons.exit_to_app, () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('userType');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PinLogin()));
      }),
    ];
    List<MenuTile> _menu4 = [
      MenuTile(1, "Create", Icons.add, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }),
      MenuTile(4, "shop", Icons.shop_2_outlined, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopList()));
      }),
      MenuTile(5, "Sales Persion", Icons.people, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SalesPerson()));
      }),
      MenuTile(7, "Balance Transfer", Icons.account_balance, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransferBall()));
      }),
      MenuTile(8, "Transection History", Icons.history, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransjectionHistory()));
      }),
      MenuTile(9, "Privacy Policy", Icons.policy, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
      }),
      MenuTile(10, "LOG OUT", Icons.exit_to_app, () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('userType');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PinLogin()));
      }),
    ];
    List<MenuTile> _menu5 = [
      MenuTile(1, "Create", Icons.add, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }),
      MenuTile(4, "shop", Icons.shop_2_outlined, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopList()));
      }),
      MenuTile(7, "Balance Transfer", Icons.account_balance, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransferBall()));
      }),
      MenuTile(8, "Transaction History", Icons.history, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransjectionHistory()));
      }),
      MenuTile(9, "Privacy Policy", Icons.policy, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
      }),
      MenuTile(10, "LOG OUT", Icons.exit_to_app, () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('userType');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PinLogin()));
      }),
    ];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
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
                                          ? 'Shop Email'
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
                                      : data['email'] == null
                                          ? 'Shop Email'
                                          : data['email'].toString(),
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
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.5,
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
                        "Available Devices",
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
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                        right: MediaQuery.of(context).size.width * 0.06),
                    child: type == '1'
                        ? GridView.builder(
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
                                onTap: _menu[index].onTap as void Function()?,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(
                                        15,
                                      )),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Icon(
                                            _menu[index].iconData,
                                            size: 80,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _menu[index].title!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
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
                        : type == '3'
                            ? GridView.builder(
                                itemCount: _menu3.length,
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
                                    onTap:
                                        _menu3[index].onTap as void Function()?,
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
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(
                                            15,
                                          )),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Icon(
                                                _menu3[index].iconData,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                _menu3[index].title!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                            : type == '4'
                                ? GridView.builder(
                                    itemCount: _menu4.length,
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
                                        onTap: _menu4[index].onTap as void
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
                                                  Icon(
                                                    _menu4[index].iconData,
                                                    size: 80,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _menu4[index].title!,
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
                                : GridView.builder(
                                    itemCount: _menu5.length,
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
                                        onTap: _menu5[index].onTap as void
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
                                                  Icon(
                                                    _menu5[index].iconData,
                                                    size: 80,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _menu5[index].title!,
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
                                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  var data;
  var type = '0';
  _shopProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final top = prefs.getString('userType') ?? '0';
    setState(() {
      type = top;
    });
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse('https://smartlockerindia.com/ajapi/api/Mobile_app/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": "$userId",
      }),
    );
    var datad = jsonDecode(response.body)['data'];
    print(datad);
    print('sssssssssss');
    if (response.statusCode == 200) {
      setState(() {
        data = datad;
      });
      print(data['shop_id'].toString());
    } else {}
  }
}

class MenuTile {
  int? id;
  String? title;
  IconData iconData;
  Function onTap;
  MenuTile(this.id, this.title, this.iconData, this.onTap);
}
