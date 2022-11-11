import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // ignore: prefer_const_literals_to_create_immutables
      body: Center(
        child: Column(children: [
          SizedBox(height: Get.height/15,),
          const CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(
              'https://source.unsplash.com/72x72/?portrait', //TODO get image from profile
            ),
          ),
          SizedBox(
            height: Get.height / 40,
          ),
          Text('Номер QIWI кошелька'),
          SizedBox(
            height: Get.height / 50,
          ),
          Text('+7 999 999-11-11') //TODO get phone number from personal info
        ]),
      ),
    );
  }
}
