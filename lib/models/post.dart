import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String content;
  final String? imageURL;
  final Timestamp timestamp;
  final DocumentReference<Object?> user;
  final List likes;
  Post({
    required this.id,
    required this.content,
    this.imageURL,
    required this.timestamp,
    required this.user,
    required this.likes,
  });

  Post copyWith({
    String? id,
    String? content,
    String? imageURL,
    Timestamp? timestamp,
    DocumentReference<Object?>? user,
    List? likes,
  }) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      imageURL: imageURL ?? this.imageURL,
      timestamp: timestamp ?? this.timestamp,
      user: user ?? this.user,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'imageURL': imageURL,
      'timestamp': timestamp.toDate(),
      'user': user.toString(),
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      content: map['content'] as String,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      timestamp: map['timestamp'],
      user: map['user'],
      likes: List.from((map['likes'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, content: $content, imageURL: $imageURL, timestamp: $timestamp, user: $user, likes: $likes)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.imageURL == imageURL &&
        other.timestamp == timestamp &&
        other.user == user &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        imageURL.hashCode ^
        timestamp.hashCode ^
        user.hashCode ^
        likes.hashCode;
  }
}
