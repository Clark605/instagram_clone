import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import '../../shared/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchedPost extends StatelessWidget {
  final Map<String, dynamic> posT;
  SearchedPost({super.key, required this.posT});

  FirebaseServices? _firebaseServices;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Explore",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            post(
                context: context,
                profileImage: posT["proImage"],
                username: posT["username"],
                postImage: posT["image"],
                time: timeago.format(posT['timestamp'].toDate()),
                caption: posT["caption"]),
          ],
        ));
  }
}
