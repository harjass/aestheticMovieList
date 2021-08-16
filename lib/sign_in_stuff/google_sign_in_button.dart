import 'package:aesthetic_movie_list/pages/movie_list_page.dart';
import 'package:aesthetic_movie_list/sign_in_stuff/google_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleSignInProvider>(
      builder: (context, signInData, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextButton.icon(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.black,
            ),
            onPressed: () {
              signInData.login();
            },
          ),
        );
      },
    );
  }
}
