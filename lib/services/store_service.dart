import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final _instance = FirebaseFirestore.instance;

  Future<void> createDocument({
    required String collectionPath,
    String? path,
    required Map<String, dynamic> data,
    SetOptions? options,
  }) async {
    await _instance.collection(collectionPath).doc(path).set(data, options);
  }

  CollectionReference<Map<String, dynamic>> getCollection(collectionPath) {
    return _instance.collection(collectionPath);
  }
}
