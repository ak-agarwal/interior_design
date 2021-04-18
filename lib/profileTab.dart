import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interior_design/databaseFiles/Users.dart';
import 'package:interior_design/databaseFiles/database.dart';
import 'package:interior_design/databaseFiles/post.dart';
import 'package:interior_design/editUser.dart';

class ProfileTab extends StatefulWidget {
  final User user;

  ProfileTab({this.user});
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Post> lists;
  bool loading = true;
  Users dbUser;

  @override
  void initState() {
    super.initState();
    addPost();
    print(dbUser);
  }

  void addPost() async {
    dbUser = await getUser(widget.user);
    lists = await getAllUsersPosts("SPdimIJOF9TsLMoIHiqGrZ5zRFP2");

    print(lists);
    if (lists.isNotEmpty) {
      setState(() {
        loading = false;
      });
    }
  }

  List<String> images = [
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg"
  ];

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
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                radius: 60.0,
                child: Icon(Icons.person),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dbUser.name,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditUser(
                              user: widget.user,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "Liked Posts",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dbUser.description,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              children: [
                Text(
                  "248 followers",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 80.0,
                ),
                Text(
                  "180 following",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(lists[index].postImage);
                },
              )),
          ButtonTheme(
            height: 50.0,
            minWidth: 200.0,
            child: OutlineButton(
                color: Color(0xff333333),
                child: new Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          )
        ],
      ),
    );
  }
}
