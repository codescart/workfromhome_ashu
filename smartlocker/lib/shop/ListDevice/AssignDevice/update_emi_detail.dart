import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/shop/ListDevice/AssignDevice/assigndevice.dart';
import 'package:smartlocker/shop/ListDevice/AssignDevice/devices_controal.dart';

class UpdateEmiDetail extends StatefulWidget {
  final String? denId;
  final String? duDate;
  final String? lepDate;
  final String? tnoEmi;
  final String? nopEmi;
  UpdateEmiDetail({this.denId, this.duDate, this.lepDate, this.tnoEmi, this.nopEmi,});
  @override
  State<UpdateEmiDetail> createState() => _UpdateEmiDetailState();
}

class _UpdateEmiDetailState extends State<UpdateEmiDetail> {
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  InputDecoration getInputDecoration(String hintext, IconData iconData ) {
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
        color: Colors.grey,
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }


  final TextEditingController _duedate = TextEditingController();
  final TextEditingController _lastemipaydate = TextEditingController();
  final TextEditingController _noofemi = TextEditingController();
  final TextEditingController _noofpaidemi = TextEditingController();
  late DateTime _selectedDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,size: 16,),),
        title: Text("EMI Detail"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Due Date',
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
                  child: TextField(
                      controller: _duedate,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
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
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async{
                            await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101)
                            ).then((pickeddate){
                              if(pickeddate != null){
                                setState(() {
                                  _selectedDate = pickeddate;
                                  _duedate.text= "${_selectedDate.toLocal()}".split(' ')[0];
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.calendar_month_outlined),
                          color: Color(0xFFa2790d),
                        ),
                        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        hintText: "Select Due Date",
                        // fillColor: kBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      )

                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'No Of IMEI',
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
                    maxLength: 10,
                    style: const TextStyle(fontSize: 14),
                    decoration: getInputDecoration(
                      'No Of IMEI',
                      Icons.phone,
                    ),
                    controller: _noofemi,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Last IMEI Pay Date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
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
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async{
                          await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101)
                          ).then((pickeddate){
                            if(pickeddate != null){
                              setState(() {
                                _selectedDate = pickeddate;
                                _lastemipaydate.text= "${_selectedDate.toLocal()}".split(' ')[0];
                              });
                            }
                          });
                        }, icon: Icon(Icons.calendar_month_outlined),
                        color: Color(0xFFa2790d),
                      ),
                      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                      hintText: "Select Due Date",
                      // fillColor: kBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                    ),
                    controller: _lastemipaydate,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'No Of Paid IMEI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 14),
                    decoration: getInputDecoration(
                      'No Of Paid IMEI',
                      Icons.mobile_screen_share_rounded,
                    ),
                    controller: _noofpaidemi,
                    keyboardType: TextInputType.number,

                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation:12,
                    child: InkWell(
                      onTap: ()  {
                        _udateImeidata(_duedate.text,_lastemipaydate.text,_noofemi.text,_noofpaidemi.text,);
                      },
                      child: Container(
                        width:double.infinity,
                        height: 50,
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:  _goldColors ,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15,)),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text("SUBMIT",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 22,
                              ),),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _udateImeidata(String _duedate,String _lastemipaydate,String _noofemi,String _noofpaidemi,) async {
    final response = await http.post(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/update_2"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "id":widget.denId,
        "due_date":_duedate,
        "last_ime_paydate":_lastemipaydate,
        "no_of_ime":_noofemi,
        "no_of_payimi":_noofpaidemi,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('ggggggggggggg');
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Update Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AssignList()));
    }else {
      Fluttertoast.showToast(
          msg: "Somthing want wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);

    }
  }
}