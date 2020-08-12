import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stad_project/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference carCollection =
      Firestore.instance.collection('cars');

  Future updateUserData(String email, String name, String contact) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'contact': contact,
    });
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        email: snapshot.data['email'],
        name: snapshot.data['name'],
        contact: snapshot.data['contact']);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
