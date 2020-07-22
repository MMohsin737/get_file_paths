package com.example.get_file_paths;

import androidx.annotation.NonNull;
import android.os.Environment;
import java.io.File;
import android.util.Log;
import java.util.*;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** GetFilePathsPlugin */
public class GetFilePathsPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "get_file_paths");
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "get_file_paths");
    channel.setMethodCallHandler(new GetFilePathsPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getRootDirectory")) {
      result.success(getRootDirectory());
    } else if (call.method.equals("getDirectories")) {
      Object dPath = call.argument("dPath");
      result.success(getDirectories(dPath.toString()));
    } else if (call.method.equals("getFiles")) {
      Object dPath = call.argument("dPath");
      result.success(getFiles(dPath.toString()));
    }
  }

//  ArrayList<String> getFiles() {
//    ArrayList<String> filePath = new ArrayList<String>();;
//    File file = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).toString());
//    File[] data = file.listFiles();
//    Log.i("Message:", data[0].getPath());
//    for(int i = 0; i < data.length; i++) {
//      filePath.add(data[i].getPath());
//    }
//    return filePath;
//  }

//  ArrayList<String> getDirectories() {
//    ArrayList<String> filePath = new ArrayList<String>();;
//    File file = new File(Environment.getExternalStorageDirectory().toString());
//    File[] data = file.listFiles();
//    Log.i("Message:", data[0].getPath());
//    for(int i = 0; i < data.length; i++) {
//      filePath.add(data[i].getPath());
//    }
//    return filePath;
//  }

  String getRootDirectory() {
    return Environment.getExternalStorageDirectory().toString();
  }

  ArrayList<String> getDirectories(String rootPath) {
    ArrayList<String> directoriesList = new ArrayList<String>();;
    File file = new File(rootPath);
    File[] data = file.listFiles();
    for(int i = 0; i < data.length; i++) {
      directoriesList.add(data[i].getPath());
    }
    if(directoriesList != null){
      return directoriesList;
    } else {
      return null;
    }

  }

  ArrayList<String> getFiles(String dirPath) {
    ArrayList<String> filesList = new ArrayList<String>();
    File file = new File(dirPath);
    File[] data = file.listFiles();
    for(int i = 0; i < data.length; i++) {
      filesList.add(data[i].getPath());
    }
    if(filesList != null) {
      return filesList;
    } else {
      return null;
    }
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
