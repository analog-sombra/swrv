import 'package:isar/isar.dart' show Isar;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:swrv/database/models/favoritechamp.dart';

late Isar isarDB;

Future<void> isarInit() async {
  final dir = await getApplicationSupportDirectory();
  isarDB = await Isar.open(
    [FavoriteChampSchema],
    directory: dir.path,
  );
}
