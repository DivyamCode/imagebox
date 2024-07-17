
import 'dart:convert';
import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class CachedImageModel {
   @Id()
   int id;
   String filename;
   Uint8List data;
   ////DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
   int createdAt;
   int? futureRefresh;
   CachedImageModel({required this.createdAt,required this.data,required this.filename,this.futureRefresh,this.id=0});
   
   // Convert a CachedImageModel into a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filename': filename,
      'data': base64Encode(data),
      'createdAt': createdAt,
      'futureRefresh': futureRefresh,
    };
  }

  // Convert a Map into a CachedImageModel.
  factory CachedImageModel.fromJson(Map<String, dynamic> json) {
    return CachedImageModel(
      id: json['id'] ?? 0,
      filename: json['filename'],
      data: base64Decode(json['data']),
      createdAt: json['createdAt'],
      futureRefresh: json['futureRefresh'],
    );
  }
}