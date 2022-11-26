import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../utils/theme.dart';

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
                            return Text(
                              widget.itemList[index].toString().toUpperCase(),
                              style: TextStyle(color: Colors.black),
                            );
                          },
                        ),
                      ),
                    ),
                    space0(),
                    Container(
                      height: SizeConfig.screenHeight,
                      child: TabBarView(
                        children: List.generate(
                          widget.itemList.length,
                          (index) {
                            print("tabview");
                            print(martUrl + selectedItem);
                            return (martUrl == "")
                                ? Center(child: Text("Select shop first"))
                                : WebView(
                                    zoomEnabled: true,
                                    javascriptMode: JavascriptMode.unrestricted,
                                    initialUrl: martUrl +
                                        widget.itemList[index].toString(),
                                  );
                          },
                        ),
                        // ListView.builder(
                        //   itemCount: widget.itemList.length,
                        //   physics: AlwaysScrollableScrollPhysics(),
                        //   itemBuilder: (context, index) {
                        //     return (martUrl == "")
                        //         ? Center(child: Text("Select shop first"))
                        //         : WebView(
                        //             zoomEnabled: true,
                        //             javascriptMode:
                        //                 JavascriptMode.unrestricted,
                        //             initialUrl: martUrl + selectedItem,
                        //           );
                        //   },
                        // ),
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
