import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

TextFormField d8EditTextStyle(BuildContext context,var hintText, {isPassword = true}) {
  var theme = Theme.of(context);
  return TextFormField(
    style:
    theme.textTheme.subtitle2!.copyWith(fontSize: 12,fontWeight: FontWeight.w600),
    // TextStyle(color: Colors.black38, fontSize: 14, ),
    obscureText: isPassword,
    // cursorColor: Colors.red,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(right: 12,top: 10,bottom: 10),
      // contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
      hintText: hintText,
      border: InputBorder.none,
      // labelText: hintText,
      // labelStyle: theme.textTheme.caption!.copyWith(fontSize: 12,fontWeight: FontWeight.w600) ,

      hintStyle:  theme.textTheme.caption!.copyWith(fontSize: 12,fontWeight: FontWeight.w600),
    ),
  );
}

Divider d8Divider() {
  return Divider(
    height: 1,
    color: Colors.black,
    thickness: 1,
  );
}

// ignore: must_be_immutable
class T8Button extends StatefulWidget {
  var textContent;

  //   var icon;
  VoidCallback onPressed;

  T8Button({
    required this.textContent,
    required this.onPressed,
    //   @required this.icon,
  });

  @override
  T8ButtonState createState() => T8ButtonState();
}

class T8ButtonState extends State<T8Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          decoration: boxDecoration(bgColor: Colors.purpleAccent, radius: 16),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: text(widget.textContent, textColor: Colors.red, fontFamily: 12, textAllCaps: false),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle,  color:  Colors.red,
                  ),
                  width: 35,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color:  Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class t8TopBar extends StatefulWidget {
  var titleName;

  t8TopBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return t8TopBarState();
  }
}

// ignore: camel_case_types
class t8TopBarState extends State<t8TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.red,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color:  Colors.green,
              onPressed: () {
                // finish(context);
              },
            ),
            Center(
              child: Text(
                widget.titleName,
                maxLines: 2,
                style: TextStyle( fontSize: 22, color:  Colors.lightGreen),
              ),
            )
          ],
        ),
      ),
    );
  }

  State<StatefulWidget>? createState() {
    return null;
  }
}

Container t8HeaderText(var text) {
  return Container(
    margin: EdgeInsets.only(top: 16),
    child: Text(
      text,
      maxLines: 2,
      style: TextStyle( fontSize: 22, color: Colors.red),
    ),
  );
}
BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: Colors.white ,
    boxShadow:  [BoxShadow(color: Colors.black38,blurRadius: 1,offset: Offset(0, 0),spreadRadius: 0.5)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}
Widget text(
    String? text, {
      var fontSize = 12,
      Color? textColor,
      var fontFamily,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5,
      bool textAllCaps = false,
      var isLongText = false,
      bool lineThrough = false,
    }) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? Colors.brown,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}
