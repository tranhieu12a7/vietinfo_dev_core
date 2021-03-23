import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vietinfo_dev_core/core/path_locals.dart';
import 'package:vietinfo_dev_core/download_files/blocs/bloc.dart';
import 'package:vietinfo_dev_core/download_files/models/model_download.dart';
import 'package:vietinfo_dev_core/vietinfo_dev_core.dart';

class WidgetDownloadFileMain extends StatelessWidget {
  final String urlFile;
  final AsyncWidgetBuilder<ModelDownload> builder;

  const WidgetDownloadFileMain({Key key, this.urlFile,this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: WidgetDownloadFile(builder: builder,urlFile: urlFile,),
      create: (context) => DownloadFileBloc(),
    );
  }
}

class WidgetDownloadFile extends StatefulWidget {
  final String urlFile;
  final AsyncWidgetBuilder<ModelDownload> builder;

  WidgetDownloadFile({Key key, this.urlFile, this.builder}) : super(key: key);

  @override
  _WidgetDownloadFileState createState() => _WidgetDownloadFileState();
}

class _WidgetDownloadFileState extends State<WidgetDownloadFile> {
  DownloadFileBloc bloc ;
  ModelDownload modelDownload;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc=BlocProvider.of<DownloadFileBloc>(context);
    VietinfoDevCore.downloadFileBloc = bloc;
    modelDownload = new ModelDownload(value: 0.0, urlFile: widget.urlFile);
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
      return false;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("WidgetDownloadFile");
    // if (modelDownload == null)
    //   modelDownload = new ModelDownload(value: 0.0, urlFile: widget.urlFile);
    return FutureBuilder(
      future: checkFile(modelDownload.urlFile),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data)
            return widget.builder.call(
                context,
                AsyncSnapshot<ModelDownload>.withData(
                    ConnectionState.done, modelDownload.clone(value: 100.0)));
          else {
            return StreamBuilder(
              builder: widget.builder,
              stream: bloc.streamController.stream,
            );
            // return  childChange.call(modelDownload.clone(value: 0.0));
          }
        }
        return CircularProgressIndicator(
          strokeWidth: 1.0,
        );
      },
    );


  }
}
