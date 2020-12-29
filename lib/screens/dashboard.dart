import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  Text("Explore", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Market", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Profile", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
