import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/modules/home/homescreen.dart';
import 'package:instagram_clone/modules/login/register.dart';
import 'package:instagram_clone/modules/login/start_screen.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:instagram_clone/shared/components/components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  FirebaseServices? _firebaseServices;
  @override
  void initState() {
    super.initState();
    _firebaseServices = GetIt.instance.get<FirebaseServices>();
  }

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/Instagram_logo.svg.png',
                    scale: 5,
                  ),
                ),
                const SizedBox(height: 20),
                defaultFormTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    onSaved: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: (value) {
                      bool result = value!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
                      return result ? null : "Please enter a valid Email";
                    }),
                const SizedBox(height: 10),
                defaultFormTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obsecure: true,
                    onSaved: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) => value!.length > 8
                        ? null
                        : "Please enter a password more than 8 characters."),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 20),
                defaultButton(
                    text: 'Log in',
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        _loginFormKey.currentState?.save();
                        bool _result = await _firebaseServices!
                            .loginUser(email: username!, password: password!);
                        if (_result){
                        Navigator.popAndPushNamed(context, "Home");
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text("Incorrect email or password."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      }

                    }),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log in with Facebook',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.network(
                            "http://pngimg.com/uploads/google/google_PNG19635.png"),
                        height: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log in with Google',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Expanded(
                        child: Text(
                      '                OR',
                      style: TextStyle(color: Colors.grey),
                    )),
                    Expanded(child: Divider())
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Sign up.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 17),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
