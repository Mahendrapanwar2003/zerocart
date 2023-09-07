import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/my_theme/my_themedata.dart';
import 'package:zerocart/notification.dart';
import 'app/routes/app_pages.dart';


Future<void> onBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    NotificationServiceForAndroid().sendNotification(
        title: message.notification!.title!,
        body: message.notification!.body!);
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  CommonMethods.getNetworkConnectionType();
  StreamSubscription streamSubscription = CommonMethods.checkNetworkConnection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ResponsiveSizer(
          builder: (
            buildContext,
            orientation,
            screenType,
          ) =>
              GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
                themeMode: ThemeMode.system,
            theme: MyThemeData.themeDataLight(
              orientation: orientation,
              fontFamily: "Nunito",
            ),
            darkTheme: MyThemeData.themeDataDark(
              orientation: orientation,
              fontFamily: "Nunito",
            ),
          ),
        ),
      ),
    );
  });
}