import 'package:crud/screens/Cart_screen_main.dart';
import 'package:crud/screens/checkout_screen.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUpAll(() => {loadAppFonts()});
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const SignUpScreen(),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: ThemeData.light(),
        platform: TargetPlatform.android,
      ),
    );
    await screenMatchesGolden(
        tester, 'd');
  });
}