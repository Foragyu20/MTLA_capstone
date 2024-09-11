import 'package:adminsite/api_php.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:adminsite/home.dart';
import 'package:adminsite/style/colorpallete.dart';

class Editmodez extends StatelessWidget {
  const Editmodez({super.key});

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      title: 'Edit',
      home: TranslationE(),
    );
  }
}

class TranslationE extends StatefulWidget {
  const TranslationE({Key? key}) : super(key: key);

  @override
  TranslationEState createState() => TranslationEState();
}

class TranslationEState extends State<TranslationE> {
  List<Map<String, dynamic>> records = [];
  late String searchText = '';

  bool isWordValid = true;

  @override
  void initState() {
    super.initState();
    fetchRecords();

  }

  Future<void> fetchRecords() async {
    final response = await http.get(
      Uri.parse(Api.fetra),
    );

    if (response.statusCode == 200) {
      setState(() {
        records = List<Map<String, dynamic>>.from(json.decode(response.body));
        records = records.where((record) {
          return record['english_word'] != null && record['english_word'].toLowerCase().contains(searchText.toLowerCase());
        }).toList();
      });
    } else {
      // Handle error
      print('Error fetching records: ${response.statusCode}');
    }
  }

  Future<void> editTranslation(
    String id,
    String english,
    String pangasinan,
    String ilocano,
    String tagalog,
    String partOfSpeech,
    String definition,
    String englishExample,
    String pangasinanExample,
    String ilocanoExample,
    String tagalogExample,
  ) async {
    final response = await http.post(
      Uri.parse(Api.edtra),
      body: {
        'id': id,
        'english_word': english,
        'pangasinan_word': pangasinan,
        'ilocano_word': ilocano,
        'tagalog_word': tagalog,
        'part_of_speech': partOfSpeech,
        'definition': definition,
        'english_example': englishExample,
        'pangasinan_example': pangasinanExample,
        'ilocano_example': ilocanoExample,
        'tagalog_example': tagalogExample,
      },
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result['message']);
    } else {
      print('Error editing translation: ${response.statusCode}');
    }
  }

  Future<void> deleteRecord(String id) async {
    final response = await http.delete(
      Uri.parse(Api.fetra),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      fetchRecords();
    } else {
      print('Error deleting record: ${response.statusCode}');
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Comcol.db2,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                material.ElevatedButton(
                  style: const material.ButtonStyle(
                    side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
                    foregroundColor: material.MaterialStatePropertyAll(Colors.white),
                    backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)),
                  ),
                  child: const Stack(
                    children: [
                      Row(
                        children: [
                          Icon(FluentIcons.back),
                          Text(
                            "Go Back",
                            style: TextStyle(fontFamily: 'Arimo'),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      FluentPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: TextBox(
                    placeholder: 'Search',
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                        fetchRecords();
                      });
                    },
                    decoration: const BoxDecoration(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                bool isEven = index % 2 == 0;
                Color backgroundColor = isEven ? Comcol.dbl1 : Comcol.db2;
                final record = records[index];
                TextEditingController engW = TextEditingController(text: record['english_word']);
                TextEditingController engE = TextEditingController(text: record['english_example']);
                TextEditingController pangW = TextEditingController(text: record['pangasinan_word']);
                TextEditingController pangE = TextEditingController(text: record['pangasinan_example']);
                TextEditingController ilocaW = TextEditingController(text: record['ilocano_word']);
                TextEditingController ilocaE = TextEditingController(text: record['ilocano_example']);
                TextEditingController tagW = TextEditingController(text: record['tagalog_word']);
                TextEditingController tagE = TextEditingController(text: record['tagalog_example']);
                TextEditingController deF = TextEditingController(text: record['definition']);
               TextEditingController gets =TextEditingController(text:record['part_of_speech'] );
                return Container(
                  padding: const EdgeInsets.all(20),
                  color: backgroundColor,
                  child: Expander(
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: Text(
                            record['english_word'],
                            style: const TextStyle(fontSize: 20, fontFamily: 'Kadwa'),
                          ),
                        ),
                      ],
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 5),
                      ],
                    ),
                    content: Column(
                      children: [
                        Column(
                          children: [
                            InfoLabel(label: 'English:', child: TextBox(controller: engW)),
                            InfoLabel(label: 'Definition:', child: TextBox(controller: deF)),
                            InfoLabel(label: 'Parts of Speech:', child: TextBox(
                              controller: gets,
                              placeholder:'enter only "Noun", "Pronoun", "Verb", "Adjective", "Adverb"' ,
                             
                             )),
                            InfoLabel(label: 'English Example:', child: TextBox(controller: engE)),
                            InfoLabel(label: 'Pangasinan:', child: TextBox(controller: pangW)),
                            InfoLabel(label: 'Pangasinan Example:', child: TextBox(controller: pangE)),
                            InfoLabel(label: 'Ilocano:', child: TextBox(controller: ilocaW)),
                            InfoLabel(label: 'Ilocano Example:', child: TextBox(controller: ilocaE)),
                            InfoLabel(label: 'Tagalog:', child: TextBox(controller: tagW)),
                            InfoLabel(label: 'Tagalog Example:', child: TextBox(controller: tagE)),
                          ],
                        ),
                        material.ElevatedButton(
                          style: material.ButtonStyle(
                            side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
                            foregroundColor: material.MaterialStatePropertyAll(Colors.white),
                            backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)),
                          ),
                          onPressed:() {
                                  editTranslation(
                                    record['id'].toString(),
                                    engW.text,
                                    pangW.text,
                                    ilocaW.text,
                                    tagW.text,
                                    gets.text, 
                                    deF.text,
                                    engE.text,
                                    pangE.text,
                                    ilocaE.text,
                                    tagE.text,
                                  );
                                  _showDialog();
                                },
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Done'),
          content: const Text("Submission Success"),
          actions: [
            material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
