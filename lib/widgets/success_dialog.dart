// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:attendance/pages/home_page/home_notifier.dart';
// import 'package:attendance/theme/colors.dart';
// import 'package:attendance/theme/dimens.dart';
//
// void showSuccessDialog(
//     BuildContext context, String title, String subTitle, String clock, VoidCallback onPressed) {
//   var theme = Theme.of(context);
//   showModalBottomSheet(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(xlargeSize(context)),
//           topRight: Radius.circular(xlargeSize(context))),
//     ),
//     context: context,
//     backgroundColor: theme.backgroundColor,
//     builder: (context) {
//       return Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: standardSize(context), vertical: standardSize(context)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: xxSmallSize(context)),
//               width: xlargeSize(context) * 2,
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(smallSize(context))),
//               height: 4,
//             ),
//             Container(
//                 margin: EdgeInsets.only(bottom: xxSmallSize(context)),
//                 child: Text(
//                   title,
//                   style: theme.textTheme.headline6!
//                       .copyWith(fontWeight: FontWeight.bold),
//                 )),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: xxSmallSize(context)),
//               child: Image.asset(
//                 'assets/clock.png',
//                 height: fullWidth(context) / 4,
//                 width: fullWidth(context) / 4,
//               ),
//             ),
//             Center(
//               child: Container(
//                 margin: EdgeInsets.only(top: xxSmallSize(context)),
//                 child: Text(
//                   subTitle,
//                   textAlign: TextAlign.center,
//                   style: theme.textTheme.subtitle1!
//                       .copyWith(color: AppColors.primaryColor),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(
//                   top: xxSmallSize(context), bottom: smallSize(context)),
//               child: Text(
//                 clock,
//                 style: theme.textTheme.subtitle1!
//                     .copyWith(color: AppColors.primaryColor),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: mediumSize(context),
//                   vertical: smallSize(context)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: TextButton(
//                       style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                               vertical: smallSize(context)),
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(smallSize(context)),
//                               side: BorderSide(color: Colors.grey))),
//                       onPressed: (){Navigator.of(context).pop();},
//                       child: Text(
//                         "خیر",
//                         style: theme.textTheme.headline6!
//                             .copyWith(color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: mediumSize(context),),
//                   Expanded(
//                     flex: 1,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                               vertical: smallSize(context)),
//                           primary: theme.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(smallSize(context)),
//                           )),
//                       onPressed: onPressed,
//                       child: Text(
//                         'بله',
//                         style: theme.textTheme.headline6!
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
