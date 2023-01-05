import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/components/customappbar.dart';
import 'package:instameal/components/customdrawer.dart';
import 'package:instameal/components/notifdialog.dart';
import 'package:instameal/utils/theme.dart';

class ShopItems extends StatefulWidget {
  ShopItems({Key key, this.itemList}) : super(key: key);
  final itemList;
  @override
  State<ShopItems> createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedItem = "";
  String martUrl = "";
  GetStorage box = GetStorage();
  bool isError = false;
  WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    var abc = box.read('mart').toString() ?? 'walmart';
    setState(() {
      martUrl = box.read(abc);
    });
    print(martUrl);
  }

  @override
  Widget build(BuildContext context) {
    isError = false;
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
      }),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
        // height: SizeConfig.screenHeight,
        child: Column(
          children: [
            DefaultTabController(
              length: widget.itemList.items.length,
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.screenWidth,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: CustomTheme.bgColor,
                      tabs: List.generate(
                        widget.itemList.items.length,
                        (index) {
                          return Column(
                            children: [
                              Text(widget.itemList.recipeName,
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(
                                widget.itemList.items[index]
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  space0(),
                  Container(
                    height: SizeConfig.screenHeight * 0.7,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        widget.itemList.items.length,
                        (index) {
                          print("tabview");
                          print(martUrl +
                              widget.itemList.items[index].toString());
                          return (martUrl == "")
                              ? Center(
                                  child: Text(
                                    "Select shop first",
                                  ),
                                )
                              : isError
                                  ? Text(
                                      "No Loaded",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : SingleChildScrollView(
                                      child: SizedBox(
                                        height: SizeConfig.screenHeight * 0.7,
                                        child: WebView(
                                          onWebViewCreated: (WebViewController
                                              webViewController) {
                                            _webViewController =
                                                webViewController;
                                          },
                                          zoomEnabled: true,
                                          onWebResourceError: (error) =>
                                              setState(() {
                                            isError = true;
                                          }),
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          initialUrl: martUrl +
                                              widget.itemList.items[index]
                                                  .toString(),
                                        ),
                                      ),
                                    );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
