import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_app/custom_theme.dart';

BoxDecoration getDecoration(BuildContext context) {
  return BoxDecoration(
    color: getCurrentSecondaryBackground(context),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );
}
