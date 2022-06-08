

class Language{
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);


  // //the list of the available languages
  static List<Language> languageList (){
    return <Language>[
      Language(1, 'English', 'US', 'en'),
      Language(2, 'Arabic', 'SA', 'ar'),
    ];
  }

}