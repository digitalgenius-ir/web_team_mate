// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, avoid_print

import 'dart:async';
import 'package:attendance/pages/home_page/widgets/drawer_item_widget.dart';
import 'package:attendance/pages/profile_page/attendance_list/attendance_list_page.dart';
import 'package:attendance/transition/slide_transtion.dart';
import 'package:attendance/web_models/profile_web_model.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/widgets/action_widgets.dart';
import 'package:attendance/widgets/image_widget.dart';
import 'package:attendance/widgets/profile_item_widget.dart';
import 'package:attendance/widgets/progress_button.dart';
import 'package:attendance/widgets/show_automatic_sheet.dart';
import 'package:attendance/widgets/success_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as prefix;
import 'package:page_transition/page_transition.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:attendance/pages/home_page/home_notifier.dart';
import 'package:attendance/pages/profile_page/profile_page.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/onBackClick.dart';
import 'package:attendance/widgets/no_internet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  prefix.DateFormat formatter = prefix.DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  String formattedDate = '';

  // StreamController<bool> streamController =
  //     StreamController<bool>.broadcast();

  StreamController<ProfileRPM> streamControllerRPM =
      StreamController<ProfileRPM>.broadcast();

  Stream<ProfileRPM> get currentItemStream => streamControllerRPM.stream;

  // Stream<ProfileRPM> currentItemStream = (() async {
  //   return rpm;
  //
  // })();
  // Stream<bool> get currentItemBoolStream => streamController.stream;

  DateTime attendanceDate = DateTime.now();
  prefix.DateFormat dateFormatter =
      prefix.DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  String formatted = '';

  // locators
  final AppPreferences pref = locator<AppPreferences>();
  late User user;
  late bool isWorking = false;

  //////////////////funcs//////////////////////

  String _formatClockTime(DateTime dateTime) {
    return prefix.DateFormat('HH:mm').format(dateTime);
  }

  ///////////////////key/////////////////////////
  // GlobalKey<SliderMenuContainerState> key =
  // new GlobalKey<SliderMenuContainerState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  //////////////////init/////////////////////
  ProfileRPM? rpm;

  @override
  void initState() {
    formattedDate = formatter.format(now);
    formatted = dateFormatter.format(attendanceDate);
    user = pref.user;
    // isWorking = user.IsWorking;
    // streamControllerRPM.stream.listen((event) {
    //         rpm = event;
    // })    ;

    super.initState();
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Stream<bool> stream = currentItemBoolStream;
    // Stream<ProfileRPM> streamRPM= currentItemStream;
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeVM>.reactive(
        viewModelBuilder: () => HomeVM(),
        disposeViewModel: true,
        builder: (context, model, child) {
          model.getCurrentDate(_formatClockTime(DateTime.now()));

          DateTime tempDate =
              prefix.DateFormat("yyyy-MM-dd hh:mm:ss").parse(now.toString());
          Jalali j = Jalali.fromDateTime(tempDate);
          String dateFormat() {
            final f = j.formatter;
            return '${f.wN} ، ${f.d} ${f.mN}';
          }

          // return StreamBuilder<ProfileRPM>(
          //   stream: currentItemStream,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          return WillPopScope(
            onWillPop: () => onBackClicked(context,
                description: 'آیا میخواهید از برنامه خارج شوید ؟',
                title: 'خروج از برنامه', okOnPressed: () {
              SystemNavigator.pop();
            }),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  key: scaffoldKey,
                  drawerEnableOpenDragGesture: true,
                  drawer: SlideFadeTranstion(
                    direction: Direction.horizental,
                    animationDuration: Duration(milliseconds: 600),
                    delayStart: Duration(milliseconds: 100),
                    curve: Curves.fastLinearToSlowEaseIn,
                    offset: 5,
                    child: Drawer(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff0f4474),
                              Color(0xff2fc5f4),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Column(
                          // padding: EdgeInsets.zero,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: xxlargeSize(context) * 1.4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SlideFadeTranstion(
                                        direction: Direction.horizental,
                                        animationDuration:
                                            Duration(milliseconds: 600),
                                        delayStart: Duration(milliseconds: 200),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        offset: 5,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                              largeSize(context)),
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: splashColor(),
                                            borderRadius: BorderRadius.circular(
                                                largeSize(context)),
                                            onTap: () {
                                              scaffoldKey.currentState!
                                                  .openEndDrawer();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  xSmallSize(context)),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SlideFadeTranstion(
                                    direction: Direction.horizental,
                                    animationDuration:
                                        Duration(milliseconds: 700),
                                    delayStart: Duration(milliseconds: 200),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    offset: 5,
                                    child: Container(
                                      // color: Colors.red,
                                      margin: EdgeInsets.only(
                                          top: largeSize(context)),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            // => Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             ProfilePage())),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: smallSize(context)),
                                              width: xxlargeSize(context) * 2,
                                              height: xxlargeSize(context) * 2,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          xxlargeSize(context)),
                                                  child: imageWidget(
                                                    user.AvatarPath,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: xxSmallSize(context),
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 2),
                                              child: Text(
                                                user.Firstname +
                                                    ' ${user.Lastname}',
                                                style: theme.textTheme.headline6
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            user.PhoneNumber,
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                margin: EdgeInsets.only(top: 24),
                                child: Column(
                                  children: [
                                    profileItemBox(
                                        context,
                                        Icons.location_on_outlined,
                                        'تردد های من', () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AttenadancePage()),
                                      );
                                    }, false, 800),
                                    profileItemBox(
                                        context,
                                        Icons.headset_mic_outlined,
                                        'پشتیبانی',
                                        () {},
                                        false,
                                        900),
                                    profileItemBox(
                                        context,
                                        Icons.list_outlined,
                                        'لیست ساعت های ثبت شده',
                                        () {},
                                        false,
                                        1000),
                                    profileItemBox(
                                        context,
                                        Icons.contact_support_outlined,
                                        'دربارۀ نرم افزار',
                                        () {},
                                        false,
                                        1100),
                                    // SizedBox(
                                    //   height: 90,
                                    // ),
                                    SlideFadeTranstion(
                                      direction: Direction.horizental,
                                      animationDuration:
                                          Duration(milliseconds: 1200),
                                      delayStart: Duration(milliseconds: 200),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      offset: 5,
                                      child: homeProfilePart(context,
                                          title: "خروج",
                                          icon: "assets/log-out.png",
                                          onTap: () {
                                        onBackClicked(
                                          context,
                                          description:
                                              "آیا میخواهید از این حساب خارج شوید ؟",
                                          title: "خروج از حساب",
                                          okOnPressed: () {
                                            model.logOut(context);
                                            pref.clearPref();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: AppColors.background,
                  body: model.hasError
                      ? NoInternetWidget(() {
                          model.initialise();
                        })
                      : model.busy(model.isBusyAttendance) ||
                              model.profileRPM == null
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              padding: EdgeInsets.only(
                                  top: standardSize(context),
                                  bottom: xxlargeSize(context),
                                  right: standardSize(context),
                                  left: standardSize(context)),
                              child: Column(
                                children: [
                                  Container(
                                    height: xxlargeSize(context) * 1.3,
                                    width: fullWidth(context),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'assets/digital_genius.png',
                                            height: xxlargeSize(context) / 1.8,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: model.busy(model
                                                        .isBusyAttendance) ||
                                                    model.profileRPM == null
                                                ? Container(
                                                    height:
                                                        xxlargeSize(context) *
                                                            1.5,
                                                    width:
                                                        xxlargeSize(context) *
                                                            1.5,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1),
                                                    ),
                                                    child: Center(
                                                        child:
                                                            CupertinoActivityIndicator(
                                                                animating:
                                                                    true)),
                                                  )
                                                : GestureDetector(
                                                    onTap: model.isBusy
                                                        ? null
                                                        : () {
                                                            scaffoldKey
                                                                .currentState!
                                                                .openDrawer();
                                                          },
                                                    child: Container(
                                                      height:
                                                          xxlargeSize(context) *
                                                              1.5,
                                                      width:
                                                          xxlargeSize(context) *
                                                              1.5,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape: BoxShape.circle,
                                                        image: model
                                                                    .profileRPM
                                                                    ?.data
                                                                    ?.AvatarPath ==
                                                                ''
                                                            ? DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  'assets/pic_profile.png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover)
                                                            : DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  model
                                                                          .profileRPM
                                                                          ?.data
                                                                          ?.AvatarPath ??
                                                                      '',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                            width: 1),
                                                      ),
                                                    ),
                                                  )),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: standardSize(context),
                                         ),
                                        child: Text(dateFormat(),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: theme.textTheme.headline3!
                                                .copyWith(
                                                    // fontSize: largeSize(context),
                                                    color: Colors.grey.shade800,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                  ),
                                  Spacer(),

                                  GestureDetector(
                                      onTap:
                                          // model.isBusy
                                          //     ? null
                                          //     :
                                          () {
                                        showModalBottomSheet(
                                          isDismissible: false,
                                          enableDrag: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    xlargeSize(context)),
                                                topRight: Radius.circular(
                                                    xlargeSize(context))),
                                          ),
                                          context: context,
                                          backgroundColor:
                                              theme.backgroundColor,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          standardSize(context),
                                                      vertical: standardSize(
                                                          context)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: xxSmallSize(
                                                                context)),
                                                        width: xlargeSize(
                                                                context) *
                                                            2,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    smallSize(
                                                                        context))),
                                                        height: 4,
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  xxSmallSize(
                                                                      context)),
                                                          child: Text(
                                                            'ثبت زمان خروج',
                                                            style: theme
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          )),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    xxSmallSize(
                                                                        context)),
                                                        child: Image.asset(
                                                          'assets/clock.png',
                                                          height: fullWidth(
                                                                  context) /
                                                              4,
                                                          width: fullWidth(
                                                                  context) /
                                                              4,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              top: xxSmallSize(
                                                                  context)),
                                                          child: Text(
                                                            model.profileRPM?.data
                                                                        ?.IsWorking ??
                                                                    false
                                                                ? 'برای ثبت زمان خروج مطمئن هستید ؟'
                                                                : "برای ثبت زمان ورود مطمئن هستید ؟",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: theme
                                                                .textTheme
                                                                .subtitle1!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .primaryColor),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: xxSmallSize(
                                                                context),
                                                            bottom: smallSize(
                                                                context)),
                                                        child: Text(
                                                          TimeOfDay.now()
                                                              .format(context),
                                                          style: theme.textTheme
                                                              .subtitle1!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primaryColor),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    mediumSize(
                                                                        context),
                                                                vertical:
                                                                    smallSize(
                                                                        context)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: TextButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            smallSize(
                                                                                context)),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(smallSize(
                                                                                context)),
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.grey))),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  "خیر",
                                                                  style: theme
                                                                      .textTheme
                                                                      .headline6!
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: mediumSize(
                                                                  context),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: progressButton(
                                                                  context,
                                                                  "بله",
                                                                  model.busy(model
                                                                      .isBusySheet),
                                                                  () {
                                                                setState(() {
                                                                  model.attendanceData(
                                                                      context,
                                                                      formattedDate);
                                                                });
                                                              }),
