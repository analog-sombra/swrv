import 'package:isar/isar.dart';
part 'favoritechamp.g.dart';

@Collection()
class FavoriteChamp {
  Id id = Isar.autoIncrement;

  @Index()
  String? name;

  @Index()
  String? img;

  @Index()
  String? champid;
}
