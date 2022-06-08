import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class AppLocalization{
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context){
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static LocalizationsDelegate<AppLocalization> delegate =  _AppLocalizationsDelegate();

  late Map<String, String> _localizationString;
  
  Future<bool> load() async{
    String jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizationString = jsonMap.map((key, value){
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String? translate(String key){
    return _localizationString[key];
  }
}


class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization>{
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale)  async{
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;

  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }

}