/*
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: smallSize(
                                                                              context)),
                                                                      primary: theme
                                                                          .primaryColor,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(smallSize(context)),
                                                                      )),
                                                              onPressed: () {
                                                                setState(() {
                                                                  model.attendanceData(
                                                                      context,
                                                                      ) ;

                                                                  // model.profileRPM?.data?.IsWorking =true;
                                                                });

                                                                // model
                                                                //     .initialise();
                                                                // });
                                                              },
                                                              child: model
                                                                      .isBusy
                                                                  ? Container(
                                                                      height: xlargeSize(
                                                                          context),
                                                                      width: xlargeSize(
                                                                          context),
                                                                      child: const CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              3,
                                                                          color:
                                                                              AppColors.background))
                                                                  : Text(
                                                                      'بله',
                                                                      style: theme
                                                                          .textTheme
                                                                          .headline6!
                                                                          .copyWith(
                                                                              color: Colors.white),
                                                                    ),
                                                            ),
*/
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(
                                              fullHeight(context) / 10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: model.data?.data
                                                          ?.IsWorking ??
                                                      false
                                                  // isWorking
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Color(0xff740f52),
                                                        Color(0xfff42f9b),
                                                      ],
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                    )
                                                  : const LinearGradient(
                                                      colors: [
                                                        Color(0xff0f4474),
                                                        Color(0xff2fc5f4),
                                                      ],
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                    ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 3),
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.5),
                                                    spreadRadius: 0.5,
                                                    blurRadius: 10)
                                              ]),
                                          // height: fullHeight(context) / 4,
                                          // width: fullWidth(context) / 1.95,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width:
                                                      xxlargeSize(context) * 2,
                                                  child: Image.asset(
                                                    'assets/select_hand.png',
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: mediumSize(context)),
                                                  child: Text(
                                                      model.data?.data
                                                                  ?.IsWorking ??
                                                              false
                                                          // isWorking
                                                          ? 'ثبت خروج'
                                                          : "ثبت ورود",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: theme
                                                          .textTheme.headline3!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                ),
                                              ]))),

                                  Spacer(),
                                  Card(
                                    // margin:
                                    //     EdgeInsets.only(top: fullHeight(context) / 13),
                                    color: Colors.grey.shade100,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            smallSize(context))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: mediumSize(context)),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: smallSize(context)),
                                            child: Text(
                                                dateFormat() +
                                                    ' ${Jalali.now().year}',
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: theme
                                                    .textTheme.headline3!
                                                    .copyWith(
                                                        // fontSize: largeSize(context),
                                                        color: Colors
                                                            .grey.shade800,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: iconSizeXLarge(
                                                            context) *
                                                        1.4,
                                                    child: Image.asset(
                                                        'assets/sign-in.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: xSmallSize(
                                                            context)),
                                                    child: Text(
                                                        model.data?.data
                                                                ?.startTime ??
                                                            "00:00",
                                                        // model.profileRPM?.data
                                                        //         ?.startTime ??
                                                        //     "",
                                                        // user.startTime,
                                                        // model.openTime,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900)),
                                                  ),
                                                  Text('ورود',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    width: iconSizeXLarge(
                                                            context) *
                                                        1.4,
                                                    child: Image.asset(
                                                        'assets/log-out.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: xSmallSize(
                                                            context)),
                                                    child: Text(
                                                        model.data?.data
                                                                ?.endTime ??
                                                            "00:00",
                                                        // ignore: unnecessary_null_comparison
                                                        // user.endTime,
                                                        // model.exitTime,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900)),
                                                  ),
                                                  Container(
                                                    child: Text('خروج',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    width: iconSizeXLarge(
                                                            context) *
                                                        1.4,
                                                    child: Image.asset(
                                                        'assets/door.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: xSmallSize(
                                                            context)),
                                                    child: Text(
                                                        model.data?.data
                                                                ?.WorkingTime ??
                                                            "00:00"
                                                        // model.profileRPM?.data
                                                        //         ?.WorkingTime
                                                        ,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900)),
                                                  ),
                                                  Text('زمان کاری',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                )),
          );
        });

    //
    // else{
    //   return Container(color: Colors.blue,height: 100,
    //   width: 100,);
    // }

    //       else if (snapshot.connectionState == ConnectionState.active ||
    //           snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           return const Text('Error');
    //         } else if (snapshot.hasData) {
    //           return Text(snapshot.data.toString(),
    //               style: const TextStyle(color: Colors.teal, fontSize: 36));
    //         } else {
    //           return const Text('Empty data');
    //         }
    //       } else {
    //         return Text('State: ${snapshot.connectionState}');
    //       }
    //     },
    //   );
    // });
  }
}

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woolha.com Flutter Tutorial',
      home: StreamBuilderExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Stream<int> generateNumbers = (() async* {
  await Future<void>.delayed(Duration(seconds: 2));

  for (int i = 1; i <= 5; i++) {
    await Future<void>.delayed(Duration(seconds: 1));
    yield i;
  }
})();

class StreamBuilderExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StreamBuilderExampleState();
  }
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: StreamBuilder<int>(
            stream: generateNumbers,
            initialData: 0,
            builder: (
              BuildContext context,
              AsyncSnapshot<int> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data.toString(),
                      style: const TextStyle(color: Colors.teal, fontSize: 36));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}*/
/*
void main() {
  runApp(MyAppss());
}

class MyAppss extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppss> {
  GlobalKey<SliderMenuContainerState> _key =
  new GlobalKey<SliderMenuContainerState>();
  late String title;

  @override
  void initState() {
    title = "Home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
        SliderMenuContainer(
            appBarColor: Colors.white,
            key: _key,
            sliderMenuOpenSize: 200,
            title: Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            animationDuration: 100,
            isDraggable: false,
            sliderMenuCloseSize: 400,
            slideDirection: SlideDirection.LEFT_TO_RIGHT,
            sliderMenu: MenuWidget(
              onItemClick: (title) {
                _key.currentState!.closeDrawer();
                setState(() {
                  this.title = title;
                });
              },
            ),
            sliderMain: MainWidget()),
      ),
    );
  }
}
class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Data> dataList = [];

  @override
  void initState() {
    super.initState();
    dataList.add(Data(Colors.amber, 'Amelia Brown',
        'Life would be a great deal easier if dead things had the decency to remain dead.'));
    dataList.add(Data(Colors.orange, 'Olivia Smith',
        'That proves you are unusual," returned the Scarecrow'));
    dataList.add(Data(Colors.deepOrange, 'Sophia Jones',
        'Her name badge read: Hello! My name is DIE, DEMIGOD SCUM!'));
    dataList.add(Data(Colors.red, 'Isabella Johnson',
        'I am about as intimidating as a butterfly.'));
    dataList.add(Data(Colors.purple, 'Emily Taylor',
        'Never ask an elf for help; they might decide your better off dead, eh?'));
    dataList.add(Data(Colors.green, 'Maya Thomas', 'Act first, explain later'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          //   physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemBuilder: (builder, index) {
            return LimitedBox(
              maxHeight: 150,
              child: Container(
                decoration: new BoxDecoration(
                    color: dataList[index].color,
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(10.0),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        dataList[index].name,
                        style: TextStyle(
                            fontFamily: 'BalsamiqSans_Blod',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        dataList[index].detail,
                        style: TextStyle(
                            fontFamily: 'BalsamiqSans_Regular',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (builder, index) {
            return Divider(
              height: 10,
              thickness: 0,
            );
          },
          itemCount: dataList.length),
    );
  }
}

class Data {
  MaterialColor color;
  String name;
  String detail;

  Data(this.color, this.name, this.detail);
}
class MenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/user_profile.jpg'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nick',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'BalsamiqSans'),
          ),
          SizedBox(
            height: 20,
          ),
          sliderItem('Home', Icons.home),
          sliderItem('Add Post', Icons.add_circle),
          sliderItem('Notification', Icons.notifications_active),
          sliderItem('Likes', Icons.favorite),
          sliderItem('Setting', Icons.settings),
          sliderItem('LogOut', Icons.arrow_back_ios)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
        TextStyle(color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        icons,
        color: Colors.black,
      ),
      onTap: () {
        onItemClick!(title);
      });
}

// class Drawer3 extends StatelessWidget {
//   Drawer3({Key? key}) : super(key: key);
//   final GlobalKey<SliderDrawerWidgetState> drawerKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return SliderDrawerWidget(
//         key: drawerKey,
//         option: SliderDrawerOption(
//           backgroundImage: Image.asset("assets/animationlogo.png"),
//           backgroundColor: Colors.black,
//           sliderEffectType: SliderEffectType.Rounded,
//           upDownScaleAmount: 50,
//           radiusAmount: 50,
//         ),
//         drawer: const CustomDrawer(),
//         body: Scaffold(
//           appBar: AppBar(
//             leading: GestureDetector(
//               onTap: () {
//                 drawerKey.currentState!.toggleDrawer();
//               },
//               child: const Icon(Icons.menu),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: List.generate(
//                 100,
//                     (index) => Container(
//                   padding: const EdgeInsets.all(15),
//                   child: Text("$index Flutter"),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);
//
//   Widget _thumbnailPart() {
//     return Row(
//       children: [
//         SizedBox(
//           width: 50,
//           height: 50,
//           child: CircleAvatar(
//             backgroundImage:
//             Image.asset("assets/logo.png", fit: BoxFit.contain)
//                 .image,
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   "Flutter",
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 Text(
//                   "developer",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.5),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget get _line => Container(
//       margin: const EdgeInsets.symmetric(vertical: 15),
//       height: 1,
//       color: Colors.white.withOpacity(0.2));
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _thumbnailPart(),
//             const SizedBox(height: 20),
//             _line,
//             const MenuBox(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.add_chart,
//                 color: Colors.white,
//               ),
//               menu: Text(
//                 "Chart",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const MenuBox(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.add_to_photos_outlined,
//                 color: Colors.white,
//               ),
//               menu: Text(
//                 "Photos",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const MenuBox(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.announcement_rounded,
//                 color: Colors.white,
//               ),
//               menu: Text(
//                 "Service center",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const MenuBox(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//               icon: Icon(
//                 Icons.settings,
//                 color: Colors.white,
//               ),
//               menu: Text(
//                 "Setting",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MenuBox extends StatelessWidget {
//   final EdgeInsetsGeometry? padding;
//   final Widget? icon;
//   final Widget menu;
//   final Function()? onTap;
//   const MenuBox({
//     Key? key,
//     required this.menu,
//     this.padding = const EdgeInsets.all(10),
//     this.icon,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (onTap != null) {
//           onTap!();
//         }
//       },
//       child: Container(
//         padding: padding,
//         child: Row(
//           children: [
//             icon != null ? icon! : Container(),
//             const SizedBox(width: 15),
//             menu,
//           ],
//         ),
//       ),
//     );
//   }
// }*/
