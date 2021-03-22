import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:vietinfo_dev_core/core/path_locals.dart';
import 'package:vietinfo_dev_core/download_files/services/api_services.dart';

class DownloadFileBloc {
  StreamController<double> streamController;

  Function( String urlFile, {String linkDownload, String path})
      startDownload;

  FileService fileService;

  DownloadFileBloc() {
    fileService = FileService();
    streamController = StreamController<double>.broadcast();

    startDownload =
        (String urlFile, {String linkDownload, String path}) async {

      var pathResult= await fileService.downloadFile(
          urlFile: urlFile,
          linkDownload: linkDownload,
          pathFolderFile: path,
          showDownloadProgress: (value) {
            streamController.sink.add(value ?? 0);
          });
      if(pathResult!=null){
        streamController.sink.add(100.0);
      }
      return pathResult;
    };
  }




  void dispose() {
    streamController.close();
  }
}
