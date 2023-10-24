import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewContact extends StatefulWidget {
  final String? userId;
  ViewContact({this.userId});
  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
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
          title: Text("User Contact"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
          ),
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
        body: FutureBuilder<List<usercontact>>(
            future: UserContact(),
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
                          child: Card(
                            color: Colors.transparent,
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _silverColors,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  15,
                                )),
                              ),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data![index].name == null
                                        ? "Not avl"
                                        : snapshot.data![index].name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].phone == null
                                        ? "Not avl"
                                        : snapshot.data![index].phone!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFebd197),
                      ),
                    );
            }),
      ),
    );
  }

  Future<List<usercontact>> UserContact() async {
    final UserId = widget.userId;
    print(UserId);
    print('bhado');
    final response = await http.get(
      Uri.parse(
          'https://smartlockerindia.com/ajapi/api/Mobile_app/getcontact?user_id=$UserId'),
    );
    var data = json.decode(response.body)["data"];
    print(data);
    print('savan');
    List<usercontact> viewcontact = [];
    for (Map o in data) {
      usercontact al = usercontact(
        o['id'],
        o['user_id'],
        o['name'],
        o['phone'],
        o['email'],
      );
      viewcontact.add(al);
    }
    return viewcontact;
  }
}

class usercontact {
  String? id;
  String? user_id;
  String? name;
  String? phone;
  String? email;
  usercontact(
    this.id,
    this.user_id,
    this.name,
    this.phone,
    this.email,
  );
}
