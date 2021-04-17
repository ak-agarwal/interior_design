import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interior_design/databaseFiles/FireStorageService.dart';
import 'package:interior_design/databaseFiles/database.dart';
import 'package:interior_design/databaseFiles/post.dart';
import 'package:interior_design/exploreTab.dart';

class AddPost extends StatefulWidget {
  User user;
  AddPost({this.user});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File croppedFile;
  File _image;
  String base64Image;
  final picker = ImagePicker();
  bool imageSelected = false;

  final desController = TextEditingController();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = new File(pickedFile.path);

    croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 512,
        maxHeight: 512,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 60,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop the Image',
            toolbarColor: Color.fromRGBO(67, 147, 207, 1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
            title: 'Crop the Image', aspectRatioLockEnabled: true));
    setState(() {
      List<int> imageBytes = croppedFile.readAsBytesSync();
      base64Image = base64.encode(imageBytes);
      imageSelected = true;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: 512,
      maxHeight: 512,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 60,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop the Image',
          toolbarColor: Color.fromRGBO(67, 147, 207, 1),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      iosUiSettings:
          IOSUiSettings(title: 'Crop the Image', aspectRatioLockEnabled: true),
    );
    setState(() {
      List<int> imageBytes = croppedFile.readAsBytesSync();
      base64Image = base64.encode(imageBytes);
      imageSelected = true;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff333333),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ExploreTab()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      backgroundColor: Color(0xff333333),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _showPicker(context),
                child: Container(
                  height: 400.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        croppedFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  croppedFile,
                                  width: 500.0,
                                  height: 300.0,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : IconButton(
                                padding: EdgeInsets.zero,
                                icon: Center(
                                  child: Icon(Icons.upload_sharp,
                                      color: Colors.white, size: 50.0),
                                ),
                                onPressed: () {
                                  _showPicker(context);
                                },
                              ),

                        // Icon(
                        //   Icons.upload_sharp, size: 30.0, color: Colors.white,
                        // ),
                        // Text("Upload your design", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Description",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0)),
                ],
              ),
            ),
            TextFormField(
              autocorrect: true,
              controller: desController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please complete the field!';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                fillColor: Colors.white,
              ),
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 16.0),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonTheme(
              height: 50.0,
              minWidth: 200.0,
              child: RaisedButton(
                  color: Color(0xff333333),
                  child: new Text(
                    "Proceed",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // String url = uploadPic() as String;
                    // print(url);
                    addPost(desController.text, widget.user, null);
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
              buttonColor: Colors.red,
              child: RaisedButton(
                  color: Colors.red,
                  child: new Text(
                    "Discard",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  void addPost(String desc, User user, String url) async {
    var post = new Post(description: desc, author: user.uid);
    String url = await uploadPic(_image);
    print(url);
    post.addUrl(url);
    post.setId(savePost(post));
    post.likedPost(user);
    // print("here");
    // List<Post> lists = await getAllPosts();
    // for (Post b in lists) {
    //   print(b.author);
    //   print(b.description);
    // }
    // print("heellllllooooo");
  }
}
