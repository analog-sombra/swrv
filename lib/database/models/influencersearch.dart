import 'package:isar/isar.dart';
part 'influencersearch.g.dart';

@Collection()
class InfluencerSearch {
  Id id = Isar.autoIncrement;

  @Index()
  String? name;

  @Index()
  String? category;

  @Index()
  String? platforms;

  @Index()
  String? city;

  @Index()
  String? isActive;
}
