import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/database.dart';
import 'comments.dart';

class Post {
  String postImage;
  String author; //user uid
  String description; //post desc
  Set usersLiked = {};
  List<Map<String, dynamic>> comments = [];

  DatabaseReference _id;

  Post({this.description, this.author});

  void likedPost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  void addComment(Comments c) {
    this.comments.add(c.toJson());
    this.update();
  }

  void addUrl(String image) {
    this.postImage = image;
  }

  Map<String, dynamic> toJson() {
    return {
      'postImage': this.postImage,
      'author': this.author,
      'description': this.description,
      'usersLiked': this.usersLiked.toList(),
      'comments': this.comments
    };
  }
}

Post createPost(record) {
  //record is value
  Map<String, dynamic> attributes = {
    'postImage': '',
    'author': '',
    'description': '',
    'usersLiked': [],
    'comments': []
  };

  record.forEach((key, value) => {attributes[key] = value});

  Post post = new Post(
      author: attributes['author'], description: attributes['description']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  post.comments = new List.from(attributes['comments']);
  post.postImage = attributes['postImage'];
  return post;
}
