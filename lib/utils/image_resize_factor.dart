import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ResizeImageAtLevel {
  Uint8List targetlUinit8List;
  Uint8List originalUnit8List;

  Future<Uint8List> resizeImage(String imageUrl, int height, int width) async {
//    String imageUrl = 'https://picsum.photos/250?image=9';
    http.Response response = await http.get(imageUrl);
    originalUnit8List = response.bodyBytes;

    ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
    ByteData originalByteData = await originalUiImage.toByteData();
    print('original image ByteData size is ${originalByteData.lengthInBytes}');

    var codec = await ui.instantiateImageCodec(originalUnit8List,
        targetHeight: height, targetWidth: width);
    var frameInfo = await codec.getNextFrame();
    ui.Image targetUiImage = frameInfo.image;
    ByteData targetByteData =
        await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    print('target image ByteData size is ${targetByteData.lengthInBytes}');
    targetlUinit8List = targetByteData.buffer.asUint8List();
    return targetlUinit8List;
  }
}
