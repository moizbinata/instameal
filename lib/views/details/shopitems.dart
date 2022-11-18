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
    var abc = box.read('mart') ?? 'https://www.amazon.com/s?k=';
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
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                    itemCount: widget.itemList.length,
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedItem = widget.itemList[index].toString();
                          });
                        },
                        child: customButton2(
                          context,
                          CustomTheme.bgColor,
                          CustomTheme.bgColor,
                          widget.itemList[index].toString() ?? "",
                        ),
                      );
                    }),
              ),
              space0(),
              SizedBox(
                height: SizeConfig.screenHeight,
                child: (martUrl == "")
                    ? Center(child: Text("Select shop first"))
                    : WebView(
                        zoomEnabled: true,
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: martUrl + selectedItem,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
