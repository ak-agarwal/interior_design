import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_design/screens/dashboard.dart';

class RegisterPhone extends StatefulWidget {
  @override
  _RegisterPhoneState createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {

  final phoneController = TextEditingController();

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
                    colors: [Colors.deepPurple, Colors.lightBlueAccent, Colors.pinkAccent]
                ),
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
                        Text("Verify your Phone", style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0
                        ),),
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
                          child: Text("We need your contact \nin order to keep connected!", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ), textAlign: TextAlign.justify,),
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
                          controller: phoneController,
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
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
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
                              child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_forward_rounded)),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
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
