import 'dart:convert';

import 'package:adminsite/api_php.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'package:adminsite/style/colorpallete.dart';
import 'package:flutter/material.dart' as material;

class AddTra extends StatefulWidget {
  const AddTra({super.key});

  @override
  State<AddTra> createState() => _AddTraState();
}

class _AddTraState extends State<AddTra> {
  List<Map<String, dynamic>> records = [];
  String pOs = 'Select Parts of Speech';
  String noun = 'Noun';
  String pronoun = 'Pronoun';
  String verb = 'Verb';
  String adjective = 'Adjective';
  String adverb = 'Adverb';
  late String searchText = '';
  TextEditingController engW = TextEditingController();
  TextEditingController engE = TextEditingController();
  TextEditingController pangW = TextEditingController();
  TextEditingController pangE = TextEditingController();
  TextEditingController ilocaW = TextEditingController();
  TextEditingController ilocaE = TextEditingController();
  TextEditingController tagW = TextEditingController();
  TextEditingController tagE = TextEditingController();
  TextEditingController deF = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> addTranslation(
    String english,
    String pangasinan,
    String ilocano,
    String tagalog,
    String partOfSpeech,
    String definition,
    String englishExample,
    String pangasinanExample,
    String ilocanoExample,
    String tagalogExample
  ) async {
    final response = await http.post(
      Uri.parse(Api.fetra),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "english_word": english,
        "pangasinan_word": pangasinan,
        "ilocano_word": ilocano,
        "tagalog_word": tagalog,
        "english_example": englishExample,
        "pangasinan_example": pangasinanExample,
        "ilocano_example": ilocanoExample,
        "tagalog_example": tagalogExample,
        "definition": definition,
        "part_of_speech": partOfSpeech
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      _showDialog();
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Comcol.dbl1,
        height: screenSize.height % 3200 - 212,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 350,
              height: 500,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border(
                  top: BorderSide(color: Colors.white, width: 1),
                  bottom: BorderSide(color: Colors.white, width: 1),
                  left: BorderSide(color: Colors.white, width: 1),
                  right: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: InfoLabel(
                          label: "English Word",
                          child: Column(
                            children: [
                              TextBox(
                                placeholder: 'Word',
                                controller: engW,
                              ),
                              TextBox(
                                placeholder: 'Enter the example here',
                                maxLength: 100,
                                controller: engE,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InfoLabel(
                        label: "Part of Speech:",
                        child: DropDownButton(
                          title: Text(pOs),
                          items: [
                            MenuFlyoutItem(
                              text: const Text('Noun'),
                              onPressed: () {
                                setState(() {
                                  pOs = noun;
                                });
                              },
                            ),
                            MenuFlyoutItem(
                              text: const Text('Pronoun'),
                              onPressed: () {
                                setState(() {
                                  pOs = pronoun;
                                });
                              },
                            ),
                            MenuFlyoutItem(
                              text: const Text('Verb'),
                              onPressed: () {
                                setState(() {
                                  pOs = verb;
                                });
                              },
                            ),
                            MenuFlyoutItem(
                              text: const Text('Adjective'),
                              onPressed: () {
                                setState(() {
                                  pOs = adjective;
                                });
                              },
                            ),
                            MenuFlyoutItem(
                              text: const Text('Adverb'),
                              onPressed: () {
                                setState(() {
                                  pOs = adverb;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: InfoLabel(
                          label: "Definition",
                          child: TextBox(
                            placeholder: 'Enter the Definition here',
                            maxLength: 100,
                            controller: deF,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: InfoLabel(
                          label: "Pangasinan",
                          child: Column(
                            children: [
                              TextBox(
                                placeholder: 'Word',
                                controller: pangW,
                              ),
                              TextBox(
                                placeholder: 'Enter the example here',
                                maxLength: 100,
                                controller: pangE,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: InfoLabel(
                          label: "Ilocano",
                          child: Column(
                            children: [
                              TextBox(
                                placeholder: 'Word',
                                controller: ilocaW,
                              ),
                              TextBox(
                                placeholder: 'Enter the example here',
                                maxLength: 100,
                                controller: ilocaE,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: InfoLabel(
                          label: "Tagalog",
                          child: Column(
                            children: [
                              TextBox(
                                placeholder: 'Word',
                                controller: tagW,
                              ),
                              TextBox(
                                placeholder: 'Enter the example here',
                                maxLength: 100,
                                controller: tagE,
                              ),
                            ],
                          ),
                        ),
                      ),
                      material.ElevatedButton(
                        style: const material.ButtonStyle(
                          side: material.MaterialStatePropertyAll(
                            BorderSide(width: 2, color: Colors.white),
                          ),
                          foregroundColor: material.MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          backgroundColor: material.MaterialStatePropertyAll(
                            Color.fromARGB(255, 22, 42, 94),
                          ),
                        ),
                        child: const Text("Submit"),
                        onPressed: () {
                        _showDialog();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Submission'),
          content: const Text("Are you sure you want to submit?"),
          actions: [
            material.TextButton(
              onPressed: () {
                _showSuccess();
                 addTranslation(
                            engW.text,
                            pangW.text,
                            ilocaW.text,
                            tagW.text,
                            pOs,
                            deF.text,
                            engE.text,
                            pangE.text,
                            ilocaE.text,
                            tagE.text,
                          );
              },
              child: const Text('Yes'),
            ),
             material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
               
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showSuccess() async {
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Done'),
          content: const Text("Submitted successfully"),
          actions: [
            material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
