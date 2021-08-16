import 'package:aesthetic_movie_list/pages/add_movie_page.dart';
import 'package:aesthetic_movie_list/pages/edit_movie_page.dart';
import 'package:flutter/material.dart';

dynamic modalBottomSheetBuilder(String typeOfSheet, BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.0),
        topLeft: Radius.circular(30.0),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
//remove this if it looks weird
      padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 15.0),
      child: typeOfSheet == 'add' ? AddMoviePage() : EditMoviePage(),
    ),
  );
}
