import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vietinfo_dev_core/core/path_locals.dart';
import 'package:vietinfo_dev_core/download_files/blocs/bloc.dart';
import 'package:vietinfo_dev_core/vietinfo_dev_core.dart';

class WidgetDownloadFile extends StatefulWidget {
  Function childChange;
  String urlFile;
  Function(double) onChangeValue;

  WidgetDownloadFile({Key key, this.childChange, this.onChangeValue,this.urlFile})
      : super(key: key);

  @override
  _WidgetDownloadFileState createState() =>
      _WidgetDownloadFileState(
          onChangeValue: this.onChangeValue, childChange: this.childChange);
}

class _WidgetDownloadFileState extends State<WidgetDownloadFile> {
  final Function(double) onChangeValue;
  final Function childChange;
  DownloadFileBloc bloc;

  _WidgetDownloadFileState({this.onChangeValue, this.childChange});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = DownloadFileBloc();
    VietinfoDevCore.downloadFileBloc = bloc;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  checkFile(String urlFile) async {
    try {
      var temp = urlFile.split('/');
      String fileName = temp[temp.length - 1];
      var tempDir =
      await PathFileLocals().getPathLocal(ePathType: EPathType.Download);
      File file = new File("${tempDir.path}/${fileName}");
      if (await PathFileLocals().checkExistFile(path: file.path) == true) {
        return true;
      }
      return false;
    }
    catch (error) {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.streamController.stream,
        builder: (context, snapshot) {
          print("${snapshot.data}");
          if (snapshot.hasData && snapshot.data != null) {
            onChangeValue?.call(snapshot.data);
            return childChange.call(snapshot.data);
          }
          // return  ( checkFile(widget.urlFile)==true)? childChange.call(100.0):childChange.call(0.0);
          return FutureBuilder(
            future:  checkFile(widget.urlFile),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return snapshot.data ? childChange.call(100.0) : childChange.call(
                    0.0);
              return CircularProgressIndicator(
                strokeWidth: 1.0,
              );
            },
          );
        });
  }
}
