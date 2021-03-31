import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/Users.dart';
import 'post.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  id.set({post.toJson()});
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

//Explore Tab
Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseReference.child('/posts/').once();
  List<Post> posts = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Post post = createPost(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
      return post;
    });
  }
  return [];
}

//Update Like, Comment
void updateUser(Users user, DatabaseReference id) {
  id.update(user.toJson());
}

//Save to db
DatabaseReference saveUser(Users user) {
  var id = databaseReference.child('users/').push();
  id.set({user.toJson()});
  return id;
}


Future<List<Post>> getAllUsers() async {
  DataSnapshot dataSnapshot = await databaseReference.child('/users/').once();
  List<Users> users = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Users user = createUsers(value);
      user.setId(databaseReference.child('posts/' + key));
      users.add(user);
      return users;
    });
  }
  return [];
}
