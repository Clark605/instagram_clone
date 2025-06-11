import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/services/firebase_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      appBar: AppBar(
        title: Text(
          _firebaseServices!.currentUser!["name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _firebaseServices!.logout();
              // ignore: use_build_context_synchronously
              Navigator.popAndPushNamed(context, "login");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: deviceHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: deviceWidth * 0.12,
                    backgroundImage: NetworkImage(
                      _firebaseServices!.currentUser!["image"],
                    ),
                  ),
                  _buildStatColumn("Posts", "0"), // Replace with actual post count
                  _buildStatColumn("Followers", "0"), // Replace with actual follower count
                  _buildStatColumn("Following", "0"), // Replace with actual following count
                ],
              ),
              SizedBox(height: deviceHeight * 0.015),
              Text(
                _firebaseServices!.currentUser!["name"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth * 0.045,
                ),
              ),
              SizedBox(height: deviceHeight * 0.005),
              // You can add a bio here if you have it in your user data
              // Text(
              //   "User bio goes here. A short description about the user.",
              //   style: TextStyle(fontSize: deviceWidth * 0.035),
              // ),
              SizedBox(height: deviceHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to edit profile page
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                      ),
                    ),
                  ),
                  SizedBox(width: deviceWidth * 0.02),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Action for sharing profile
                      },
                       style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Share Profile",
                         style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.02),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: deviceHeight * 0.01),
              StreamBuilder<QuerySnapshot>(
                stream: _firebaseServices!.getPostsForUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading posts."));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
                        child: const Text("No posts yet.", style: TextStyle(fontSize: 16)),
                      ),
                    );
                  }
                  List posts = snapshot.data!.docs.map((e) => e.data()).toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      Map _post = posts[index];
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_post["image"]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
