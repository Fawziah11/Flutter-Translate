import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translation/models/language.dart';
import 'package:translation/models/localization_method.dart';

import 'models/app_localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('ar', 'SA');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
      ),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA')
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales){
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == deviceLocale!.languageCode &&
              supportedLocale.countryCode == deviceLocale.countryCode
          ) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: _locale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropDownButtonText = "chose language";

  @override
  Widget build(BuildContext context) {
    _changeLanguage(lang) {
      Locale _temp;
      switch (lang.languageCode) {
        case 'en':
          _temp = Locale(lang.languageCode, 'US');
          break;
        case 'ar':
          _temp = Locale(lang.languageCode, 'SA');
          break;
        default:
          _temp = Locale(lang.languageCode, 'SA');
          break;
      }
      MyApp.setLocale(context, _temp);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("${getTranslated(context, "title")}", style: TextStyle(color: Colors.black),),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${getTranslated(context, "text1")}", style: TextStyle(fontSize: 30)),
            Text( "${getTranslated(context, "text2")}", style: TextStyle(fontSize: 30),),
            const SizedBox(height: 30),
            /* RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text("chose language", style: TextStyle(fontSize: 18),),
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
            )*/
            //DropdownMenu to display available languages
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( "${getTranslated(context, "button_text")}" , style: TextStyle(fontSize: 18),),
                DropdownButton(
                    borderRadius: BorderRadius.circular(5),
                    underline: const SizedBox(),
                    items: Language.languageList().map<DropdownMenuItem<Language>>(
                            (lang) => DropdownMenuItem<Language>(
                                  value: lang,
                                  child: Row(
                                    children: [Text(lang.name)],
                                  ),
                                )).toList(),
                    onChanged: (lang) {
                      _changeLanguage(lang);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
