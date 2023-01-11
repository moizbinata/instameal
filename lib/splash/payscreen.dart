import 'package:flutter/material.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await Purchases.purchaseProduct("productIdentifier");
              },
              child: Text("purchase prod")),
          ElevatedButton(
              onPressed: () async {
                await Purchases.purchaseProduct("productIdentifier");
              },
              child: Text("subs")),
        ],
      ),
    );
  }
}
