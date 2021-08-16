import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'movie_model.dart';

class MovieData extends ChangeNotifier {
  static Box<MovieModel> _box = Hive.box('movies');
  late MovieModel _updatingMovie;
  void addMovie(MovieModel movie) {
    _box.add(movie);
    notifyListeners();
  }

  int get movieCount => _box.length;

  void deleteMovie(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  void setUpdatingMovie(MovieModel currentUpdating) {
    _updatingMovie = currentUpdating;
  }

  MovieModel get updatingMovie => _updatingMovie;

  void updateMovie(int index, MovieModel updatedMovie) {
    //add the update functionality of database
    _box.putAt(index, updatedMovie);
    notifyListeners();
  }

  UnmodifiableListView<MovieModel> get movies {
    return UnmodifiableListView(_box.values.toList().cast<MovieModel>());
  }
}
