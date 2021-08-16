import 'package:aesthetic_movie_list/model/movie_data.dart';
import 'package:aesthetic_movie_list/sign_in_stuff/google_provider.dart';
import 'package:aesthetic_movie_list/widgets/modal_bottom_sheet_builder.dart';
import 'package:aesthetic_movie_list/widgets/movie_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            modalBottomSheetBuilder('add', context);
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoURL.toString()),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),
                    Spacer(),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      color: Colors.white,
                      splashColor: Colors.yellow,
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Hey, \n${user.displayName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'You have seen ${Provider.of<MovieData>(context).movieCount} Movies!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: MovieList(),
            ),
          ),
        ],
      ),
    );
  }
}
