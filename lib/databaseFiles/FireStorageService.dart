import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}

Future<String> uploadPic(File image) async {
  final _storage = FirebaseStorage.instance;
  var snapshot =
      await _storage.ref().child('${Path.basename(image.path)}').putFile(image);
  String downloadURL = await snapshot.ref.getDownloadURL();
  print(downloadURL.toString());
  return downloadURL;
}
