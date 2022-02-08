import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/theme/dimens.dart';

void profileBottomSheet(BuildContext context, Widget child,
    {bool dismissible = false}) {
  var theme = Theme.of(context);
  // showModalBottomSheet(
  //   isScrollControlled: true,
  //   enableDrag: dismissible ? false : true,
  //   isDismissible: dismissible ? false : true,
  //   context: context,
  //   backgroundColor: theme.backgroundColor,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(
  //       topRight: Radius.circular(largeSize(context)),
  //       topLeft: Radius.circular(largeSize(context)),
  //     ),
  //   ),
  //   builder: (BuildContext context) {
  //     return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter setState) =>
  //
  //
  //     );
  //   },
  // );
  //
  // Padding(
  //   padding: MediaQuery.of(context).viewInsets,
  //   child: Directionality(textDirection: TextDirection.rtl, child: child),
  // ),
  showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: dismissible ? false : true,
      isDismissible: dismissible ? false : true,
      context: context,
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(largeSize(context)),
          topLeft: Radius.circular(largeSize(context)),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context,state){
          return   Padding(
          padding: MediaQuery.of(context).viewInsets,
  child: Directionality(textDirection: TextDirection.rtl, child: child),
  );
        });
      });
}
