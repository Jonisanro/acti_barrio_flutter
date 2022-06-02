import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isTutorialActived = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  //*Muestra o no el tutorial de la app

  static bool get isTutorialActived {
    return _prefs.getBool('isTutorialActived') ?? _isTutorialActived;
  }

  static set isTutorialActived(bool value) {
    _isTutorialActived = value;
    _prefs.setBool('isTutorialActived', value);
  }

  //*Favoritos

  List<String> _favorites = [];

  get favorites {
    return _prefs.getStringList('favorites');
  }

  void addFavorite(String id) {
    _favorites = _prefs.getStringList('favorites') ?? [];

    _prefs.setStringList('favorites', _favorites..add(id));
  }

  void removeFavorite(String id) {
    _favorites = _prefs.getStringList('favorites') ?? [];

    _prefs.setStringList('favorites', _favorites..remove(id));
  }

  bool existId(String id) {
    _favorites = _prefs.getStringList('favorites') ?? [];

    final bool exist = _favorites.contains(id);

    return exist;
  }
}
