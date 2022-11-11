import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: Center(
        child: Column(children: [
          SizedBox(height: 50,),
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://source.unsplash.com/60x60/?portrait', //TODO get image from profile
            ),
          ),
          Text('Номер QIWI кошелька'),
          Text('+7 999 999-11-11') //TODO get phone number from personal info
        ]),
      ),
    );
  }
}
