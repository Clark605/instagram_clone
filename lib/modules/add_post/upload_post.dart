import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/modules/home/homescreen.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:instagram_clone/shared/components/components.dart';

class GalleryGridView extends StatefulWidget {
  const GalleryGridView({super.key});
  @override
  _GalleryGridViewState createState() => _GalleryGridViewState();
}

class _GalleryGridViewState extends State<GalleryGridView> {
  @override
  void initState() {
    super.initState();
    _firebaseServices = GetIt.instance.get<FirebaseServices>();
    _captionController = TextEditingController();
  }
  FirebaseServices? _firebaseServices;
  File? _image;
  String? caption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _image != null && caption != null && caption!.isNotEmpty
                ? _uploadImage
                : null,
            child: Text(
              'Share',
              style: TextStyle(
                color: _image != null && caption != null && caption!.isNotEmpty
                    ? Colors.blueAccent
                    : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? const Icon(
                            FontAwesomeIcons.image,
                            color: Colors.grey,
                            size: 30,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    maxLines: 3,
                    onChanged: (val) {
                      setState(() {
                        caption = val;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Add more options like Tag People, Add Location, etc. here if needed
          // For example:
          // _buildOptionRow(FontAwesomeIcons.userTag, 'Tag People'),
          // _buildOptionRow(FontAwesomeIcons.mapMarkerAlt, 'Add Location'),
        ],
      ),
    );
  }

  late TextEditingController _captionController;

  Widget _buildOptionRow(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: FaIcon(icon, color: Colors.black),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          onTap: () {
            // Handle option tap
            print('$title tapped');
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, color: Colors.grey),
        ),
      ],
    );
  }

  void _selectImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _image = File(result.files.first.path!);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null || caption == null || caption!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image and write a caption.')),
      );
      return;
    }
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      await _firebaseServices!.postImage(_image!, caption!);

      // Hide loading indicator
      Navigator.of(context).pop(); // Close the dialog

      setState(() {
        _image = null;
        caption = null;
        _captionController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post uploaded successfully!')),
      );
      // Optionally navigate to home screen or another page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
      );

    } catch (e) {
      // Hide loading indicator
      Navigator.of(context).pop(); // Close the dialog

      print('Error uploading post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload post: $e')),
      );
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }
}


