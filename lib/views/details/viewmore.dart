// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:instameal/controllers/universalController.dart';
// import 'package:instameal/views/details/recipe.dart';

// import '../../components/components.dart';
// import '../../components/customappbar.dart';
// import '../../components/customdrawer.dart';
// import '../../components/notifdialog.dart';
// import '../../utils/constants.dart';
// import '../../utils/sizeconfig.dart';
// import '../../utils/theme.dart';

// class ViewMore extends StatelessWidget {
//   ViewMore({Key key, this.type}) : super(key: key);
//   final type;
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   GetStorage box = GetStorage();
//   @override
//   Widget build(BuildContext context) {
//     final universalContr = Get.put(UniversalController());

//     return Scaffold(
//       key: _scaffoldKey,
//       floatingActionButton: floatButton(context),
//       drawer: drawer(context),
//       appBar: customAppBar(action: () {
//         if (_scaffoldKey.currentState.isDrawerOpen) {
//           _scaffoldKey.currentState.openEndDrawer();
//         } else {
//           _scaffoldKey.currentState.openDrawer();
//         }
//       }, action2: () {
//         showDialog(context: context, builder: (ctx) => notifDialog(ctx));
//       }),
//       backgroundColor: CustomTheme.bgColor2,
//       body: RefreshIndicator(
//         onRefresh: universalContr.fetchUniversal,
//         child: SizedBox(
//           height: SizeConfig.screenHeight,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "   View more",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline6
//                           .copyWith(color: CustomTheme.bgColor),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           final UniversalController universalController =
//                               Get.put(UniversalController());
//                           universalController.fetchUniversal();
//                         },
//                         icon: FaIcon(FontAwesomeIcons.rotate))
//                   ],
//                 ),
//                 Obx(
//                   () => Text((type == 0)
//                       ? "   Total: ${universalContr.listofFav.length.toString()}"
//                       : (type == 1)
//                           ? "   Total: ${universalContr.listofFestival.length.toString()}"
//                           : (type == 2)
//                               ? "   Total: ${universalContr.listofCollection.length.toString()}"
//                               : "   Total: ${universalContr.listofDesserts.length.toString()}"),
//                 ),
//                 buildViewMore(type),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget buildViewMore(type) {
//   return SizedBox(
//     height: SizeConfig.screenHeight,
//     child: GetX<UniversalController>(
//         init: UniversalController(),
//         builder: (_) {
//           int listLength = (type == 0)
//               ? _.listofFav.length
//               : (type == 1)
//                   ? _.listofFestival.length
//                   : (type == 2)
//                       ? _.listofCollection.length
//                       : _.listofDesserts.length;
//           return (listLength == 0)
//               ? Center(
//                   child: Image.asset(
//                     "assets/images/norecord.png",
//                     width: SizeConfig.screenWidth * 0.7,
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: listLength + 1,
//                   physics: AlwaysScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     var item;
//                     if (index != listLength) {
//                       item = (type == 0)
//                           ? _.listofFav[index]
//                           : (type == 1)
//                               ? _.listofFestival[index]
//                               : (type == 2)
//                                   ? _.listofCollection[index]
//                                   : _.listofDesserts[index];
//                     }
//                     return (index == listLength)
//                         ? SizedBox(
//                             height: SizeConfig.heightMultiplier * 30,
//                           )
//                         : InkWell(
//                             onTap: () {
//                               Constants.navigatepush(
//                                   context,
//                                   RecipeDetail(
//                                     modelType: "collection",
//                                     recipeModel: item,
//                                   ));
//                             },
//                             child: Container(
//                               clipBehavior: Clip.hardEdge,
//                               margin:
//                                   EdgeInsets.all(SizeConfig.heightMultiplier),
//                               decoration: BoxDecoration(
//                                 color: CustomTheme.bgColor,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: CustomTheme.grey.withOpacity(0.5),
//                                     blurRadius: 6,
//                                     spreadRadius: 6,
//                                     offset: Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                       flex: 3,
//                                       child: Stack(
//                                         children: [
//                                           CachedNetworkImage(
//                                             height:
//                                                 SizeConfig.heightMultiplier *
//                                                     20,
//                                             width: SizeConfig.heightMultiplier *
//                                                 20,
//                                             imageUrl: Constants.baseImageUrl +
//                                                 item.imagesUrl,
//                                             fit: BoxFit.cover,
//                                             placeholder: (context, url) => Center(
//                                                 child: Center(
//                                                     child:
//                                                         CircularProgressIndicator())),
//                                             errorWidget: (context, url,
//                                                     error) =>
//                                                 Image.asset(
//                                                     "assets/images/breakfast.png"),
//                                           ),
//                                           Positioned(
//                                               child: CircleAvatar(
//                                             backgroundColor:
//                                                 Colors.black.withOpacity(0.5),
//                                             child: Text((index + 1).toString()),
//                                           ))
//                                         ],
//                                       )),
//                                   SizedBox(
//                                     width: SizeConfig.heightMultiplier,
//                                   ),
//                                   Expanded(
//                                     flex: 5,
//                                     child: SizedBox(
//                                       height: SizeConfig.heightMultiplier * 20,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             item.planName,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodySmall,
//                                           ),
//                                           Text(
//                                             item.recipeName,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText1
//                                                 .copyWith(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                   },
//                 );
//         }),
//   );
// }
