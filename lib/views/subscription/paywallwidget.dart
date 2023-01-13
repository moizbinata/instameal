import 'package:flutter/material.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/subscription/appdata.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/constant.dart';

class Paywall extends StatefulWidget {
  final offering;

  const Paywall({Key key, @required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: CustomTheme.bgColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              child: const Center(child: Text('✨ Instameal Plans Premium')),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  'Instameal Plans we are offering: ',
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: Colors.white,
                  child: ListTile(
                      onTap: () async {
                        try {
                          CustomerInfo customerInfo =
                              await Purchases.purchasePackage(
                                  myProductList[index]);
                          if (customerInfo
                              .entitlements.all[entitlementID].isActive) {
                            print("MOIZ IS PAID");
                          } else {
                            print("MOIZ IS NOT PAID");
                          }

                          // appData.entitlementIsActive = customerInfo
                          //     .entitlements.all[entitlementID].isActive;
                        } catch (e) {
                          print(e);
                          print("payment  error");
                        }

                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: Text(
                        myProductList[index].storeProduct.title,
                      ),
                      subtitle: Text(
                        myProductList[index].storeProduct.description,
                      ),
                      trailing: Text(
                        myProductList[index].storeProduct.priceString,
                      )),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://instamealplans.com/terms-conditions/"));
                },
                child: Text(
                  "By continuing, I agree to Terms and Conditions",
                  style: Theme.of(context).textTheme.bodySmall.copyWith(
                      color: CustomTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
