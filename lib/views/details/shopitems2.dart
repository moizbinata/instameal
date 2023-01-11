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

class ShopItems2 extends StatefulWidget {
  ShopItems2({Key key, this.itemList, this.itemLength}) : super(key: key);
  final itemList;
  final itemLength;
  @override
  State<ShopItems2> createState() => _ShopItems2State();
}

class _ShopItems2State extends State<ShopItems2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedItem = "";
  WebViewController _webViewController;
  final _cookieManager = CookieManager();
  var cookie = "";
  String martUrl = "";
  GetStorage box = GetStorage();
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
  }

  @override
  Widget build(BuildContext context) {
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
              length: widget.itemList.length,
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.heightMultiplier * 5,
                    width: SizeConfig.screenWidth,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: CustomTheme.bgColor,
                      tabs: List.generate(
                        widget.itemList.length,
                        (index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.heightMultiplier),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.itemList[index].recipeName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
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
                        widget.itemList.length,
                        (index) {
                          return DefaultTabController(
                            length: widget.itemList[index].items.length,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Container(
                                  height: SizeConfig.heightMultiplier * 5,
                                  width: SizeConfig.screenWidth,
                                  child: TabBar(
                                    isScrollable: true,
                                    indicatorColor: CustomTheme.bgColor,
                                    tabs: List.generate(
                                        widget.itemList[index].items.length,
                                        (indexj) {
                                      return Container(
                                        // margin: EdgeInsets.symmetric(
                                        //     horizontal:
                                        //         SizeConfig.heightMultiplier),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.heightMultiplier * 2,
                                            vertical:
                                                SizeConfig.heightMultiplier),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.itemList[index]
                                                  .items[indexj],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                space0(),
                                Container(
                                  height: SizeConfig.screenHeight * 6,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      widget.itemList[index].items.length,
                                      (indexh) {
                                        bool errorBool = false;

                                        return (martUrl == "")
                                            ? Center(
                                                child: Text(
                                                  "Select shop first",
                                                ),
                                              )
                                            : (errorBool)
                                                ? Center(
                                                    child: Text(
                                                        "This link not working"),
                                                  )
                                                : SingleChildScrollView(
                                                    child: SizedBox(
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.7,
                                                      child: WebView(
                                                        onWebViewCreated:
                                                            (WebViewController
                                                                webViewController) async {
                                                          _webViewController =
                                                              webViewController;
                                                          cookie =
                                                              await _webViewController
                                                                  .runJavascriptReturningResult(
                                                            'document.cookie',
                                                          );
                                                          print(cookie);
                                                        },
                                                        zoomEnabled: true,
                                                        javascriptMode:
                                                            JavascriptMode
                                                                .unrestricted,
                                                        onWebResourceError:
                                                            (error) {
                                                          setState(() {
                                                            errorBool = true;
                                                          });
                                                        },
                                                        initialUrl: martUrl +
                                                            widget
                                                                .itemList[index]
                                                                .items[indexh]
                                                                .toString()
                                                                .replaceAll(
                                                                    " ", "+")
                                                                .trim(),
                                                      ),
                                                    ),
                                                  );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
