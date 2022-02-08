import 'package:flutter/cupertino.dart';

void closeKeybored(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
