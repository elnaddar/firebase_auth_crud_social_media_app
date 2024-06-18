import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final _instance = FirebaseFirestore.instance;

  createDocument({
    required String collectionPath,
    String? path,
    required Map<String, dynamic> data,
    SetOptions? options,
  }) {
    _instance.collection(collectionPath).doc(path).set(data, options);
  }
}
