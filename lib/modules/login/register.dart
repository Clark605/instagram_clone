import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/modules/login/start_screen.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:get_it/get_it.dart';
import '../../shared/components/components.dart';
import '../home/homescreen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  FirebaseServices? _firebaseServices;
  String? username, email, password;
  File? image;
  @override
  void initState() {
    super.initState();
    _firebaseServices = GetIt.instance.get<FirebaseServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Instagram_logo.svg.png',
          scale: 10,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    FilePicker.platform
                        .pickFiles(type: FileType.image)
                        .then((value) {
                      if (value != null && value.files.isNotEmpty) {
                        setState(() {
                          image = File(value.files.first.path!);
                        });
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultFormTextField(
                    controller: _nameController,
                    hintText: 'Username',
                    validator: (value) {
                      return value!.isEmpty ? "Please enter a username" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        username = value;
                      });
                      return null;
                    }),
                const SizedBox(height: 10),
                defaultFormTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) {
                      bool result = value!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
                      return result ? null : "Please enter a valid Email";
                    },
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                      return null;
                    }),
                const SizedBox(height: 10),
                defaultFormTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obsecure: true,
                    validator: (value) => value!.length > 8
                        ? null
                        : "Please enter a password more than 8 characters.",
                    onSaved: (value) {
                      setState(() {
                        password = value;
                      });
                      return null;
                    }),
                const SizedBox(height: 40),
                defaultButton(
                  text: 'Register',
                  color: Colors.blue,
                  onPressed: () async {
                    if (_registerFormKey.currentState!.validate() &&
                        image != null) {
                      _registerFormKey.currentState?.save();
                      bool _result = await _firebaseServices!.registerUser(
                          name: username!,
                          email: email!,
                          password: password!,
                          image: image!);
                      if (_result) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {}, // Replace with Facebook login logic
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blue),
                        child: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Register with Facebook',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {}, // Replace with Google login logic
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Image.network(
                            "http://pngimg.com/uploads/google/google_PNG19635.png"),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Register with Google',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
