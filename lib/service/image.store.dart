// ignore: depend_on_referenced_packages
import 'package:imagebox/box/image.dart';
import 'package:imagebox/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ImageStore {
  late final Store _store;

  late CachedImageBox cachedImageBox;
  
  ImageStore._create(this._store) {
    cachedImageBox = CachedImageBox(_store);
  }

  static Future<ImageStore> create() async {
    final store = await openStore(
        directory: p.join(
            (await getApplicationDocumentsDirectory()).path, "obx-demo-cahed-image"));
    return ImageStore._create(store);
  }

  Future<void> clean() async {
    cachedImageBox.removeAll();
    
  }
}
