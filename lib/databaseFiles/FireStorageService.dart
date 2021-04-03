import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

Future<String> uploadPic() async {
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  PickedFile image;
  //check permisions
  await Permission.photos.request();
  var permissionStatus = await Permission.photos.status;
  if (permissionStatus.isGranted) {
    //pick image
    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      //upload to firebase
      var snapshot =
          await _storage.ref().child('postsImage').putFile(file).onComplete;
      var downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      print('image is null');
    }
  } else {
    await Permission.photos.request();
  }
}
