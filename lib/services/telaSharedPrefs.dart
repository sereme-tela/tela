

import 'package:mobile/models/abonnement.dart';
import 'package:mobile/models/abonnementType.dart';
import 'package:mobile/models/commune.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class TelaSharedPrefs implements InitializableDependency{


  TelaSharedPrefs(); // static final PyraNotification _singleton = PyraNotification._internal();


// Obtain shared preferences.
  late SharedPreferences prefs ;

  Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }

  /// save phone number
  Future<void> savePhoneNumber(String phone) async {
    await prefs.setString('phone', phone);
  }
  /// get phone number
  String? getPhoneNumber()  {
    return prefs.getString('phone');
  }
  /// save name
  Future<void> saveName(String name) async {
    await prefs.setString('name', name);
  }
  /// get name
  String? getName()  {
    return prefs.getString('name');
  }

  /// save abonnements
  Future<void> saveAbonnements(List<Abonnement> abonnement) async {
// Save an list of strings to 'items' key.

    await prefs.setStringList('abonnement', abonnement.map((e) => e.toString()).toList());
  }
  /// get abonnement
  List<Abonnement> getAbonnements()  {
    List<Abonnement> list = [];
    List<String>?  items = prefs.getStringList('abonnement');
    for (String element in items!) {
      List<String> sti = element.split(', ');
      Map<String, dynamic> json= {};
      for(String key_item in sti){
        List<String> key_items = key_item.split(': ');
        json[key_items[0]] = key_items[1];
      }

      Abonnement ab = Abonnement.fromJson(json);
      list.add(ab);
    }
    return list;
  }


  /// save abonnementType
  Future<void> saveAbonnementType(List<AbonnementType> abonnementType) async {
// Save an list of strings to 'items' key.

    await prefs.setStringList('abonnementType', abonnementType.map((e) => e.toString()).toList());
  }
  /// get abonnementType
  List<AbonnementType> getAbonnementType()  {
    List<AbonnementType> list = [];
    List<String>?  items = prefs.getStringList('abonnementType');
    for (String element in items!) {
      List<String> sti = element.split(', ');
      Map<String, dynamic> json= {};
      for(String itt in sti){
        List<String> keyItems = itt.split(': ');
        json[keyItems[0]] = keyItems[1];
      }

      AbonnementType at = AbonnementType.fromJson(json);
      list.add(at);
    }
    return list;
  }

  /// save passType
  Future<void> savePassType(List<PassType> passType) async {

    await prefs.setStringList('passType', passType.map((e) => e.toString()).toList());
  }
  /// get passType
  List<PassType> getPassType()  {
    List<PassType> list = [];
    List<String>?  items = prefs.getStringList('passType');
    for (String element in items!) {
      List<String> sti = element.split(', ');
      Map<String, dynamic> json= {};
      for(String itt in sti){
        List<String> keyItems = itt.split(': ');
        json[keyItems[0]] = keyItems[1];
      }

      PassType at = PassType.fromJson(json);
      list.add(at);
    }
    return list;
  }


  /// seve communes
  Future<void> saveCommunes(List<Commune> commumes) async {
// Save an list of strings to 'items' key.

    await prefs.setStringList('commumes', commumes.map((e) => e.toString()).toList());
  }
  /// get Communes
  List<Commune> getCommunes()  {
    List<Commune> list = [];
    List<String>?  items = prefs.getStringList('commumes');
    for (String element in items!) {
      List<String> sti = element.split(', ');
      Map<String, dynamic> json= {};
      for(String key_item in sti){
        List<String> key_items = key_item.split(': ');
        json[key_items[0]] = key_items[1];
      }

      Commune commune = Commune.fromJson(json);
      list.add(commune);
    }
    return list;
  }





}