import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class PrevicyPolicy extends StatefulWidget {
  const PrevicyPolicy({Key? key}) : super(key: key);

  @override
  State<PrevicyPolicy> createState() => _PrevicyPolicyState();
}

class _PrevicyPolicyState extends State<PrevicyPolicy> {

  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Privacy Policy"),
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
      body: Tawk(
        directChatLink: 'https://smartlockerindia.com/Privacypolicy.php/Privacy_policy',
        placeholder:  Center(
          child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
        ),
      )
    );
  }
}