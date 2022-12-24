import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;

class PurchaseApi {
  static const _apiKey = 'goog_AopBypgqYAtKTJIReHJVmcGNcWw';
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);
    // PurchasesConfiguration(_apiKey);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }
}

//...

Future<void> initPlatformState() async {
  await Purchases.setDebugLogsEnabled(true);

  PurchasesConfiguration configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration("sk_bGLnfkkqBmQIZVCUaJQoxWbCsbFCz");
    // if (buildingForAmazon) {
    //   // use your preferred way to determine if this build is for Amazon store
    //   // checkout our MagicWeather sample for a suggestion
    //   configuration = AmazonConfiguration("public_amazon_sdk_key");
    // }
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration("public_ios_sdk_key");
  }
  await Purchases.configure(configuration);
}
