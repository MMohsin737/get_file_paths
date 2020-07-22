import 'dart:async';

import 'package:flutter/services.dart';


class GetFilePaths {
  static const MethodChannel _channel = MethodChannel('get_file_paths');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> get externalRootPath async {
    final dynamic path = await _channel.invokeMethod('getRootDirectory');
    return path;
  }

  static Future<dynamic> listOfDirectories(dPath) async {
    final dynamic paths = await _channel.invokeMethod('getDirectories', {"dPath": dPath});
    return paths;
  }

  static Future<dynamic> listOfFiles(dPath) async {
    final dynamic paths = await _channel.invokeMethod('getFiles', {"dPath": dPath});
    return paths;
  }
}
