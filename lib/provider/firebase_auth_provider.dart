//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUserProvider =
    Provider((ref) => FirebaseAuth.instance.currentUser);

final signOutProvider =
    Provider((ref) async => await FirebaseAuth.instance.signOut());

final loginUserProvider =
    Provider.family.autoDispose((ref, List<String> list) async {
  final credential = EmailAuthProvider.credential(
    email: list.first,
    password: list.last,
  );

  await FirebaseAuth.instance.fetchSignInMethodsForEmail(list.first);
  return FirebaseAuth.instance.currentUser;
});
final registerUserProvider =
    Provider.family.autoDispose((ref, List<String> list) async {
  final credential = EmailAuthProvider.credential(
    email: list.first,
    password: list.last,
  );
  final allUsers =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(list.first);
  if (allUsers.isEmpty) {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: list.first, password: list.last);

    await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    throw Exception("this user already registered");
  }
  return FirebaseAuth.instance.currentUser;
});
