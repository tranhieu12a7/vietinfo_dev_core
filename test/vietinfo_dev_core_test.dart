import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vietinfo_dev_core/vietinfo_dev_core.dart';

void main() {
  const MethodChannel channel = MethodChannel('vietinfo_dev_core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VietinfoDevCore.platformVersion, '42');
  });
}
