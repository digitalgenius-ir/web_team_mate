// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stacked/stacked.dart';
// import 'package:attendance/pages/profile_page/attendance_list/attendance_list_page.dart';
// import 'package:attendance/pages/profile_page/profile_notifier.dart';
// import 'package:attendance/services/locator.dart';
// import 'package:attendance/services/preferences_service.dart';
// import 'package:attendance/theme/colors.dart';
// import 'package:attendance/theme/dimens.dart';
// import 'package:attendance/utilities/onBackClick.dart';
// import 'package:attendance/widgets/action_widgets.dart';
// import 'package:attendance/widgets/profile_bottom_sheet.dart';
// import 'package:attendance/widgets/image_widget.dart';
// import 'package:attendance/widgets/profile_item_widget.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => ProfilePageState();
// }
//
// class ProfilePageState extends State<ProfilePage> {
//   final AppPreferences pref = locator<AppPreferences>();
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return ViewModelBuilder<ProfileVM>.reactive(
//         viewModelBuilder: () => ProfileVM(),
//         disposeViewModel: true,
//         builder: (context, model, child) {
//           return Directionality(
//               textDirection: TextDirection.rtl,
//               child: Scaffold(
//                 bottomNavigationBar: Container(
//                   width: fullWidth(context),
//                   height: kBottomNavigationBarHeight * 2,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black87,
//                           offset: Offset(0, 0.8),
//                           blurRadius: 1.5,
//                           spreadRadius: 0.01
//                         )
//                       ],
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(xxlargeSize(context) * 1.5),
//                           topRight:
//                               Radius.circular(xxlargeSize(context) * 1.5))),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                         child: Container(
//                           width: fullWidth(context) / 1.2,
//                           height: kBottomNavigationBarHeight,
//                           decoration: BoxDecoration(
//                               color: Colors.transparent,
//                               borderRadius:
//                                   BorderRadius.circular(xSmallSize(context)),
//                               border: Border.all(
//                                   color: AppColors.primaryColor, width: 2)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 'assets/log-out.png',
//                                 height: iconSizeXLarge(context) * 1.3,
//                               ),
//                               Container(
//                                 margin:
//                                     EdgeInsets.only(right: xSmallSize(context)),
//                                 child: Text(
//                                   'خروج از حساب کاربری',
//                                   style: theme.textTheme.subtitle1,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 appBar: AppBar(
//                   centerTitle: true,
//                   backgroundColor: AppColors.background,
//                   leading: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       splashRadius: largeSize(context),
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: iconSizeLarge(context),
//                         color: Colors.black,
//                       )),
//                   elevation: 0,
//                   title: Text("پروفـایل",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline2!
//                           .copyWith(color: Colors.black)),
//                 ),
//                 backgroundColor: AppColors.background,
//                 body: NotificationListener<OverscrollIndicatorNotification>(
//                   onNotification: (OverscrollIndicatorNotification overScroll) {
//                     overScroll.disallowGlow();
//                     return true;
//                   },
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.only(
//                         top: xlargeSize(context),
//                         right: standardSize(context),
//                         left: standardSize(context)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               profileBottomSheet(
//                                   context,
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       top: largeSize(context),
//                                       left: largeSize(context),
//                                       bottom: largeSize(context),
//                                       right: largeSize(context),
//                                     ),
//                                     child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               Material(
//                                                 color: Colors.transparent,
//                                                 child: InkWell(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           mediumSize(context)),
//                                                   onTap: () {
//                                                     model.pickImage(
//                                                         ImageSource.gallery);
//                                                     Navigator.pop(context);
//                                                   },
//                                                   splashColor: splashColor(),
//                                                   child: Container(
//                                                     padding: EdgeInsets.all(
//                                                         xSmallSize(context)),
//                                                     child: Column(
//                                                       children: [
//                                                         Icon(
//                                                             CupertinoIcons
//                                                                 .photo_fill,
//                                                             color: theme
//                                                                 .primaryColor,
//                                                             size: xlargeSize(
//                                                                 context)),
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   top: smallSize(
//                                                                       context)),
//                                                           child: Text(
//                                                             "انتخاب از گالری",
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .headline6!
//                                                                 .copyWith(
//                                                                     color: theme
//                                                                         .primaryColor,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Material(
//                                                 color: Colors.transparent,
//                                                 child: InkWell(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           mediumSize(context)),
//                                                   onTap: () {
//                                                     model.pickImage(
//                                                         ImageSource.camera);
//                                                     Navigator.pop(context);
//                                                   },
//                                                   splashColor: splashColor(),
//                                                   child: Container(
//                                                     padding: EdgeInsets.all(
//                                                         xSmallSize(context)),
//                                                     child: Column(
//                                                       children: [
//                                                         Icon(
//                                                           CupertinoIcons
//                                                               .camera_fill,
//                                                           color: theme
//                                                               .primaryColor,
//                                                           size: xlargeSize(
//                                                               context),
//                                                         ),
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   top: smallSize(
//                                                                       context)),
//                                                           child: Text(
//                                                             "انتخاب از دوربین",
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .headline6!
//                                                                 .copyWith(
//                                                                     color: theme
//                                                                         .primaryColor,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ]),
//                                   ));
//                             },
//                             child: model.val != null
//                                 ? Container(
//                                     width: fullWidth(context) / 3.5,
//                                     height: fullWidth(context) / 3.5,
//                                     margin: EdgeInsets.only(
//                                         top: xxSmallSize(context)),
//                                     alignment: Alignment.center,
//                                     child: Stack(
//                                       children: [
//                                         Positioned.fill(
//                                             child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         xxlargeSize(context) *
//                                                             1.3),
//                                                 child: imageWidget(
//                                                     model.val?.path ?? '',
//                                                     fit: BoxFit.cover))),
//                                         Align(
//                                           alignment: const Alignment(0.98, 1),
//                                           child: Container(
//                                             width: xxlargeSize(context) / 1.4,
//                                             height: xxlargeSize(context) / 1.4,
//                                             child: Icon(
//                                               Icons.camera_alt_rounded,
//                                               color: Colors.white,
//                                               size: standardSize(context),
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black87,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         smallSize(context))),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 : Container(
//                                     width: fullWidth(context) / 3,
//                                     height: fullWidth(context) / 3,
//                                     margin: EdgeInsets.only(
//                                         top: xxSmallSize(context)),
//                                     alignment: Alignment.center,
//                                     child: Stack(
//                                       children: [
//                                         Positioned.fill(
//                                             child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.grey.shade100,
//                                                     image: const DecorationImage(
//                                                         image: AssetImage(
//                                                           "assets/pic_profile.png",
//                                                         ),
//                                                         fit: BoxFit.cover),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             xxlargeSize(
//                                                                     context) *
//                                                                 1.3)))),
//                                         Align(
//                                           alignment: const Alignment(0.98, 1),
//                                           child: Container(
//                                             width: xxlargeSize(context) / 1.4,
//                                             height: xxlargeSize(context) / 1.4,
//                                             child: Icon(
//                                               Icons.camera_alt_rounded,
//                                               color: Colors.white,
//                                               size: standardSize(context),
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black87,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         smallSize(context))),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         Center(
//                           child: Container(
//                             margin: EdgeInsets.only(
//                               top: mediumSize(context),
//                             ),
//                             child: Text(
//                               '${pref.user.Firstname}' ' ${pref.user.Lastname}',
//                               style: theme.textTheme.headline3?.copyWith(
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                         ),
//                         Center(
//                           child: Text(
//                             '${pref.user.PhoneNumber}',
//                             style: theme.textTheme.bodyText1?.copyWith(
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Card(
//                           margin: EdgeInsets.only(top: xxlargeSize(context)),
//                           elevation: 1,
//                           color: Colors.grey.shade100,
//                           shadowColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(smallSize(context))),
//                           child: Container(
//                             width: fullWidth(context),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: mediumSize(context),
//                                 vertical: standardSize(context)),
//                             child: Column(children: [
//                               profileItemBox(
//                                   context,
//                                   Icons.location_on_outlined,
//                                   'تردد های من', () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             AttenadancePage()));
//                               }, false),
//                               profileItemBox(
//                                   context,
//                                   Icons.headset_mic_outlined,
//                                   'پشتیبانی',
//                                   () {},
//                                   false),
//                               profileItemBox(context, Icons.list_outlined,
//                                   'لیست ساعت های ثبت شده', () {}, false),
//                               profileItemBox(
//                                   context,
//                                   Icons.contact_support_outlined,
//                                   'دربارۀ نرم افزار',
//                                   () {},
//                                   true)
//                             ]),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ));
//         });
//   }
// }
