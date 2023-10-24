import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class User_QR_Page extends StatefulWidget {
  final String? UserId;
  User_QR_Page({this.UserId});
  @override
  State<User_QR_Page> createState() => _User_QR_PageState();
}

class _User_QR_PageState extends State<User_QR_Page> {

  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Enroll Device"),
        flexibleSpace: Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:  _goldColors ,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 18,),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("User Login Id : ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              Text(widget.UserId.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text("OR",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.red),),
          SizedBox(
            height: 20,
          ),
          QrImageView(
            data:widget.UserId==null?'hi': widget.UserId.toString(),
            size: 0.5 * MediaQuery.of(context).size.width,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
