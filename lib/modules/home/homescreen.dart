import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/modules/add_post/upload_post.dart';
import 'package:instagram_clone/modules/chat/chats.dart';
import 'package:instagram_clone/modules/profile/profile_page.dart';
import 'package:instagram_clone/modules/search/search_page.dart';
import 'package:instagram_clone/shared/components/components.dart';
import 'package:instagram_clone/icons/Icon_data.dart';

import '../feed/feed_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int currentpage =0;

 final List<Widget> pages = [
    FeedScreen(),
   InstagramSearch(),
   const GalleryGridView(),
   Container(color: Colors.red,),
   const ProfilePage()
 ];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: deviceHeight*0.07,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(MyIcons.home1, color: currentpage == 0 ? Colors.redAccent : Colors.black54), onPressed: () => setState(() => currentpage = 0)),
              IconButton(icon: Icon(Icons.search, color: currentpage == 1 ? Colors.redAccent : Colors.black54), onPressed: () => setState(() => currentpage = 1)),
              IconButton(icon: Icon(FontAwesomeIcons.plus, color: currentpage == 2 ? Colors.redAccent : Colors.black54), onPressed: () => setState(() => currentpage = 2)),
              IconButton(icon: Icon(FontAwesomeIcons.film, color: currentpage == 3 ? Colors.redAccent : Colors.black54), onPressed: () => setState(() => currentpage = 3)),
              IconButton(icon: Icon(Icons.person, color: currentpage == 4 ? Colors.redAccent : Colors.black54), onPressed: () => setState(() => currentpage = 4)),
            ],
          ),
        ),
      ),
      body: pages[currentpage],
    );
  }
}
/*
BottomNavigationBar(
          iconSize: 24,
            selectedIconTheme:const IconThemeData(
              color: Colors.redAccent
            ),
            unselectedIconTheme:const IconThemeData(
                color: Colors.black54,
            ) ,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentpage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (ind){
              setState(() {
                currentpage = ind;
              });
            },
            items:const [
              BottomNavigationBarItem(icon: Icon(MyIcons.home1),label: " "),
              BottomNavigationBarItem(icon: Icon(Icons.search,),label: " "),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plus),label: " "),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.film),label: " "),
              BottomNavigationBarItem(icon: Icon(Icons.person,),label: " "),
            ]
        )
 */
