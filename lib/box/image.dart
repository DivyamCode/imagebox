

import 'package:imagebox/box/box.dart';
import 'package:imagebox/model/image.dart';
import 'package:imagebox/objectbox.g.dart';


class CachedImageBox extends MyBox<CachedImageModel> {
  CachedImageBox(super.store);

  CachedImageModel? findByName(String name) {
    Query<CachedImageModel> query = box
        .query(CachedImageModel_.filename.equals(name))
        .build();
    List<CachedImageModel> listImage= query.find();
    query.close();
    return listImage.isNotEmpty ? listImage[0] : null;
  }
}