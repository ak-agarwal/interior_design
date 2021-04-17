import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interior_design/databaseFiles/Users.dart';
import 'package:interior_design/databaseFiles/database.dart';
import 'package:interior_design/databaseFiles/post.dart';
import 'package:interior_design/screens/addPost.dart';

class ExploreTab extends StatefulWidget {
  User user;
  ExploreTab({this.user});

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  User user;
  Users mainUser;
  _ExploreTabState({this.user});
  List<Post> lists;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    addPost();
    // post = getAllPosts() as List<Post>;
    // print(post);
  }

  void addPost() async {
    lists = await getAllPosts();
    print(lists);
    if (lists.isNotEmpty) {
      setState(() {
        loading = false;
      });
    }
    mainUser = await getUser(widget.user);
    print(mainUser.description);
    print(mainUser.name);
    print(mainUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(
        leading: Container(),
        elevation: 0.0,
        backgroundColor: Color(0xff333333),
        title: Text(
          "Explore",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPost(
                              user: widget.user,
                            )),
                    (Route<dynamic> route) => false);
              }),
        ],
      ),
      body: loading
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Image.network(
                        lists[index].postImage,
                        width: 270.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          children: [
                            Text(
                              lists[index].usersLiked.length.toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                            SizedBox(
                              width: 70.0,
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  lists[index].likedPost(widget.user.uid);
                                });
                              },
                            ),
                            // IconButton(
                            //   icon: Icon(
                            //     FontAwesomeIcons.comment,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {},
                            // ),
                            // IconButton(
                            //   icon: Icon(
                            //     FontAwesomeIcons.share,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {},
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        lists[index].description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ],
                  );
                },
              )),
    );
  }
}
