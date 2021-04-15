
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vietinfo_dev_core/path_provider/downloads_path_provider.dart';

enum EPathType{
  cache,
  Storage,
  Download
}

class PathFileLocals{
  Future<Directory> getPathLocal({EPathType ePathType}) async {
    Directory pathDir;
    try {

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if (ePathType == EPathType.Download && Platform.isAndroid) {
        // pathDir = await DownloadsPathProvider.downloadsDirectory;
        // pathDir =( await getExternalStorageDirectories(type: StorageDirectory.downloads)).first;
        pathDir = await DownloadsPathProvider.downloadsDirectory;
      } else if (ePathType == EPathType.Storage) {
        if (Platform.isAndroid) {
          pathDir = (await getExternalStorageDirectories()).first;
          // pathDir = (await getDownloadsDirectory());
        } else if (Platform.isIOS) {
          pathDir = await getApplicationDocumentsDirectory();
        }
      } else {
        if (Platform.isAndroid) {
          pathDir = (await getExternalCacheDirectories()).first;
        } else if (Platform.isIOS) {
          pathDir = await getTemporaryDirectory();
        }
      }
      if (pathDir != null) return pathDir;
      return null;
    } catch (error) {
      throw( "vietinfo_dev_core - $error");
      return null;
    }
  }


  Future<bool> checkExistFile({String path}) async {
    if (await File(path).exists()) {
      return true;
    } else {
      // File(path).create(recursive: true);
      return false;
    }
  }
}