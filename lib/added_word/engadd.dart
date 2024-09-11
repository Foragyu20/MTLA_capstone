import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:adminsite/api_php.dart';


class EnglishAddList extends StatefulWidget {
  const EnglishAddList({Key? key}) : super(key: key);

  @override
  EnglishAddListState createState() => EnglishAddListState();
}

class EnglishAddListState extends State<EnglishAddList> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final response = await http.get(
      Uri.parse(Api.engadd),
    );

    if (response.statusCode == 200) {
      setState(() {
        records = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
    }
  }


  Future<void> aRecordz(
   
    String word,
    String partOfSpeech,
    String definition,
    String example,

  ) async {
    final response = await http.post(
      Uri.parse(Api.engdic),
      body: {
        'word': word,
        'part_of_speech': partOfSpeech,
        'definition': definition,
        'example': example,
  
      },
    );

    if (response.statusCode == 200) {
      fetchRecords();
    } else {
      // Handle error
    }
  }

Future<void> editRecord(
    String word,
    String partOfSpeech,
    String definition,
    String example,
    
  ) async {
    final response = await http.post(
      Uri.parse(Api.engdic),
      body: {
        'word': word,
        'part_of_speech': partOfSpeech,
        'definition': definition,
        'example': example,
     
      },
    );

    if (response.statusCode == 200) {
      fetchRecords();
    } else {
      // Handle error
    }
  }

  Future<void> deleteRecord(String id) async {
    final response = await http.delete(
      Uri.parse(Api.engadd),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      fetchRecords();
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: const EdgeInsets.all(0),
      child:
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          color: const Color.fromARGB(255, 22, 30, 69),
          child:
          ListTile(title: Image.asset('assets/engaddedword.png',)),
          ),
        Container(
          color: const Color.fromARGB(255, 182, 107, 245),
          child:  
          const ListTile(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
      SizedBox(width: 140,child:Text('Word',
        style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
      SizedBox(width: 140,child:Text('Definition',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
      SizedBox(width: 140,child:Text('Example',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ), 
      SizedBox(width: 140,child:Text('Part Of Speech',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
    SizedBox(width: 140,)
      ],),
      trailing:
      Row(children: [SizedBox(width:25),SizedBox(width: 5,),SizedBox(width:25),SizedBox(width: 5,),SizedBox(child:Text('Actions',
        style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),),),SizedBox(width:25)],)
      
      )),
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
            bool isEven =index % 2==0;
            Color backgroundColor =isEven? const Color.fromARGB(255, 221, 214, 214):Colors.white;
              final record = records[index];
              return Container(
               color: backgroundColor,
                child:ListTile(
                title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [ 
                    SizedBox(
                      width: 140,
                      child: Text(record['word'],
                      style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa')),),
                    SizedBox(
                      width: 140,
                    child:Text(record['definition'],
                    style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa'),),),  
                    SizedBox(
                      width: 140,child:Text(record['example'],
                      style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa'),),),
                    SizedBox(
                      width:140,
          child: Text(record['part_of_speech'],
          style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa'),),),
                ],),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                 
                    material.ElevatedButton(
                      style: const material.ButtonStyle(
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 0, 175, 0)) ),
                      child:  Stack(children: [
                      Row(children: [const Text("Accept",style:TextStyle(fontFamily: 'Arimo') ,),
                      const SizedBox(width: 10,),SizedBox.square(child: Image.asset('assets/confirm.png'),),],)],),
                      onPressed: () {
                        _showConfirmDialog(record);
                      },
                    ),
                     const SizedBox(width: 5,),
                     material.ElevatedButton(
                      style: const material.ButtonStyle(
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 232, 175, 65)) ),
                      child:  Stack(children: [
                      Row(children: [const Text("Edit",style:TextStyle(fontFamily: 'Arimo') ,),
                      const SizedBox(width: 10,),SizedBox.square(child: Image.asset('assets/Edit.png'),),],)],),
                      onPressed: () {
                        _showEditDialog(record);
                      },
                    ),
                    const SizedBox(width: 5,),
                    material.ElevatedButton(
                      style: const material.ButtonStyle(
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 250, 81, 58)) ),
                      child:  Stack(children: [
                      Row(children: [const Text("Reject",style:TextStyle(fontFamily: 'Arimo') ,),const SizedBox(width: 10,),SizedBox.square(child: Image.asset('assets/Delete.png'),),
                      ],)],),
                      onPressed: () {
                       _showDeleteDialog(record);
                      },
                    ),
                  
                  ],
                ),
              )); 
            },
          ),
        ),
      ],
    ));
  }
Future<void> _showDeleteDialog(Map<String, dynamic> record) async {
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Delete Record'),
          content: const Text("Do you Really Want To Delete?"),
          actions: [
            material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () {
                deleteRecord(record['id'].toString());
                Navigator.of(context).pop();
              },
              child: const Text('Delete',style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),
            ),
          ],
        );
      },
    );
  }



  // Show dialog for Confirming
  Future<void> _showConfirmDialog(Map<String, dynamic> record) async {
    // Create TextEditingController for each input field and set initial values
    String word = record['word'];
    String partOfSpeech = record['part_of_speech'];
    String definition = record['definition'];
    String example = record['example'];


    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Confirm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              material.Text(word),
              material.Text(partOfSpeech),
              material.Text(definition),
              material.Text(example),
            ],
          ),
          actions: [
            material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () {
                aRecordz(
                 word,
                 partOfSpeech,
                 definition,
                 example,
        
                );
                Navigator.pop(context);
                deleteRecord(record['id'].toString());
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
   // Show dialog for editing an existing record
  Future<void> _showEditDialog(Map<String, dynamic> record) async {
    // Create TextEditingController for each input field and set initial values
    TextEditingController wordController = TextEditingController(text: record['word']);
    TextEditingController partOfSpeechController =
        TextEditingController(text: record['part_of_speech']);
    TextEditingController definitionController =
        TextEditingController(text: record['definition']);
    TextEditingController exampleController =
        TextEditingController(text: record['example']);
   

    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Edit Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              material.TextField(
                controller: wordController,
                decoration: const material.InputDecoration(labelText: 'Word'),
              ),
              material.TextField(
                controller: partOfSpeechController,
                decoration: const material.InputDecoration(labelText: 'Part of Speech'),
              ),
              material.TextField(
                controller: definitionController,
                decoration: const material.InputDecoration(labelText: 'Definition'),
              ),
              material.TextField(
                controller: exampleController,
                decoration: const material.InputDecoration(labelText: 'Example'),
              ),
            
            ],
          ),
          actions: [
            material.TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () {
                Navigator.pop(context);
                editRecord(
                  wordController.text,
                  partOfSpeechController.text,
                  definitionController.text,
                  exampleController.text,
                 
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
