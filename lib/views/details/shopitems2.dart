import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../utils/theme.dart';

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
      appBar: customAppBar(
        action: () {
          if (_scaffoldKey.currentState.isDrawerOpen) {
            _scaffoldKey.currentState.openEndDrawer();
          } else {
            _scaffoldKey.currentState.openDrawer();
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTabController(
                length: widget.itemLength - 1,
                child: Column(
                  children: [
                    Container(
                      height: SizeConfig.heightMultiplier * 5,
                      width: SizeConfig.screenWidth,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: CustomTheme.bgColor,
                        tabs: List.generate(
                          widget.itemLength - 1,
                          (index) {
                            return Row(
                              children: List.generate(
                                  widget.itemList.first.items.length - 1,
                                  (indexj) {
                                // print(widget.itemList[index].items[indexj]);
                                // print(
                                //   widget.itemList[index].items.length
                                //       .toString(),
                                // );
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.heightMultiplier),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.heightMultiplier),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.itemList.first.recipeName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        widget.itemList.first.items[indexj]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                    space0(),
                    Container(
                      height: SizeConfig.screenHeight,
                      child: TabBarView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: List.generate(
                          widget.itemLength - 1,
                          (index) {
                            return ListView(
                              children: List.generate(
                                  widget.itemList.first.items.length - 1,
                                  (indexj) {
                                return (martUrl == "")
                                    ? Center(child: Text("Select shop first"))
                                    : SizedBox(
                                        height: SizeConfig.screenHeight,
                                        width: SizeConfig.screenWidth,
                                        child: WebView(
                                          zoomEnabled: true,
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          initialUrl: martUrl +
                                              widget
                                                  .itemList.first.items[indexj]
                                                  .toString(),
                                        ),
                                      );
                                // Container(
                                //   margin: EdgeInsets.symmetric(
                                //       horizontal: SizeConfig.heightMultiplier),
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: SizeConfig.heightMultiplier),
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         widget.itemList.first.recipeName,
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodySmall
                                //             .copyWith(color: Colors.black),
                                //       ),
                                //       Text(
                                //         widget.itemList.first.items[indexj]
                                //             .toUpperCase(),
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              }),
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
      ),
    );
  }
}
