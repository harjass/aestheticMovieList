import 'package:aesthetic_movie_list/model/movie_data.dart';
import 'package:aesthetic_movie_list/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EditMoviePage extends StatefulWidget {
  @override
  _EditMoviePageState createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieData>(context);
    MovieModel currentMovie = provider.updatingMovie;
    String newMovieName = currentMovie.movieName;
    String newDirectorName = currentMovie.directorName;
    String newImagePath = currentMovie.imagePath;

    TextEditingController movieNameController = TextEditingController();
    TextEditingController directorNameController = TextEditingController();

    movieNameController.text = newMovieName;
    directorNameController.text = newDirectorName;

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Change Movie and Update List',
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
                  'Change Movie:',
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: movieNameController,
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
                  'Change Director:',
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: directorNameController,
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
                    'Change Image',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  icon: CircleAvatar(
                    backgroundImage: FileImage(File(newImagePath)),
                  ),
                  onPressed: () async {
                    newImagePath = await pickImage();
                    setState(() {
                      currentMovie.movieName = newMovieName;
                      currentMovie.directorName = newDirectorName;
                      currentMovie.imagePath = newImagePath;
                      provider.setUpdatingMovie(currentMovie);
                    });
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
              currentMovie.movieName = newMovieName;
              currentMovie.directorName = newDirectorName;
              currentMovie.imagePath = newImagePath;
              provider.setUpdatingMovie(currentMovie);
              Navigator.pop(context);
            },
            child: Text(
              'Update',
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
    print(imagePath);
    //
    // Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    // String appDocumentsPath = appDocumentsDirectory.path;
    // String filePath = '$appDocumentsPath/cached_temp_image}';
    // File file = File(filePath);
    // file.
    return imagePath;
  }
}
