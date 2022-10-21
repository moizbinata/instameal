import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/controllers/buttonController.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/splash/splash.dart';

import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

import 'controllers/weeklyController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey =
      "pk_test_51LrfHXLDjGMiS5VVRKgjoWZ8Oe4oMPRPlklTITymbmOOgPqrr9VWUk66JJgdVTRjp2YI4Sa2icu7bQN6Z9B5ZKMr00GnHYyJLN";
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final ButtonController buttonController = Get.put(ButtonController());
  final WeeklyController weeklyController = Get.put(WeeklyController());
  final UniversalController universalController =
      Get.put(UniversalController());
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
