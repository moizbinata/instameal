import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/controllers/buttonController.dart';
import 'package:instameal/controllers/notifcontroller.dart';
import 'package:instameal/controllers/searchcategcontroller.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/controllers/videocontroller.dart';
import 'package:instameal/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:instameal/views/subscription/trial_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

import 'controllers/weeklyController.dart';
import 'navigation/bottom_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(2213, 'OrhGvNRGIp5m6evvdmk6Fq', null, null);
  await GetStorage.init();
  Stripe.publishableKey =
      "pk_test_51M5RsSAWiGvBL24r3ciLB2N7cawdGDI3W7noy5fRvyqA8KQcO8c92uKE1Xpp2RloqJkgTafnuK4qN8oRsAozkNY400tVMtqji8";
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final UniversalController universalController =
      Get.put(UniversalController());
  final VideoController videoController = Get.put(VideoController());
  final ButtonController buttonController = Get.put(ButtonController());
  final WeeklyController weeklyController = Get.put(WeeklyController());
  final SearchCategController searchCategController =
      Get.put(SearchCategController());

  final NotifController notifController = Get.put(NotifController());
  DateTime now = DateTime.now();
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(()=>DataContr)
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        AutoOrientation.portraitAutoMode();
        SizeConfig().init(constraints, orientation);

        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Instameal',
            theme: CustomTheme.themedata,
            home: box.read('username') == null
                ? SplashScreen()
                : (box.read('subscriptionEnd') != null)
                    ? (now.isAfter(DateTime.parse(
                            box.read('subscriptionEnd').toString())))
                        ? TrialScreen()
                        : BottomNavigator() //BottomNavigator
                    : SplashScreen());
      });
    });
  }
}
