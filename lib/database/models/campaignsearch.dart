import 'package:isar/isar.dart';
part 'campaignsearch.g.dart';

@Collection()
class CampaignSearch {
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
