import 'package:aesthetic_movie_list/widgets/modal_bottom_sheet_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aesthetic_movie_list/model/movie_data.dart';
import 'movie_tile.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(
      builder: (context, movieData, child) {
        void onDismissed(int index) {
          return movieData.deleteMovie(index);
        }

        void onEdited(int index) async {
          //send new movie data from here after calling a form
          var updatedMovie = movieData.movies[index];
          movieData.setUpdatingMovie(updatedMovie);
          await modalBottomSheetBuilder('edit', context);
          updatedMovie = movieData.updatingMovie;
          return movieData.updateMovie(index, updatedMovie);
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final movie = movieData.movies[index];
            return Dismissible(
              key: ObjectKey(movie),
              background: Card(color: Colors.redAccent),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => onDismissed(index),
              child: Container(
                child: MovieTile(
                  movieName: movie.movieName,
                  directorName: movie.directorName,
                  imagePath: movie.imagePath,
                  onPressedButton: (val) {
                    if (val == 'delete') {
                      onDismissed(index);
                    } else {
                      //add edit button function
                      onEdited(index);
                    }
                  },
                ),
              ),
            );
          },
          itemCount: movieData.movieCount,
        );
      },
    );
  }
}
