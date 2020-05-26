import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Post.dart';
import 'package:reddrop/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});
  int postId = 1;

  String timestamp = DateTime.now().second.toString();
  final CollectionReference usersCollection =
      Firestore.instance.collection('Users');
  final CollectionReference postsCollection =
      Firestore.instance.collection('Posts');

  updateUserData(String name, String phone, String city, String bloodGroup,
      String picUrl, bool status) async {
    await usersCollection.document(uid).setData({
      'name': name,
      'phone': phone,
      'city': city,
      'bloodGroup': bloodGroup,
      'picUrl': picUrl,
      'status': status,
    });
  }

  createPost(String postId, String name, String image, String postContent,
      String time) async {
    await postsCollection.add({
      'name': name,
      'image': image,
      'postContent': postContent,
      'time': time
    });
  }

  List<Post> _postListFromFirebase(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(doc.data['name'], doc.data['image'], doc.data['postContent'],
          doc.data['time']);
    }).toList();
  }

  Stream<List<Post>> get postList {
    return postsCollection.snapshots().map(_postListFromFirebase);
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          name: doc.data['name'] ?? '',
          phone: doc.data['phone'] ?? '',
          city: doc.data['city'] ?? '',
          bloodGroup: doc.data['bloodGroup'] ?? '',
          picUrl: doc.data['picUrl'],
          status: doc.data['status']);
    }).toList();
  }

  Stream<List<User>> get userList {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }

  User _currentUserFromFirebaseUser(DocumentSnapshot document) {
    return User(
      uid: document.data['uid'],
      name: document.data['name'],
      phone: document.data['phone'],
      bloodGroup: document.data['bloodGroup'],
      city: document.data['city'],
      picUrl: document.data['picUrl'],
      status: document.data['status'],
    );
  }

  Stream<User> get currentUser {
    return usersCollection
        .document(uid)
        .snapshots()
        .map(_currentUserFromFirebaseUser);
  }
}
