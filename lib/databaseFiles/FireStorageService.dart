import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}

Future<String> uploadPic(File image) async {
  final _storage = FirebaseStorage.instance;
  // final _picker = ImagePicker();
  // PickedFile image;
  //check permisions
  await Permission.photos.request();
  // var permissionStxatus = await Permission.photos.status;
  // if (permissionStatus.isGranted) {
  //pick image
  // image = await _picker.getImage(source: ImageSource.gallery);
  // var file = File(image.path);

  // if (image != null) {
  //upload to firebase
  var snapshot = _storage.ref().child('postsImage').putFile(image).snapshot;
  print("up aboce");
  String downloadURL = await snapshot.ref.getDownloadURL();
  print("down down");
  print(downloadURL.toString());
  return downloadURL;
  //   } else {
  //     print('image is null');
  //   }
  // } else {
  //   await Permission.photos.request();
  // }
  // return null;
}
