import 'package:flutter/material.dart';
import 'package:instagram_clone/modules/login/login.dart';
import 'package:instagram_clone/modules/login/register.dart';
import 'package:instagram_clone/shared/components/components.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Instagram_logo.svg.png",
                  scale: 6,),
                const SizedBox(height: 52,),
                profileIcon(
                  backgroundImage: const NetworkImage('https://yt3.ggpht.com/k9GnTpQufVqv_YafCZPzGprXXEWtcAOgRW7ztiEFWxuv7v-jpPP5eI6ZduxRP0slRB9xebgAnwA=s88-c-k-c0x00ffffff-no-rj'),
                  radius: 60.0,
                ),
                const SizedBox(height: 15,),
                const Text('jacob_w',
                  style:TextStyle(
                      fontSize: 19,
                      fontFamily: 'Instagram',
                      fontWeight: FontWeight.bold
                  ) ,),
                const SizedBox(height: 22,),
                defaultButton(text: 'Log in',onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()  ,

                )
                );}),
                const SizedBox(height: 15,),
                TextButton(onPressed: (){}, child: const Text('Switch accounts',style: TextStyle(color: Colors.blue,fontSize: 20),)),
              ],
            )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?',
                style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w300),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterPage()));
                },
                    child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17),)),

              ],

            )



          ],
        ),

      ),
    );
  }
}
