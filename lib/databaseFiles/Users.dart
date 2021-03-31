import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/database.dart';

class Users {
  String uid;
  String name;
  String description;
  DatabaseReference _id;

  Users(User user) {
    this.uid = user.uid;
    this.name = user.displayName;
  }

  void update() {
    updateUser(this, this._id);
  }

  void adDescription(String str) {
    this.description = str;
    this.update();
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'description': this.description,
      'name': this.name
    };
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }
}

Users createUsers(record) {
  //record is value
  Map<String, dynamic> attributes = {'uid': '', 'description': '', 'name': ''};

  record.forEach((key, value) => {attributes[key] = value});

  Users users = new Users(null);

  users.uid = attributes['uid'];
  users.description = attributes['description'];
  users.name = attributes['name'];
  return users;
}
