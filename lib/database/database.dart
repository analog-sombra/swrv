import 'package:isar/isar.dart' show Isar;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:swrv/database/models/campaignsearch.dart';
import 'package:swrv/database/models/favoritebrand.dart';
import 'package:swrv/database/models/favoritechamp.dart';

import 'models/influencersearch.dart';

late Isar isarDB;

Future<void> isarInit() async {
  final dir = await getApplicationSupportDirectory();
  isarDB = await Isar.open( 
    [
      FavoriteChampSchema,
      FavoriteBrandSchema,
      CampaignSearchSchema,
      InfluencerSearchSchema,
    ],
    directory: dir.path,
  );
}
