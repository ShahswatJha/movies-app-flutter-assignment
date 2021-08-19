import 'package:hive/hive.dart';
import 'package:movies_app_assignment_1828194/models/movieModel.dart';


class Boxes {
  static Box<Movies> getMovies() =>
      Hive.box<Movies>('movies');
}

