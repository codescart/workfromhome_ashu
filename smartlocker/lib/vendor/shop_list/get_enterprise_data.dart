import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartlocker/vendor/shop_list/shop_list.dart';
import 'package:smartlocker/vendor/shop_list/update_enterprise_data.dart';
import 'package:http/http.dart' as http;

class GetEnterpriseData extends StatefulWidget {
  final shoplist shopData;
  GetEnterpriseData({required this.shopData});
  @override
  State<GetEnterpriseData> createState() => _GetEnterpriseDataState();
}

class _GetEnterpriseDataState extends State<GetEnterpriseData> {

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
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Shop Detail"),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(right: 10,left: 10),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors:  _goldColors ,
                    ),
                  ),
                    child: Center(
                        child: Text(widget.shopData.dname!.toString(),
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,fontSize: 20
                          ),
                        ))
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child:Padding(
                  padding: EdgeInsets.only(right: 10,left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:60,
                        width: MediaQuery.of(context).size.width*0.4,
                        padding: EdgeInsets.all(10),
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:  _silverColors ,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8,)),
                        ),
                        child: Column(
                          children: [
                            Text("All Device",
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                            Text(widget.shopData.total_device==null?"0":widget.shopData.total_device.toString(),
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                          ],
                        ),
                      ),
                      Container(
                        height:60,
                        width: MediaQuery.of(context).size.width*0.4,
                        padding: EdgeInsets.all(10),
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:  _silverColors ,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8,)),
                        ),
                        child: Column(
                          children: [
                            Text("Lock Device",style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                            Text(widget.shopData.blocked_devices==null?"0":widget.shopData.blocked_devices.toString(),style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 20,),
              Container(
                  child:Padding(
                    padding: EdgeInsets.only(right: 10,left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height:60,
                          width: MediaQuery.of(context).size.width*0.4,
                          padding: EdgeInsets.all(10),
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:  _silverColors ,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8,)),
                          ),
                          child: Column(
                            children: [
                              Text("UnLock Device",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(widget.shopData.unblocked_devices==null?"0":widget.shopData.unblocked_devices.toString(),style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                        Container(
                          height:60,
                          width: MediaQuery.of(context).size.width*0.4,
                          padding: EdgeInsets.all(10),
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:  _silverColors ,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8,)),
                          ),
                          child: Column(
                            children: [
                              Text("Free Device",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(widget.shopData.free_devices==null?"0":widget.shopData.free_devices.toString(),style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.transparent,
                  elevation:5,
                  child: Container(
                    width:double.infinity,
                    height: 120,
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:  _silverColors ,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(8,)),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Icon(Icons.account_circle,size: 22,),
                            SizedBox(height: 10,),
                            Icon(Icons.email_outlined,size: 22,),
                            SizedBox(height: 10,),
                            Icon(Icons.phone,size: 22,),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(widget.shopData.username.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 18,
                              )
                            ),
                            SizedBox(height: 10,),
                            Text(widget.shopData.email!.toString(),textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 18,
                              ),),
                            SizedBox(height: 10,),
                            Text(widget.shopData.mobile!.toString(),textAlign: TextAlign.center,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.transparent,
                  elevation:12,
                  child: InkWell(
                    onTap: ()  {
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => UpdateEnterprise(
                           userId:widget.shopData.user_id,
                           Name:widget.shopData.username,
                           Email:widget.shopData.email,
                           Phone:widget.shopData.mobile,

                         ))
                     );
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
                          child: Text("Update Contect Details",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 18,
                              )),
                        ),

                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        )
    );
  }
}
