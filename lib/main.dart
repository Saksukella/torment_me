import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:torment/adService/adState.dart';
import 'package:torment/resources/app_strings.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/services/sharedPreferences.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppSharedPreferences().init();
  final status = MobileAds.instance.initialize();
  final AdState adState = AdState(status);

  runApp(Provider.value(value: adState, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = Get.put(AuthService());
    return Obx(() {
      String displayName = auth.getUser?.displayName ?? "";
      return GetMaterialApp(
        title: 'Torment',
        themeMode: AppSharedPreferences.getBool(AppStrings.getTheme_KEY) ?? true
            ? ThemeMode.dark
            : ThemeMode.light,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
        ),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage(),
      );
    });
  }
}
