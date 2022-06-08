import 'package:flutter/material.dart';

import 'app_localization.dart';

// this methode is use translate the text to the chosen language
String? getTranslated(BuildContext context, String key){
  return AppLocalization.of(context)?.translate(key);
}