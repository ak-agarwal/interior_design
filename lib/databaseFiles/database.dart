import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interior_design/databaseFiles/Users.dart';
import 'post.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  Map<String, dynamic> x = post.toJson();
  id.set(x);
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

//Explore Tab
Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];
  dataSnapshot.value.forEach((key, value) {
    Post post = createPost(value);
    post.setId(databaseReference.child('posts/' + key));
    posts.add(post);
    return posts;
  });
  return posts;
}

Future<List<Post>> getAllUsersPosts(String uid) async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];
  dataSnapshot.value.forEach((key, value) {
    Post post = createPost(value);
    post.setId(databaseReference.child('posts/' + key));
    if (post.author == uid) {
      posts.add(post);
    }
    return posts;
  });
  return posts;
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

Future<Users> getUser(User mainUser) async {
  DataSnapshot dataSnapshot = await databaseReference.child('users/').once();
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Users user = createUsers(value);
      user.setId(databaseReference.child('users/' + key));
      if (user.uid == mainUser.uid) {
        return user;
      }
    });
  }
  Users users = new Users(mainUser);
  users.setId(saveUser(users));
  users.addDescription("Hey How are you");
  users.addName("John Doe");
  return users;
}
