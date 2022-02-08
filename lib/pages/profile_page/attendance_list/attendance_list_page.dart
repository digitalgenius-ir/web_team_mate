import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:attendance/pages/home_page/home_page.dart';
import 'package:attendance/pages/profile_page/profile_notifier.dart';
import 'package:attendance/pages/profile_page/widgets/attendance_card.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/onBackClick.dart';
import 'package:attendance/widgets/action_widgets.dart';
import 'package:attendance/widgets/profile_bottom_sheet.dart';
import 'package:attendance/widgets/image_widget.dart';
import 'package:attendance/widgets/profile_item_widget.dart';

class AttenadancePage extends StatefulWidget {
  const AttenadancePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AttenadancePageState();
}

class AttenadancePageState extends State<AttenadancePage> {
  final AppPreferences pref = locator<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<ProfileVM>.reactive(
        viewModelBuilder: () => ProfileVM(),
        disposeViewModel: true,
        builder: (context, model, child) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        splashRadius: largeSize(context),
                        icon: Icon(
                          Icons.add,
                          size: iconSizeLarge(context),
                          color: Colors.black,
                        )),
                  ],
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashRadius: largeSize(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: iconSizeLarge(context),
                        color: Colors.black,
                      )),
                  elevation: 0,
                  title: Text("تردد ها",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.black)),
                ),
                backgroundColor: AppColors.background,
                body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overScroll) {
                      overScroll.disallowGlow();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: 8,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => attendanceCard(context),
                      padding: EdgeInsets.only(
                          top: xlargeSize(context),
                          right: standardSize(context),
                          left: standardSize(context)),
                    )),
              ));
        });
  }
}
