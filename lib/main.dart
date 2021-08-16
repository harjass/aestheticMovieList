import 'package:aesthetic_movie_list/model/movie_data.dart';
import 'package:aesthetic_movie_list/model/movie_model.dart';
import 'package:aesthetic_movie_list/pages/movie_list_page.dart';
import 'package:aesthetic_movie_list/pages/sign_in_page.dart';
import 'package:aesthetic_movie_list/sign_in_stuff/google_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<MovieModel>(MovieModelAdapter());
  await Hive.openBox<MovieModel>('movies');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Aesthetic MovieList';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieData(),
      child: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(primarySwatch: Colors.lightBlue),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return MovieListPage();
              } else {
                return SignInPage();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
}
