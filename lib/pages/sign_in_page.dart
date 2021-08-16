import 'package:aesthetic_movie_list/sign_in_stuff/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                "Welcome to Aesthetic Movie List.\nAdd Your Favourites",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            'You can only add movies after\nLogging In with Google.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Spacer(),
          GoogleSignInButton(),
          Spacer(),
        ],
      ),
    );
  }
}
