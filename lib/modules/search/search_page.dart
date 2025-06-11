import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/modules/search/searched_post.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../shared/components/components.dart';

class InstagramSearch extends StatefulWidget {
  InstagramSearch({super.key});
  @override
  State<InstagramSearch> createState() => _InstagramSearchState();
}

class _InstagramSearchState extends State<InstagramSearch> {
  FirebaseServices? _firebaseServices;
  @override
  void initState() {
    super.initState();
    _firebaseServices = GetIt.instance.get<FirebaseServices>();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 0,
            snap: true,
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            title: GestureDetector(
                onTap: () {
                  print("pressed!");
                },
                child: const CupertinoSearchTextField()),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firebaseServices!.getLatestPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List posts =
                        snapshot.data!.docs.map((e) => e.data()).toList();
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          Map _post = posts[index];
                          return GestureDetector(
                            key: ValueKey(_post["postID"]),
                            onTap: () {
                              _navigateToPostDetails(context, _post["postID"]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_post["image"]),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
        ],
      ),
    );
  }

  void _navigateToPostDetails(BuildContext context, String postId) async {
    Map<String, dynamic> postData =
        await _firebaseServices!.fetchPostById(postId);
    try{
      if (postData.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchedPost(posT: postData),
        ),
      );
    } 
    }catch (e){
      print(e);
    }

  }
}
