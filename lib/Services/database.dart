import 'package:brew_app/Models/brew.dart';
import 'package:brew_app/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updataUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  // brew list from fireStore
  List<Brew> _brewListFromShapshost(QuerySnapshot snapshot) {
    return snapshot.documents.map((b) {
      return Brew(
          name: b.data['name'] ?? '',
          sugars: b.data['sugars'] ?? '',
          strength: b.data['strength'] ?? 0);
    }).toList();
  }

  // userData form shapshot
  UserData _userDataFromShapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromShapshost);
  }

  //get user dc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromShapshot);
  }
}
