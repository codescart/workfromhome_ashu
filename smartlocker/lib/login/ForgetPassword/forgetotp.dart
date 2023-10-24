import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlocker/login/ForgetPassword/enterpin.dart';
import 'package:smartlocker/shop/shophome.dart';
import 'package:smartlocker/login/ForgetPassword/matchphone.dart';
import 'package:smartlocker/vendor/vendor_home.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';


class MatchOtp extends StatefulWidget {
  final String phoneNo;
  final String userId;

  MatchOtp({required this.phoneNo, required this.userId});

  @override
  _MatchOtpState createState() => _MatchOtpState();
}

class _MatchOtpState extends State<MatchOtp> {
  final int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");
  String _verificationCode = "";

  @override
  void initState() {
    _sendOtp();
    _getSignatureCode();
    _startListeningSms();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    print("lllllllllll");
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }


  _onSubmitOtp() async {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) async {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }
  _verifyOtpCode() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 8000), () async {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      try {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: _verificationCode, smsCode: _otpCode))
            .then((value) async {
          if (value.user != null) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ForgetPasswordPage(userId:widget.userId)));
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0,left: 20,right: 20,bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ), // SizedBox(
              //   height: 20.h,
              // ),.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OTP Sent to your Phone'+" +91 "+"${widget.phoneNo}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    color:Color(0XFF3b9fbe),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MatchPhone()));
                      }, icon:Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPin(
                  textController: textEditingController,
                  autoFocus: true,
                  codeLength: _otpCodeLength,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: 40.0,
                  margin: 5,
                  selectedBoxSize: 40.0,
                  textStyle: const TextStyle(fontSize: 20),
                  defaultDecoration: _pinPutDecoration.copyWith(
                      border: Border.all(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.6))),
                  selectedDecoration: _pinPutDecoration,
                  onChange: (code) {
                    _onOtpCallBack(code, false);
                  }),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 12,
                child: InkWell(
                  onTap: _enableButton ? _onSubmitOtp : null,
                  child: Container(
                    height:45,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0XFF3b9fbe),
                    ),
                    child:_setUpButtonChild(),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendOtp() async {
    print("ffffffffffffff");
    print(widget.phoneNo);
    print("kkkkkkkkkk");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phoneNo}',
      verificationCompleted: (PhoneAuthCredential credential){},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return const SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return  Text(
        'Verify',
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      );
    }
  }
}