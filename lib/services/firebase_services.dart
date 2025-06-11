import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String USER_COLLECTION = "users";
final String POST_COLLECTION = "posts";

class FirebaseServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Map? currentUser;

  FirebaseServices();
  Future<bool> registerUser(
      {required String name,
      required String email,
      required String password,
      required File image}) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String Userid = _userCredential.user!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask _task =
          _storage.ref('images/$Userid/$_fileName').putFile(image);
      return _task.then((_snapshot) async {
        String _downloadURl = await _snapshot.ref.getDownloadURL();
        await _db.collection(USER_COLLECTION).doc(Userid).set({
          'name': name,
          'email': email,
          'image': _downloadURl,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTION).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> postImage(File _image, String? caption) async {
    try {
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(_image.path);
      String Userid = _auth.currentUser!.uid;

      UploadTask _task =
          _storage.ref('images/$Userid/$_fileName').putFile(_image);
      return await _task.then((_snapshot) async {
        String _downloadURl = await _snapshot.ref.getDownloadURL();
        await _db.collection(POST_COLLECTION).add({
          'userID': Userid,
          'postID': _db.collection(POST_COLLECTION).doc().id,
          'timestamp': Timestamp.now(),
          'image': _downloadURl,
          'username': currentUser!["name"],
          'proImage': currentUser!["image"],
          'caption': caption ?? '',
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String _userID = _auth.currentUser!.uid;
    return _db
        .collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .where("userID", isEqualTo: _userID)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getAPost({required String doc}) {
    return _db.collection(POST_COLLECTION).doc(doc).snapshots();
  }

  Future<Map<String, dynamic>> fetchPostById(String postId) async {
    DocumentSnapshot doc =
        await _db.collection(POST_COLLECTION).doc(postId).get();
    try{

        return doc.data() as Map<String, dynamic>;
       // Handle the case where the post doesn't exist


    }
    catch (e){
      print(e);
      return {};
    }
  }

  Stream<QuerySnapshot> getUsers() {
    return _db.collection(USER_COLLECTION).snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
