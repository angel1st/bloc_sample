import 'package:image/image.dart';
import 'package:flutter/material.dart' as mat;
import 'dart:convert';
import 'dart:typed_data';
import 'package:moor/moor.dart';

class ImageConverter extends TypeConverter<Uint8List, String> {
  Image _imageFromBase64String(String base64String) {
    return mat.Image.memory(_dataFromBase64String(base64String)).image as Image;
  }

  Uint8List _dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String _base64String(Uint8List data) {
    return base64Encode(data);
  }

  const ImageConverter();
  @override
  Uint8List mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return _dataFromBase64String(fromDb);
  }

  @override
  String mapToSql(Uint8List value) {
    if (value == null) {
      return null;
    }

    return _base64String(value);
  }
}

class Plants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get image => text().map(const ImageConverter()).nullable()();
  TextColumn get thumbnail => text().map(const ImageConverter()).nullable()();
}
