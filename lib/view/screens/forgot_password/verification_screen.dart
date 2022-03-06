// import 'package:flutter/material.dart';
// import 'package:flutter_grocery/helper/responsive_helper.dart';
// import 'package:flutter_grocery/helper/route_helper.dart';
// import 'package:flutter_grocery/localization/language_constrants.dart';
// import 'package:flutter_grocery/provider/auth_provider.dart';
// import 'package:flutter_grocery/provider/splash_provider.dart';
// import 'package:flutter_grocery/utill/color_resources.dart';
// import 'package:flutter_grocery/utill/dimensions.dart';
// import 'package:flutter_grocery/utill/images.dart';
// import 'package:flutter_grocery/utill/styles.dart';
// import 'package:flutter_grocery/view/base/custom_app_bar.dart';
// import 'package:flutter_grocery/view/base/custom_button.dart';
// import 'package:flutter_grocery/view/base/custom_snackbar.dart';
// import 'package:flutter_grocery/view/base/main_app_bar.dart';
// import 'package:flutter_grocery/view/screens/auth/create_account_screen.dart';
// import 'package:flutter_grocery/view/screens/forgot_password/create_new_password_screen.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';

// class VerificationScreen extends StatelessWidget {
//   final String emailAddress;
//   final bool fromSignUp;
//   VerificationScreen({@required this.emailAddress, this.fromSignUp = false});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: ColorResources.getCardBgColor(context),
//       appBar: ResponsiveHelper.isDesktop(context)? MainAppBar(): CustomAppBar(title: getTranslated('verify_email', context)),
//       body: SafeArea(
//         child: Scrollbar(
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Center(
//               child: SizedBox(
//                 width: 1170,
//                 child: Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) => Column(
//                     children: [
//                       SizedBox(height: 55),
//                       Image.asset(Images.email_with_background, width: 142, height: 142, color: Theme.of(context).primaryColor),
//                       SizedBox(height: 40),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         child: Center(
//                             child: Text(
//                           '${getTranslated('please_enter_4_digit_code', context)}\n ${emailAddress.trim()}',
//                           textAlign: TextAlign.center,
//                           style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
//                         )),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
//                         child: PinCodeTextField(
//                           length: 4,
//                           appContext: context,
//                           obscureText: false,
//                           keyboardType: TextInputType.number,
//                           animationType: AnimationType.fade,
//                           pinTheme: PinTheme(
//                             shape: PinCodeFieldShape.box,
//                             fieldHeight: 63,
//                             fieldWidth: 55,
//                             borderWidth: 1,
//                             borderRadius: BorderRadius.circular(10),
//                             selectedColor: Theme.of(context).primaryColor.withOpacity(.2),
//                             selectedFillColor: Colors.white,
//                             inactiveFillColor: ColorResources.getCardBgColor(context),
//                             inactiveColor: Theme.of(context).primaryColor.withOpacity(.2),
//                             activeColor: Theme.of(context).primaryColor.withOpacity(.4),
//                             activeFillColor: ColorResources.getCardBgColor(context),
//                           ),
//                           animationDuration: Duration(milliseconds: 300),
//                           backgroundColor: Colors.transparent,
//                           enableActiveFill: true,
//                           onChanged: authProvider.updateVerificationCode,
//                           beforeTextPaste: (text) {
//                             return true;
//                           },
//                         ),
//                       ),
//                       Center(
//                           child: Text(
//                         getTranslated('i_didnt_receive_the_code', context),
//                         style: poppinsRegular.copyWith(
//                           color: ColorResources.getHintColor(context),
//                         ),
//                       )),
//                       Center(
//                         child: InkWell(
//                           onTap: () {
//                             if (fromSignUp) {
//                               Provider.of<AuthProvider>(context, listen: false).checkEmail(emailAddress).then((value) {
//                                 if (value.isSuccess) {
//                                   showCustomSnackBar('Resent code successful', context, isError: false);
//                                 } else {
//                                   showCustomSnackBar(value.message, context);
//                                 }
//                               });
//                             } else {
//                               Provider.of<AuthProvider>(context, listen: false).forgetPassword(emailAddress).then((value) {
//                                 if (value.isSuccess) {
//                                   showCustomSnackBar('Resent code successful', context, isError: false);
//                                 } else {
//                                   showCustomSnackBar(value.message, context);
//                                 }
//                               });
//                             }
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             child: Text(
//                               getTranslated('resend_code', context),
//                               style: poppinsMedium.copyWith(
//                                 color: ColorResources.getTextColor(context),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 48),
//                       authProvider.isEnableVerificationCode
//                           ? !authProvider.isPhoneNumberVerificationButtonLoading
//                               ? Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
//                                   child: CustomButton(
//                                     buttonText: getTranslated('verify', context),
//                                     onPressed: () {
//                                       if (fromSignUp) {
//                                         if(Provider.of<SplashProvider>(context, listen: false).configModel.phoneVerification) {
//                                           Provider.of<AuthProvider>(context, listen: false).verifyPhone(emailAddress.trim()).then((value) {
//                                             if (value.isSuccess) {
//                                               Navigator.of(context).pushNamed(RouteHelper.createAccount, arguments: CreateAccountScreen());
//                                             } else {
//                                               showCustomSnackBar(value.message, context);
//                                             }
//                                           });
//                                         }else {
//                                           Provider.of<AuthProvider>(context, listen: false).verifyEmail(emailAddress).then((value) {
//                                             if (value.isSuccess) {
//                                               Navigator.of(context).pushNamed(RouteHelper.createAccount, arguments: CreateAccountScreen());
//                                             } else {
//                                               showCustomSnackBar(value.message, context);
//                                             }
//                                           });
//                                         }
//                                       } else {
//                                         String _mail = Provider.of<SplashProvider>(context, listen: false).configModel.phoneVerification
//                                             ? emailAddress.trim() : emailAddress;
//                                         Provider.of<AuthProvider>(context, listen: false).verifyToken(_mail).then((value) {
//                                           if(value.isSuccess) {
//                                             Navigator.of(context).pushNamed(
//                                               RouteHelper.getNewPassRoute(_mail, authProvider.verificationCode),
//                                               arguments: CreateNewPasswordScreen(email: _mail, resetToken: authProvider.verificationCode),
//                                             );
//                                           }else {
//                                             showCustomSnackBar(value.message, context);
//                                           }
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 )
//                               : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
//                           : SizedBox.shrink()
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/view/screens/auth/create_account_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  String emailAddress;
  final bool fromSignUp;
  OtpScreen({@required this.emailAddress, this.fromSignUp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify ${widget.emailAddress}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
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
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.emailAddress,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAccountScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
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
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
