import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/constantWidget/colors.dart';
import 'package:smartlocker/vendor/shop_list/shop_list.dart';

class SecondScreen extends StatefulWidget {
  final String? userName;
  final String? userPhone;
  final String? shopEmail;
  final String? shopId;
  SecondScreen({this.userName, this.userPhone, this.shopEmail, this.shopId});
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  InputDecoration getInputDecoration(String hintext, IconData iconData) {
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
         color:  Color(0xFFebd197),
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopname = TextEditingController();
  final TextEditingController _dataProtectionOfficerEmail = TextEditingController();
  final TextEditingController _dataProtectionOfficerName = TextEditingController();
  final TextEditingController _dataProtectionOfficerPhone = TextEditingController();

  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  bool _isLoadingButton = false;
  @override
  void initState() {
    _accessKoken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Create Shop"),
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
              SizedBox(height: 20),
            Form(
              key: _formKey,
                child: Column(
                 children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                       child: Text(
                         'Shop Name',
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
                         'Shop Name',
                         Icons.mobile_screen_share_outlined,
                       ),
                       controller: _shopname,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Enter Shop Name';
                         }
                         return null;
                       },
                       // keyboardType: TextInputType.name,

                     ),
                   ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                       child: Text(
                         'Data Protection Officer Name',
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
                       keyboardType: TextInputType.name,
                       maxLength: 30,
                       style: const TextStyle(fontSize: 14),
                       decoration: getInputDecoration(
                         'Data Protection Officer Name',
                         Icons.person,
                       ),
                       controller: _dataProtectionOfficerName,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter Data Protection Officer Name';
                         }
                         return null;
                       },
                     ),
                   ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                       child: Text(
                         ' Data Protection Officer Phone',
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
                       keyboardType: TextInputType.number,
                       maxLength: 10,
                       style: const TextStyle(fontSize: 14),
                       decoration: getInputDecoration(
                         ' Data Protection Officer Phone',
                         Icons.phone_android,
                       ),
                       controller: _dataProtectionOfficerPhone,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter Data Protection Officer Phone';
                         }
                         return null;
                       },
                       // keyboardType: TextInputType.name,

                     ),
                   ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                       child: Text(
                         ' Data Protection Officer Email',
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
                       keyboardType: TextInputType.emailAddress,
                       style: const TextStyle(fontSize: 14),
                       decoration: getInputDecoration(
                         ' Data Protection Officer Email',
                         Icons.email,
                       ),
                       controller: _dataProtectionOfficerEmail,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter Data Protection Officer Email';
                         }
                         return null;
                       },
                       // keyboardType: TextInputType.name,

                     ),
                   ),
              ],
            )
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.transparent,
                  elevation:12,
                  child: InkWell(
                    onTap: ()  {
                      if (_formKey.currentState!.validate()) {
                        _createEnterprise(
                            _shopname.text,
                            _dataProtectionOfficerName.text,
                            _dataProtectionOfficerPhone.text,
                            _dataProtectionOfficerEmail.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
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
                          child: setUpButtonChild()
                        ),
                      )
                    ),
                  ),
                ),
              ),
          ],
        ),
      )
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_isLoadingButton==false) {
      return  Text("Create Enterprise",textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,fontSize: 22,
          ));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }

   var finaltoken;
   var enterpriseId;
   var fshopname;
   var  dpName;
   var  dpPhone;
   var  dpEmail;
   var  rpName;
   var  rpPhone;
   var  rpEmail;
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
    }else {
    }
  }


  _createEnterprise(
      String _shopname,_dataProtectionOfficerName, _dataProtectionOfficerPhone,_dataProtectionOfficerEmail,
      ) async {
    setState(() {
      _isLoadingButton = true;
    });
    print(finaltoken);
    final response = await http.post(
      Uri.parse("https://androidmanagement.googleapis.com/v1/enterprises?agreementAccepted=true&projectId=$ProjectId"),
      headers: {
        "Authorization":"Bearer $finaltoken",
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "enterpriseDisplayName":_shopname,
        "contactInfo":{
          "contactEmail":widget.shopEmail,
          "dataProtectionOfficerName":_dataProtectionOfficerName,
          "dataProtectionOfficerPhone":_dataProtectionOfficerPhone,
          "dataProtectionOfficerEmail":_dataProtectionOfficerEmail,
          "euRepresentativeName":widget.userName,
          "euRepresentativePhone":widget.userPhone,
          "euRepresentativeEmail":widget.shopEmail,
        }
      }),
    );
    final dada = jsonDecode(response.body);
    print(dada);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final enterprise = dada['name'];
      final shopname = dada['enterpriseDisplayName'];
      final dpname = dada['contactInfo']['dataProtectionOfficerName'];
      final dpphone = dada['contactInfo']['dataProtectionOfficerPhone'];
      final dpemail = dada['contactInfo']['dataProtectionOfficerEmail'];
      final rpname = dada['contactInfo']['euRepresentativeName'];
      final rpphone = dada['contactInfo']['euRepresentativePhone'];
      final rpemail = dada['contactInfo']['euRepresentativeEmail'];
      setState(() {
        enterpriseId = enterprise;
        fshopname=shopname;
        dpName = dpname;
        dpPhone = dpphone;
        dpEmail = dpemail;
        rpName = rpname;
        rpPhone = rpphone;
        rpEmail = rpemail;
      });
      _registerEnterprise();
    }else {
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
      // throw Exception('Could not update data');
    }
  }

  _registerEnterprise() async {
    print(widget.shopId);
    print(fshopname);
    print(widget.shopEmail);
    print(dpName);
    print(dpPhone);
    print(dpEmail);
    print(rpName);
    print(rpPhone);
    print(rpEmail);
    print(enterpriseId);
    print("enterpriseId");
    final res =await http.patch(
      Uri.parse("https://androidmanagement.googleapis.com/v1/$enterpriseId/policies/myPolicy"),
      headers: {
        "Authorization":"Bearer $finaltoken",
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "applications": [
          {
            "packageName": "com.foundercodes.smartlockerknox",
            "installType": "FORCE_INSTALLED",
            "lockTaskAllowed": true,
            "autoUpdateMode": "AUTO_UPDATE_DEFAULT"
          }
        ],
        "defaultPermissionPolicy": "GRANT",
        "factoryResetDisabled": true,
        "safeBootDisabled": true,
        "usbFileTransferDisabled": true,
        "frpAdminEmails": [
          "cricketnews15798@gmail.com"
        ],
        "permissionGrants": [
          {
            "policy": "GRANT"
          }
        ]
      }),
    );
    final daa = jsonDecode(res.body);
    print(daa);
    print("yyyyyyyyyyyyyy");
    final response = await http.post(
      Uri.parse("https://smartlockerindia.com/ajapi/api/Mobile_app/register2"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
          "user_id":widget.shopId,
          "dname":fshopname,
          "contact_email":widget.shopEmail,
          "dp_officername":dpName,
          "dp_officer_phone":dpPhone,
          "dp_officer_email":dpEmail,
          "r_officer_name":rpName,
          "r_officer_phone":rpPhone,
          "r_officer_email":rpEmail,
          "enterprise_id":enterpriseId,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('ggggggggggggg');
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: "Create Shop Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopList()));
    }else {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: "Faild To Create Shop",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
      // throw Exception('Could not update data');
    }
  }

}









