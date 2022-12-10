import 'package:isar/isar.dart';
part 'favoritebrand.g.dart';

@Collection()
class FavoriteBrand {
  Id id = Isar.autoIncrement;

  @Index()
  String? name;

  @Index()
  String? img;

  @Index()
  String? brandid;
}
