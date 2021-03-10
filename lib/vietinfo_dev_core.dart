
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vietinfo_dev_core/core/core_size.dart';
import 'package:vietinfo_dev_core/core/shared_prefs.dart';

export 'package:vietinfo_dev_core/network_api/network_datasource.dart';
export 'package:vietinfo_dev_core/network_api/network_response.dart';
export 'package:vietinfo_dev_core/widgets/widget_screen.dart';

export 'package:shared_preferences/shared_preferences.dart';
export 'package:vietinfo_dev_core/core/shared_prefs.dart';

CoreSizeDataSource core;

class VietinfoDevCore {
  static const MethodChannel _channel =
      const MethodChannel('vietinfo_dev_core');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static init(BuildContext context ){
    core = CoreSizeResponse(context);
    SharedPrefs.initializer();
  }
}
