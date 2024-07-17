import 'package:catchimagebox/box/image.dart';
import 'package:catchimagebox/service/image.store.dart';

class ImageBoxService {
  // bool initDone = false;
  static late ImageStore? _imageStore;
  static String? _baseUrl;

  static setBaseUrl(String baseurl) {
    ImageBoxService._baseUrl = baseurl;
  }

  static String? get getBaseUrl => ImageBoxService._baseUrl;

  static Future<void> initialize() async {
    ImageBoxService._imageStore = await ImageStore.create();
  }

  static Future<void> clean() async {
    if (ImageBoxService._imageStore != null) {
      ImageBoxService._imageStore!.clean();
    }
  }

  static CachedImageBox cachedImageBoxCheckInit() {
    if (ImageBoxService._imageStore != null) {
      return ImageBoxService._imageStore!.cachedImageBox;
    } else {
      throw Exception('ImageStore not initilized,');
    }
  }

  static bool isInitDone() {
    try {
      ImageBoxService._imageStore!.cachedImageBox.findByName('');
      return true;
    } catch (e) {
      return false;
    }
  }

  static CachedImageBox get getCachedImgBox =>
      ImageBoxService.cachedImageBoxCheckInit();
}
