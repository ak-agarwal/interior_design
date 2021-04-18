import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/database.dart';

class Users {
  String uid;
  String name;
  String description;
  DatabaseReference _id;

  Users(String user) {
    this.uid = user;
  }

  void update() {
    updateUser(this, this._id);
  }

  void updateDetails(String name, String desc) {
    this.name = name;
    this.description = desc;
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
  Users users = new Users(attributes['uid']);
  users.description = attributes['description'];
  users.name = attributes['name'];
  print("insice");
  print(users.uid);
  print("inside");
  return users;
}
