import 'package:hive/hive.dart';

part 'movieModel.g.dart'; //Model Class Adapter


@HiveType(typeId: 0)
class Movies extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String director;

  @HiveField(2)
  late String posterUrl;
  
  @HiveField(3)
  late DateTime createdDate;
}



