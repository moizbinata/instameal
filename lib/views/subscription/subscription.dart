// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:instameal/components/components.dart';
// import 'package:instameal/controllers/buttonController.dart';
// import 'package:instameal/utils/sizeconfig.dart';
// import 'package:instameal/utils/theme.dart';
// import 'package:instameal/views/login.dart';
// import 'package:instameal/views/subscription/trial_screen.dart';

// class Subscribe extends StatelessWidget {
//   const Subscribe({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final buttonController = Get.put(ButtonController());

//     return Scaffold(
//       backgroundColor: CustomTheme.bgColor2,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const FaIcon(
//               FontAwesomeIcons.chevronLeft,
//               color: CustomTheme.bgColor,
//             )),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(SizeConfig.heightMultiplier * 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text("Choose your subscription plans",
//                 style: Theme.of(context).textTheme.headline4),
//             space1(),
//             Column(
//               children: [
//                 Obx((() => ListTile(
//                       onTap: (() => buttonController.selectedPlan.value = 0),
//                       tileColor: (buttonController.selectedPlan == 0)
//                           ? CustomTheme.bgColor
//                           : CustomTheme.grey,
//                       shape: customradius(),
//                       leading: FaIcon(
//                         FontAwesomeIcons.users,
//                       ),
//                       title: Text("Family Plan",
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 color: (buttonController.selectedPlan == 0)
//                                     ? Colors.white
//                                     : Colors.black,
//                               )),
//                       subtitle: Text("Best for 4-6",
//                           style: Theme.of(context).textTheme.bodyText1.copyWith(
//                                 color: (buttonController.selectedPlan == 0)
//                                     ? Colors.white
//                                     : Colors.black,
//                               )),
//                       trailing: Icon(
//                         Icons.check_circle_outlined,
//                         color: (buttonController.selectedPlan == 0)
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                     ))),
//                 space1(),
//                 Obx((() => ListTile(
//                       onTap: (() => buttonController.selectedPlan.value = 1),
//                       shape: customradius(),
//                       tileColor: (buttonController.selectedPlan == 1)
//                           ? CustomTheme.bgColor
//                           : Colors.white,
//                       leading: Icon(
//                         Icons.account_circle,
//                       ),
//                       title: Text("Plan For 2",
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 color: (buttonController.selectedPlan == 1)
//                                     ? Colors.white
//                                     : Colors.black,
//                               )),
//                       subtitle: Text("Best for 1-2",
//                           style: Theme.of(context).textTheme.bodyText1.copyWith(
//                                 color: (buttonController.selectedPlan == 1)
//                                     ? Colors.white
//                                     : Colors.black,
//                               )),
//                       trailing: Icon(
//                         Icons.check_circle_outlined,
//                         color: (buttonController.selectedPlan == 1)
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                     ))),
//               ],
//             ),
//             space1(),
//             InkWell(
//                 onTap: () {
//                   Get.off(() => TrialScreen()); // to(() => Subscribe());
//                 },
//                 child: customButton(context, Colors.white, CustomTheme.bgColor,
//                     "Continue to Meal Plan")),
//           ],
//         ),
//       ),
//     );
//   }
// }
