import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/services/store_service.dart';

class PostsRepository {
  final UsersRepository usersRepo;
  final FireStoreService firestoreService;

  PostsRepository({
    required this.usersRepo,
    required this.firestoreService,
  });

  Future<void> createPost({required String content, String? imageURL}) async {
    await firestoreService.createDocument(collectionPath: "Posts", data: {
      'content': content,
      'imageURL': imageURL,
      'timestamp': Timestamp.now(),
      'user': usersRepo.userRef
    });
  }

  CollectionReference<Map<String, dynamic>> getPosts() {
    return firestoreService.getCollection("Posts");
  }

  DocumentReference<Map<String, dynamic>> getPost(String id) {
    return getPosts().doc(id);
  }
}
