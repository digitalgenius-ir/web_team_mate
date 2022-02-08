import 'package:attendance/theme/dimens.dart';
import 'package:attendance/widgets/action_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


Widget homeProfilePart(BuildContext context,
    {required String title, required String icon,required VoidCallback onTap}) {
  var theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(
              left: standardSize(context),
              right: smallSize(context),
              top: smallSize(context),
              bottom: smallSize(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: standardSize(context)),
                    child: Image.asset(icon,color: Colors.white,height: iconSizeXLarge(context),)),
                Expanded(
                    child: Text(title,
                        style: theme.textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white,

                        ))),
                // SvgPicture.asset("assets/arrow_back.svg"),
              ],
            ),
          ),
        ),
      ),
      // Container(
      //     margin: EdgeInsets.only(right: 24.w,),
      //     child: Divider(color: Color(0xfff4f4f4),))

    ],
  );
}
