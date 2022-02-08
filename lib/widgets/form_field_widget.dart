import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';

// ignore: must_be_immutable
class FormFieldWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormFieldWidgetState();

  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final bool obscure;
  final String hint;
  final TextEditingController controller;
  final String title;
  final CrossAxisAlignment crossAxisTitle;
  final int length;
  final IconData suffixIcon;
  final TextInputType keyboardType;

  // ignore: prefer_typing_uninitialized_variables
  final isEnable;

  // ignore: prefer_typing_uninitialized_variables
  var textInputFormatter;

  FormFieldWidget(this.hint, this.controller,
      {Key? key,
      this.validator,
      this.obscure = false,
      this.title = "",
      this.crossAxisTitle = CrossAxisAlignment.start,
      this.length = 0,
      this.suffixIcon = Icons.phone_android,
      this.keyboardType = TextInputType.text,
      this.isEnable = true,
      this.textInputFormatter})
      : super(key: key);
}

class FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: widget.crossAxisTitle,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                right: xlargeSize(context), left: xlargeSize(context)),
            child: Text(
              "به اپلیکیشن هوشمند حضور و غیاب آنلاین\nخوش آمدید .",
              style: theme.textTheme.headline3!.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: largeSize(context)),
            child: Text(widget.title, style: theme.textTheme.headline4!.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(top: largeSize(context)),
            child: TextFormField(
              inputFormatters: widget.textInputFormatter,
              // inputFormatters: <TextInputFormatter>[
              //   MaskedTextInputFormatter(
              //     mask: 'xxxx-xxx-xxxx',
              //     separator: '-',
              //   ),
              // ],
              maxLength: widget.length,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textDirection: TextDirection.rtl,
              obscureText: widget.obscure,
              validator: (value) {
                widget.validator;
              },
              style: theme.textTheme.bodyText1!.copyWith(color: Colors.black),
              decoration: InputDecoration(
                enabled: widget.isEnable,
                suffixIcon: Icon(
                  widget.suffixIcon,
                  color: theme.primaryColor,
                ),
                counterStyle: TextStyle(
                  color: Colors.grey,
                ),
                hintStyle:
                    theme.textTheme.bodyText1!.copyWith(color: Colors.grey),
                contentPadding: EdgeInsets.all(smallSize(context)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(xSmallSize(context)),
                  borderSide: BorderSide(
                    color: Color(0xffE6E6E6),
                  ),
                ),
                filled: true,
                fillColor: Color(0xffE6E6E6),
                hintText: widget.hint,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(xSmallSize(context)),
                    borderSide: BorderSide(
                      color: Color(0xffE6E6E6),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(xSmallSize(context)),
                    borderSide: BorderSide(
                      color: Color(0xffE6E6E6),
                    )),
                errorStyle: TextStyle(color: Color(0xffFF4646)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(xSmallSize(context)),
                    borderSide: BorderSide(color: Color(0xffFF4646))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(xSmallSize(context)),
                    borderSide: BorderSide(color: Color(0xffFF4646))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
