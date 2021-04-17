import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/database.dart';

class Post {
  String postImage;
  String author; //user uid
  String description; //post desc
  Set usersLiked = {};

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

  void addUrl(String image) {
    this.postImage = image;
    // this.update();
  }

  Map<String, dynamic> toJson() {
    return {
      'postImage': this.postImage,
      'author': this.author,
      'description': this.description,
      'usersLiked': this.usersLiked.toList(),
    };
    // }
    // Map<String, dynamic> toJson() {
    //   final Map<String, dynamic> data = new Map<String, dynamic>();
    //   data['postImage'] = this.postImage;
    //   data['author'] = this.author;
    //   data['description'] = this.description;
    //   data['usersLiked'] = this.usersLiked.toString();
    //   data['comments'] = this.comments.toString();
    //   print("hellllllll");
    //   return data;
    // }
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'description': '',
    'usersLiked': [],
    'postImage': '',
  };
  print("req");
  record.forEach((key, value) => {attributes[key] = value});

  Post post = new Post(
      author: attributes['author'], description: attributes['description']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  post.postImage = attributes['postImage'];
  return post;
}
