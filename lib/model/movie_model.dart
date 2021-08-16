import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  late String movieName;

  @HiveField(1)
  late String directorName;

  @HiveField(2)
  late String imagePath;
}
