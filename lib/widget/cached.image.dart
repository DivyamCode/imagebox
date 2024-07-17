import 'dart:typed_data';
// import 'package:cached_image/box/image.dart';
import 'package:flutter/material.dart';
import 'package:imagebox/helper/downloader.dart';
import 'package:imagebox/model/image.dart';
import 'package:imagebox/service/image.box.dart';

class CachedImage extends StatefulWidget {
  const CachedImage(
      {super.key,
      // required this.imageBox,
      required this.imageName,
      this.width,
      this.height,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.color,
      this.colorBlendMode,
      this.filterQuality = FilterQuality.low,
      this.cacheWidth,
      this.cacheHeight,
      this.placeholder,
      this.errorWidget,
      // required this.baseUrl,
      this.authHeader});

  // final CachedImageBox imageBox;
  final String imageName;
  // final String baseUrl;

  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? cacheWidth;
  final int? cacheHeight;
  final WidgetBuilder? placeholder;
  final WidgetBuilder? errorWidget;
  final Map<String, String>? authHeader;

  @override
  // ignore: library_private_types_in_public_api
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late bool isImageExist;
  CachedImageModel? image;
  ImageDownloader? imageDownloader;

  @override
  void initState() {
    if (ImageBoxService.isInitDone()) {
      image = ImageBoxService.getCachedImgBox.findByName(widget.imageName);
      // image = widget.imageBox.findByName(widget.imageName);
      if (image != null) {
        isImageExist = true;
      } else {
        isImageExist = false;
        imageDownloader = ImageDownloader(
            baseUrl: '${ImageBoxService.getBaseUrl}',
            authHeader: widget.authHeader,
            imagePath: widget.imageName);
      }
    }

    super.initState();
  }

  void _store() async {
    final val = await imageDownloader!.downloadImage();
    final CachedImageModel cachedImageModel = CachedImageModel(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        data: val,
        filename: widget.imageName);
    await ImageBoxService.getCachedImgBox.add(cachedImageModel);
  }

  Future<Uint8List> _downloadAndStore() async {
    if (imageDownloader == null) {
      throw Exception('ImageDownloader is null');
    } else {
      _store();

      return imageDownloader!.downloadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!ImageBoxService.isInitDone()) {
      throw Exception('ImageStore not initilized,');
    }
    if (ImageBoxService.getBaseUrl == null) {
      throw Exception('Base Url not set');
    }
    // print('isImageExist $isImageExist');

    return isImageExist && image != null
        ? Image.memory(
            image!.data,
            key: widget.key,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            alignment: widget.alignment,
            repeat: widget.repeat,
            matchTextDirection: widget.matchTextDirection,
            gaplessPlayback: widget.gaplessPlayback,
            color: widget.color,
            colorBlendMode: widget.colorBlendMode,
            filterQuality: widget.filterQuality,
            cacheWidth: widget.cacheWidth,
            cacheHeight: widget.cacheHeight,
          )
        : FutureBuilder<Uint8List>(
            future: _downloadAndStore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return widget.placeholder != null
                    ? widget.placeholder!(context)
                    : const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return widget.errorWidget != null
                    ? widget.errorWidget!(context)
                    : const Icon(Icons.error);
              } else if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  key: widget.key,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                  alignment: widget.alignment,
                  repeat: widget.repeat,
                  matchTextDirection: widget.matchTextDirection,
                  gaplessPlayback: widget.gaplessPlayback,
                  color: widget.color,
                  colorBlendMode: widget.colorBlendMode,
                  filterQuality: widget.filterQuality,
                  cacheWidth: widget.cacheWidth,
                  cacheHeight: widget.cacheHeight,
                );
              } else {
                return widget.errorWidget != null
                    ? widget.errorWidget!(context)
                    : const Icon(Icons.error);
              }
            },
          );
  }
}
