import 'package:aesthetic_movie_list/model/movie_data.dart';
import 'package:aesthetic_movie_list/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class AddMoviePage extends StatefulWidget {
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  String? newMovieName;

  String? newDirectorName = ' ';

  String? newImagePath;

  void addMovieButtonPressed(BuildContext context) {
    if (newMovieName != null) {
      MovieModel movie = MovieModel();
      movie.movieName = newMovieName!;
      movie.directorName = newDirectorName!;
      movie.imagePath = newImagePath!;
      Provider.of<MovieData>(context, listen: false).addMovie(movie);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Movie to WatchList',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  'Movie:',
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (newValue) {
                    newMovieName = newValue;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  'Director:',
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (newValue) {
                    newDirectorName = newValue;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 0,
                child: Text(
                  'Image:',
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton.icon(
                  label: Text(
                    newImagePath == null ? 'Pick Image' : 'Change Image',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  icon: newImagePath == null
                      ? Icon(Icons.photo)
                      : CircleAvatar(
                          backgroundImage: FileImage(File(newImagePath!)),
                        ),
                  onPressed: () async {
                    newImagePath = await pickImage();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          TextButton(
            onPressed: () {
              addMovieButtonPressed(context);
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color?>(Colors.lightBlueAccent),
              overlayColor: MaterialStateProperty.all<Color?>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> pickImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    String imagePath = image!.path;
    File imageFile = File(imagePath);
    print(imagePath);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imagePath);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    print(savedImage.path);
    return savedImage.path;
  }
}
