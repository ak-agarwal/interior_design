import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_design/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPhone extends StatefulWidget {
  User user;
  RegisterPhone({this.user});
  @override
  _RegisterPhoneState createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  User user;
  _RegisterPhoneState({this.user});
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

// login user using OTP (Phone Authentication)
  Future loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
// Automatic handling of the SMS code on Android devices.
        UserCredential result = await _auth.signInWithCredential(credential);
        User user = result.user;
        if (user != null) {
// on verification successful go to dashboard
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Dashboard();
              },
            ),
          );
        } else {
// if verification fails
          print("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
// code here for authentication failure or user not authenticated
// this callback Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded
        print(exception);
      },
      codeSent: (String verificationId, int resendToken) {
// Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Enter OTP sent to your phone'),
                content: Column(
                  children: [
                    TextField(
                      controller: _otpController,
                    ),
                  ],
                ),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () async {
// generate credential object
                      AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: _otpController.text.trim(),
                      );
// signing in with the generated credential
                      UserCredential result =
                          await _auth.signInWithCredential(credential);
                      User user = result.user;

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("user", user.uid);
                      print(user.uid);
                      print(user.displayName);
                      if (user != null) {
                        // List<Users> list = [];
                        // list = getAllUsers() as List<Users>;
                        // for(int i=0; i<list.length; i++) {
                        //   if(list)
                        // }

// on verification successful go to dashboard
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Dashboard(
                                user: user,
                              );
                            },
                          ),
                        );
                      } else {
// if verification fails
                        print("Error");
                      }
                    },
                    child: Text('Confirm'),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  ),
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xfff6a56f),
                      Color(0xffcd81c1),
                      Color(0xff55bacc)
                    ]),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              color: Colors.black87,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Verify your Phone",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "We need your contact \nin order to keep connected!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {},
                          controller: _phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please complete the field!';
                            }
                            return null;
                          },
                          autocorrect: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 18,
                            ),
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          maxLines: 1,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.grey, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.arrow_forward_rounded),
                              ),
                              onTap: () {
                                final phone = _phoneController.text.trim();
                                loginUser(phone, context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
