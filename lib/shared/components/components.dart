

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../modules/chat/chats.dart';

Widget profileIcon({
  double? radius,
  ImageProvider<Object>? backgroundImage,

}) => CircleAvatar(

      backgroundImage: backgroundImage,
      radius: radius,

);


Widget defaultButton({
  @required String? text,
  required void Function() onPressed,
  double? height=50,
  double? width=double.infinity,
  Color? color=Colors.blue,
  Gradient? gradient=const LinearGradient(colors: [Colors.purple,Colors.pink,Colors.orange,]),
  bool useGradient = false,
}) => Container(
  height: height,
  width: width,
  decoration: useGradient ? BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(5.0),
  ):BoxDecoration(color: color,borderRadius: BorderRadius.circular(5.0),),
  child: MaterialButton(
    onPressed: onPressed,
    child:  Text(text!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  ),
);



Widget defaultFormTextField({
 TextEditingController? controller,
  String? hintText,
  Widget? icon,
  BorderRadius? borderRadius ,
  bool obsecure = false,
  String? Function(String?)? validator,
  String? Function(String?)? onSaved,
}) => TextFormField(controller: controller,
  obscureText: obsecure,
  validator: validator,
  onSaved: onSaved,
  decoration: InputDecoration(
    hintText: hintText,
    label: icon,
    hintStyle:const  TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.grey[100],
    focusedBorder:  OutlineInputBorder(borderSide: const BorderSide(width: 1,color: Color(0xffEDEDED)),borderRadius: borderRadius != null? borderRadius!: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Color(0xffEDEDED)),borderRadius: BorderRadius.circular(5)),

  ),


);


Widget stories({

  required String user,
  required String image,
})=> Row(
  children: <Widget>[
        SizedBox(
          width: 80,
          child: Column(
            children: [
              Stack(
            alignment: Alignment.center,
            children: [

              CircleAvatar(
                radius: 40,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.pink,
                        Colors.orange,
                      ],
                    ),
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 37,
                backgroundColor: Colors.white,
              ),
               CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(image) ,
              ),

            ],
          ),
              const SizedBox(height: 6,),
              Text(user,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17),)
        ],
      ),
    ),
  const SizedBox(width: 10,),
  ],
);

Widget post ({
  required BuildContext? context,
  required String? profileImage,
  required String? username,
  required String? postImage,
  String? time,
  String? caption


}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          child:  CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(profileImage!),
          ),
          onTap: (){},
        ),
        const SizedBox(
          width: 10,
        ),
         Expanded(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(time ?? "" ),

            ],
                   ),
         ),

        const Icon(Icons.more_vert),
        SizedBox(width: 8,)
      ],
    ),
    const SizedBox(
      height: 10,
    ),
    SizedBox(
      width: double.infinity,
      height: 400,
      child: Image.network(postImage!,fit: BoxFit.cover)
    ),
    const SizedBox(
      height: 10,
    ),
    Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.heart),
        ),
        IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.comment)),
        IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.paperPlane)),
        const SizedBox(
          width: 210,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_add_outlined,
              size: 30,
            )),
      ],
    ),
    const Row(
      children: [
        /*
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage(
              'https://yt3.googleusercontent.com/20NIjNT7H6jRWZ65FeO2lYeFrE8beLWH1J7RJ_DkEeWlIPhtM1zghuFIy7pwNKy3j2OPkscw=s176-c-k-c0x00ffffff-no-rj'),
        ),
        SizedBox(
          width: 5,
        ),
        Text('Liked by '),
        Text(
          'craig_love ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('and '),
        Text('44,678 others',
            style: TextStyle(fontWeight: FontWeight.bold)),
        */
      ],
    ),
     Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: Text(
              caption ?? '',
              maxLines: null,
            ),
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 20,
    ),

  ],
);


