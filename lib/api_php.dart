import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static late String w;

  /// Sets the base URL using the local IP address.
  static void setLocalIp(String localIp) {
    w = "http://$localIp/";
  }

  /// API Endpoints
  static String get login => "${w}adminsite/login.php";
  static String get quizes => "${w}api/crud/quizez.php";
  static String get quizeE => "${w}api/crud/quizezE.php";
  static String get quizmed => "${w}api/crud/quizme.php";
  static String get quizhar => "${w}api/crud/quizha.php";
  static String get users => "${w}api/crud/Userz.php";
  static String get iloaudio => "${w}api/crud/audioilocaedd.php";
  static String get pangaudio => "${w}api/crud/audiopangedd.php";
  static String get engdic => "${w}api/crud/engdictedd.php";
  static String get tagdic => "${w}api/crud/tagdictedd.php";
  static String get ilodic => "${w}api/crud/ilocadictedd.php";
  static String get pangdic => "${w}api/crud/pangdictedd.php";
  static String get ilotrans => "${w}api/crud/traniloca.php";
  static String get pangtrans => "${w}api/crud/tranpang.php";
  static String get engadd => "${w}api/add_word/engadd.php";
  static String get tagadd => "${w}api/add_word/tagadd.php";
  static String get ilocaadd => "${w}api/add_word/ilocaadd.php";
  static String get pangadd => "${w}api/add_word/pangadd.php";
  static String get engin => "${w}api/in/addeng.php";
  static String get fetra => "${w}api/Crudtranslationdictionary.php";
  static String get deltra => "${w}api/delete_translation.php";
  static String get edtra => "${w}api/editTranslation.php";
  static String get upaud => "${w}api/upload_audio.php";
  static String get playz => "${w}api/audiopre.php?file_name=";
  static String get notif => "${w}api/notif.php";
  static String get audiocountpang => '${w}api/count/audiopang.php';
  static String get audiocountiloca => '${w}api/count/audioiloca.php';
  static String get userc => '${w}api/count/userc.php';
  static String get quizez => '${w}api/count/quizc.php';
  static String get texttran => '${w}api/count/texttrapang.php';
}

class FetchApi {

 static Future<String> apan() async {
  final response = await http.get(Uri.parse(Api.audiocountiloca));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as String; 
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}
 static Future<String> ailo() async {
  final response = await http.get(Uri.parse(Api.audiocountiloca));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as String; 
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}
 static Future<String> userc() async {
  final response = await http.get(Uri.parse(Api.userc));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as String; 
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}
 static Future<String> quize() async {
  final response = await http.get(Uri.parse(Api.quizez));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as String;
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}

 static Future<String> trapan() async {
  final response = await http.get(Uri.parse(Api.texttran));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as String; 
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}}
class RecordApi {
  final String apiUrl;
  final List<Map<String, dynamic>> records;

  RecordApi(this.apiUrl, this.records);

  Future<void> fetchRecords() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      records.clear();
      records.addAll(List<Map<String, dynamic>>.from(json.decode(response.body)));
    } else {
      throw Exception('Failed to fetch records');
    }
  }

  Future<void> addRecord(Map<String, String> data) async {
    final response = await http.post(Uri.parse(apiUrl), body: data);

    if (response.statusCode == 201) {
      await fetchRecords();
    } else {
      throw Exception('Failed to add record');
    }
  }

  Future<void> editRecord(String id, Map<String, String> data) async {
    final response = await http.put(Uri.parse(apiUrl), body: data);

    if (response.statusCode == 200) {
      await fetchRecords();
    } else {
      throw Exception('Failed to edit record');
    }
  }

  Future<void> deleteRecord(String id) async {
    final response = await http.delete(Uri.parse(apiUrl), body: {'id': id});

    if (response.statusCode == 200) {
      await fetchRecords();
    } else {
      throw Exception('Failed to delete record');
    }
  }
}

class AddRecordz {
  final String apiUrl;
  final Function recordsCallback;

  AddRecordz(this.apiUrl, this.recordsCallback);

  Future<void> addRecord({
    required String word,
    required String partOfSpeech,
    required String definition,
    required String example,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'word': word,
          'part_of_speech': partOfSpeech,
          'definition': definition,
          'example': example,
        },
      );

      if (response.statusCode == 201) {
        recordsCallback();
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exceptions
    }
  }
}
