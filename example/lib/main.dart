import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_file_paths/get_file_paths.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _rootPath;
  List<dynamic> _listOfPath;
  List<dynamic> _listOfFiles;

  @override
  void initState() {
    super.initState();
    getPremission();
  }

  void getPremission() async {
    List<Permission> permission = [
      Permission.storage,
    ];
    await permission.request();
  }


  Future<void> getRootPath() async {
    var temp;
    try {
      temp = await GetFilePaths.externalRootPath;
      setState(() {
        _rootPath = temp;
      });
    } on PlatformException {}
  }

  Future<void> getListOfDirectories() async {
    var temp;
    try {
      getRootPath();
      temp = await GetFilePaths.listOfDirectories(_rootPath);
      setState(() {
        _listOfPath = temp;
      });
    } on PlatformException {}
  }

  Future<void> getListOfFiles() async {
    var temp;
//    var fPath;
//    for(var data in _listOfFiles){
//      print(data);
//      if(data.split('/').last == 'Download'){
//        print(data);
//        fPath = data;
//        break;
//      }
//    }
    try {
      var dpath = "$_rootPath/Download";
      print('_listOfFiles[3]: $dpath');
      temp = await GetFilePaths.listOfFiles(dpath);
      setState(() {
        _listOfFiles = temp;
      });
    } on PlatformException {}
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (_rootPath != null) ? Text("Path: $_rootPath") : Text("Click Button"),
              const SizedBox(
                height: 5,
              ),
              FlatButton(
                child: Text('Get Root Path'),
                onPressed: getRootPath,
              ),
              const SizedBox(
                height: 20,
              ),
              (_listOfPath != null) ? Text("Path: $_listOfPath") : Text("Click Button"),
              const SizedBox(
                height: 5,
              ),
              FlatButton(
                child: Text('Get List Of Directories'),
                onPressed: _rootPath == null ? null : getListOfDirectories,
              ),
              const SizedBox(
                height: 20,
              ),
              (_listOfFiles != null) ? Text("Path: $_listOfFiles") : Text("Click Button"),
              const SizedBox(
                height: 5,
              ),
              FlatButton(
                child: Text('Get List Of Files'),
                onPressed: _listOfPath == null ? null : getListOfFiles,
              ),
            ],
          )
        ),
      ),
    );
  }
}
