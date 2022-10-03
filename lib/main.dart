import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/splash/splash.dart';

import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(()=>DataContr)
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instameal',
          theme: CustomTheme.themedata,
          // initialRoute: RouteClass.getHomeRoute(),
          home: SplashScreen(),
        );
      });
    });
  }
}
