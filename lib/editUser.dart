import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interior_design/databaseFiles/Users.dart';
import 'package:interior_design/databaseFiles/database.dart';

class EditUser extends StatefulWidget {
  final User user;

  EditUser({this.user});
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  Users dbUser;

  @override
  void initState() {
    super.initState();
    getUse();
  }

  void getUse() async {
    dbUser = await getUser(widget.user);
  }

  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff333333),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Edit your profile",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: nameController,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                labelText: "Name",
                fillColor: Colors.white24,
              ),
              maxLines: 1,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: descController,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                labelText: "Description",
                fillColor: Colors.white24,
              ),
              maxLines: 1,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonTheme(
              height: 50.0,
              minWidth: 200.0,
              child: RaisedButton(
                  color: Colors.grey,
                  child: new Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    dbUser.updateDetails(
                        nameController.text, descController.text);
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonTheme(
              height: 50.0,
              minWidth: 200.0,
              child: RaisedButton(
                  color: Colors.red,
                  child: new Text(
                    "Log Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            )
          ],
        ),
      ),
    );
  }
}
