import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class TransjectionHistory extends StatefulWidget {
  const TransjectionHistory({Key? key}) : super(key: key);

  @override
  State<TransjectionHistory> createState() => _TransjectionHistoryState();
}

class _TransjectionHistoryState extends State<TransjectionHistory> with TickerProviderStateMixin{

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
    TabController tabController=TabController(length: 2, vsync: this);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Transaction History"),
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
        body:Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(right: 15,left: 15),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:  _goldColors ,
                  ),
                ),
                controller: tabController,
                tabs: [
                  Tab(
                      child:
                      Text("Debit",style: TextStyle(
                          color: Colors.black
                      ),)
                  ),
                  Tab(child:
                  Text("Credit",style: TextStyle(
                      color: Colors.black
                  ),)
                  ),

                ],
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      child:FutureBuilder<List<debit>>(
                          future: _debited(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:Card(
                                          color: Colors.transparent,
                                          elevation:5,
                                          child: InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesPerson(para:'dist=', id:snapshot.data![index].id)));
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
                                                child: ListTile(
                                                  title: Container(
                                                    // padding:EdgeInsets.only(top: 20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Paid to"),
                                                        Text("${snapshot.data![index].username}"),
                                                      ],
                                                    ),
                                                  ),
                                                  leading: Padding(
                                                  padding:EdgeInsets.only(top:15),
                                                    child:  Container(
                                                      width:50,
                                                      height:50,
                                                      decoration:  BoxDecoration(
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors:  _goldColors ,
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(15,)),
                                                      ),
                                                      child: Center(
                                                        child: Text("↗",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                   ),
                                                  trailing: Container(
                                                    // padding:EdgeInsets.only(top: 20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment:CrossAxisAlignment.end,
                                                      children: [
                                                        Text("${snapshot.data![index].piece}"+"  Pieces"),
                                                        Text("${snapshot.data![index].datetime}"),
                                                        snapshot.data![index].remainbal==null?Text("0"+" Pieces Available"):Text("${snapshot.data![index].remainbal}"+"  Pieces Available")
                                                      ],
                                                    ),
                                                  )
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                )
                            ):Center(child: CircularProgressIndicator(
                              color: Color(0xFFebd197),
                            ));
                          }
                      ),
                    ),
                    Container(
                      child:FutureBuilder<List<credit>>(
                          future: _credited(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Card(
                                          color: Colors.transparent,
                                          elevation:5,
                                          child: InkWell(
                                            onTap: (){},
                                            child:Container(
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
                                                          Text("Recieved from"),
                                                          Text("${snapshot.data![index].username}"),
                                                        ],
                                                      ),
                                                    ),
                                                    leading: Padding(
                                                      padding:EdgeInsets.only(top:15),
                                                      child:  Container(
                                                        width:50,
                                                        height:50,
                                                        decoration:  BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors:  _goldColors ,
                                                          ),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(15,)),
                                                        ),
                                                        child: Center(
                                                          child: Text("↙",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      // padding:EdgeInsets.only(top: 20),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:CrossAxisAlignment.end,
                                                        children: [
                                                          Text("${snapshot.data![index].piece}"+"  Pieces"),
                                                          Text("${snapshot.data![index].datetime}"),
                                                          // Text("Remaining Bal : "+"${snapshot.data![index].remaintid}"+"  Pieces")
                                                        ],
                                                      ),
                                                    )
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                )
                            ):Center(child: CircularProgressIndicator(
                              color: Color(0xFFebd197),
                            ));
                          }
                      ),
                    ),

                  ],

                )
            )
          ],
        )
    )
    );
  }
}

Future<List<debit>> _debited() async {
  print('raja');
  print('pjjjani');
  final prefs = await SharedPreferences.getInstance();
  final key = 'userId';
  final userId = prefs.getString(key) ?? "0";
  print(userId);
  var url = Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/transaction_debited?id=$userId");
  // $paras&
  print(url);

  var response = await http.get(url);
  var data = json.decode(response.body)['data'];
  print(data);
  print('janu');
  List<debit> debited = [];
  for (var o in data) {
    debit al = debit(
        o["id"],
        o["remainbal"],
        o["remaintid"],
        o["piece"],
        o["type"],
        o["typetid"],
        o["uid"],
        o["tid"],
        o["datetime"],
        o["username"],
        o["userphone"]
    );
    debited.add(al);
  }
  return debited;
}


Future<List<credit>> _credited() async {
  print('raja');
  print('pjjjani');
  final prefs = await SharedPreferences.getInstance();
  final key = 'userId';
  final userId = prefs.getString(key) ?? "0";
  print(userId);
  var url = Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/transaction_credited?id=$userId");
  // $paras
  print(url);

  var response = await http.get(url);
  var data = json.decode(response.body)['data'];
  print(data);
  print('janu');
  List<credit> credited = [];
  for (var o in data) {
    credit al = credit(
      o["id"],
      o["remainbal"],
      o["remaintid"],
        o["piece"],
      o["type"],
      o["typetid"],
      o["uid"],
      o["tid"],
      o["datetime"],
        o["username"],
        o["userphone"]
    );
    credited.add(al);
  }
  return credited;
}


class credit {
  String? id;
  String? remainbal;
  String? remaintid;
  String? piece;
  String? type;
  String? typetid;
  String? uid;
  String? tid;
  String? datetime;
  String? username;
  String? userphone;

  credit(
      this.id,
    this.remainbal,
    this.remaintid,
    this.piece,
    this.type,
    this.typetid,
    this.uid,
    this.tid,
    this.datetime,
    this.username,
    this.userphone
      );
}


class debit {
  String? id;
  String? remainbal;
  String? remaintid;
  String? piece;
  String? type;
  String? typetid;
  String? uid;
  String? tid;
  String? datetime;
  String? username;
  String? userphone;

  debit(
    this.id,
    this.remainbal,
    this.remaintid,
    this.piece,
    this.type,
    this.typetid,
    this.uid,
    this.tid,
    this.datetime,
      this.username,
      this.userphone
      );
}