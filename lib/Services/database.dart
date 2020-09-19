import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_coffie/Models/brew.dart';
import 'package:hello_coffie/Models/user.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  //collection references
  final CollectionReference brewsCollection =
      Firestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewsCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from Snapshot!
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

//UserData  From Snapshot!
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get brews Stream
  Stream<List<Brew>> get brews {
    return brewsCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user documents stream
  Stream<UserData> get userData {
    return brewsCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
