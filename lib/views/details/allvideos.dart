// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:instameal/controllers/videocontroller.dart';
// import 'package:instameal/views/details/recipe.dart';

// import '../../components/customappbar.dart';
// import '../../components/customdrawer.dart';
// import '../../components/notifdialog.dart';
// import '../../utils/constants.dart';
// import '../../utils/sizeconfig.dart';
// import '../../utils/theme.dart';
// class AllVideos extends StatelessWidget {
//    AllVideos({Key key}) : super(key: key);
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
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
//     );
//   }
//   Widget buildFavListWeekly() {
//     return SizedBox(
//       height: SizeConfig.screenHeight,
//       child: GetX<VideoController>(
//           init: VideoController(),
//           builder: (_) {
//             return (_.listofVideos.length == 0)
//                 ? Center(
//                     child: Image.asset(
//                     "assets/images/norecord.png",
//                     width: SizeConfig.screenWidth * 0.7,
//                   ))
//                 : ListView.builder(
//                     itemCount: _.listofVideos.length + 1,
//                     physics: AlwaysScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return (index == _.listofVideos.length)
//                           ? SizedBox(
//                               height: SizeConfig.heightMultiplier * 50,
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 Constants.navigatepush(
//                                     context,
//                                     RecipeDetail(
//                                       modelType: "collection",
//                                       recipeModel: _.listofVideos[index],
//                                     ));
//                               },
//                               child: Container(
//                                 clipBehavior: Clip.hardEdge,
//                                 margin:
//                                     EdgeInsets.all(SizeConfig.heightMultiplier),
//                                 decoration: BoxDecoration(
//                                   color: CustomTheme.bgColor,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: CustomTheme.grey.withOpacity(0.5),
//                                       blurRadius: 6,
//                                       spreadRadius: 6,
//                                       offset: Offset(0, 0),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 3,
//                                       child: CachedNetworkImage(
//                                         height:
//                                             SizeConfig.heightMultiplier * 20,
//                                         width: SizeConfig.heightMultiplier * 20,
//                                         imageUrl: Constants.baseImageUrl +
//                                             _.listofVideos[index].imageUrl,
//                                         fit: BoxFit.cover,
//                                         placeholder: (context, url) => Center(
//                                             child: Center(
//                                                 child:
//                                                     CircularProgressIndicator())),
//                                         errorWidget: (context, url, error) =>
//                                             Image.asset(
//                                                 "assets/images/breakfast.png"),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: SizeConfig.heightMultiplier,
//                                     ),
//                                     Expanded(
//                                       flex: 5,
//                                       child: SizedBox(
//                                         height:
//                                             SizeConfig.heightMultiplier * 20,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               _.listofVideos[index].title,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodySmall,
//                                             ),
//                                             Text(
//                                               _.listofVideos[index]
//                                                   .,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   .copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                   ),
//                                             ),
//                                             // InkWell(
//                                             //     child: customButton2(
//                                             //         context,
//                                             //         Colors.white,
//                                             //         Colors.white,
//                                             //         "Add to List")),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                     },
//                   );
//           }),
//     );
//   }
// }