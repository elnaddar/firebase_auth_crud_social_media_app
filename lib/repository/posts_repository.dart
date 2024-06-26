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
      'user': usersRepo.userRef,
      'likes': []
    });
  }

  CollectionReference<Map<String, dynamic>> getPosts() {
    return firestoreService.getCollection("Posts");
  }

  DocumentReference<Map<String, dynamic>> getPost(String id) {
    return getPosts().doc(id);
  }

  Future<List> getLikes(String postId) async {
    final docRef = getPost(postId);
    // Get the document snapshot
    DocumentSnapshot docSnapshot = await docRef.get();

    List<dynamic> currentList;
    if (docSnapshot.exists &&
        (docSnapshot.data() as Map).containsKey('likes')) {
      currentList = docSnapshot['likes'];
    } else {
      currentList = [];
    }
    return currentList;
  }

  Future<void> toggleLike(String postId, {required List currentList}) async {
    final docRef = getPost(postId);
    final uid = usersRepo.currentUser!.uid;
    if (currentList.contains(uid)) {
      // Remove the value if it exists
      return await docRef.update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      // Add the value if it doesn't exist
      return await docRef.update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  bool isPostLikedByUser(String postId, {required List likes}) {
    final uid = usersRepo.currentUser!.uid;
    return likes.contains(uid);
  }
}
