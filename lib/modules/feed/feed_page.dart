import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/modules/chat/chats.dart';
import 'package:instagram_clone/modules/search/search_page.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:instagram_clone/shared/components/components.dart';
import 'package:instagram_clone/icons/Icon_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
    Map? user = _firebaseServices!.currentUser;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          leadingWidth: 0,
          snap: true,
          pinned: false,
          floating: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'assets/images/Instagram_logo.svg.png',
            scale: 10,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.heart),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const chatsScreen()));
              },
              icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
              color: Colors.black,
            ),
          ],
        ),
        SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firebaseServices!.getUsers(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return stories(user: data['name'], image: data['image']);
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firebaseServices!.getLatestPosts(),
                    builder: (BuildContext _context, AsyncSnapshot _SnapShot) {
                      if (_SnapShot.hasData) {
                        List _posts =
                        _SnapShot.data!.docs.map((e) => e.data()).toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          itemCount: _posts.length,
                          itemBuilder: (BuildContext context,
                              int index) {
                            Map _post = _posts[index];

                            return post(
                              context: context,
                              profileImage: _post["proImage"],
                              username: _post["username"],
                              postImage: _post["image"],
                              time: timeago.format(_post['timestamp'].toDate()),
                              caption: _post["caption"]
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            )),

      ],
    );
  }
}
