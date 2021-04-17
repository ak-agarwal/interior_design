import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

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
              child: Text("Edit your profile", textAlign: TextAlign.justify, style: TextStyle(
                    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold
                ),),
            ),
            SizedBox(
              height: 30.0,
            ),
            CircleAvatar(
              radius: 100.0,
              child: Image.network("https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg"),
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
                  child: Icon(Icons.person, color: Colors.white,),
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
                  child: Icon(Icons.description, color: Colors.white,),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                labelText: "Description",
                fillColor: Colors.white24,
              ),
              maxLines: 1,
              style: TextStyle(fontSize: 16.0, color: Colors.white,),
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
                  child: new Text("Save Changes", style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonTheme(
              height: 50.0,
              minWidth: 200.0,
              child: RaisedButton(
                  color: Colors.red,
                  child: new Text("Log Out", style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            )
          ],
        ),
      ),
    );
  }
}
