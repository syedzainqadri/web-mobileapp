import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/screens/auth/create_account_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  String phoneNumber;
  final bool fromSignUp;
  OtpScreen({@required this.phoneNumber, this.fromSignUp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  TextEditingController textEditingController1;
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(0, 0, 0, 0),
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: const Color.fromRGBO(0, 0, 0, 1),
    ),
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  // String _comingSms = 'Unknown';

  // Future<void> initSmsListener() async {
  //   String comingSms;
  //   try {
  //     comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms;
  //     print("====>Message: ${_comingSms}");
  //     print("${_comingSms[1]}");
  //     textEditingController1.text = _comingSms[0] +
  //         _comingSms[1] +
  //         _comingSms[2] +
  //         _comingSms[3] +
  //         _comingSms[4] +
  //         _comingSms[
  //             5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: ClipRRect(
                child: Image.asset(
                  Images.app_logo,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Please Enter Verification Code',
                  style: poppinsBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50.0, left: 50, top: 20),
            child: PinPut(
              fieldsCount: 6,
              textStyle: poppinsBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Colors.green[700]),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: textEditingController1,
              // controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await auth
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountScreen()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState.showSnackBar(
                      SnackBar(content: Text('Please Enter A Valid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // _onVerificationCompleted(PhoneAuthCredential authCredential) async {
  //   print("verification completed ${authCredential.smsCode}");
  //   User user = FirebaseAuth.instance.currentUser;
  //   print('code is ${authCredential.smsCode}');
  //   setState(() {
  //     this.textEditingController1.text = authCredential.smsCode;
  //   });
  //   if (authCredential.smsCode != null) {
  //     try {
  //       UserCredential credential =
  //           await user.linkWithCredential(authCredential);
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'provider-already-linked') {
  //         await FirebaseAuth.instance.signInWithCredential(authCredential);
  //       }
  //     }
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => CreateAccountScreen()),
  //         (route) => false);
  //   }
  // }

  _verifyPhone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              (route) => false);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          String smsCode;
          setState(() {
            _verificationCode = verficationID;
          });
          auth.signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: smsCode));
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    textEditingController1 = TextEditingController();
    // initSmsListener();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    // AltSmsAutofill().unregisterListener();
    super.dispose();
  }
}
