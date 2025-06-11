import 'package:flutter/material.dart';
import 'package:instagram_clone/shared/components/components.dart';

class chatsScreen extends StatefulWidget {
  const chatsScreen({super.key});

  @override
  State<chatsScreen> createState() => _chatsScreenState();
}

class _chatsScreenState extends State<chatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clark_remon911',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                defaultFormTextField(
                  hintText: 'Search',
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
        ));
  }
}
