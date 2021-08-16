import 'package:flutter/material.dart';
import 'dart:io';

class MovieTile extends StatelessWidget {
  final String movieName;
  final String directorName;
  final String imagePath;
  final Function onPressedButton;
  MovieTile({
    required this.movieName,
    required this.directorName,
    required this.imagePath,
    required this.onPressedButton,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                movieName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              ),
              subtitle: Text(directorName),
              leading: CircleAvatar(
                backgroundImage: FileImage(File(imagePath)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: IconButton(
              splashColor: Colors.red,
              color: Colors.red,
              onPressed: () => onPressedButton('delete'),
              splashRadius: 1000.0,
              icon: Icon(
                Icons.delete,
                size: 45.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () => onPressedButton('edit'),
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                    size: 31.0,
                  ),
                  Text('Edit'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
