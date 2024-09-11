import 'package:adminsite/api_php.dart';
import 'package:adminsite/style/colorpallete.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizEasyList extends StatefulWidget {
  const QuizEasyList({super.key});

  @override
  QuizEasyListState createState() => QuizEasyListState();
}

class QuizEasyListState extends State<QuizEasyList> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final response = await http.get(Uri.parse(Api.quizes));

    if (response.statusCode == 200) {
      setState(() {
        records = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
    }
  }

  Future<void> addRecord(
    String question, 
    String option1,
    String option2,
    String option3, 
    String option4, 
    String correctAnswer) async {
    final response = await http.post(
      Uri.parse(Api.quizes),
      body: {
      'question': question, 
      'option_1': option1, 
      'option_2': option2, 
      'option_3': option3, 
      'option_4':option4, 
      'correct_answer':correctAnswer},
    );

    if (response.statusCode == 201) {
      fetchRecords();
    } else {
      // Handle error
    }
  }

  Future<void> editRecord(
    String id, 
    String question, 
    String option1,
    String option2,
    String option3, 
    String option4, 
    String correctAnswer) async {
    final response = await http.put(
      Uri.parse(Api.quizes),
      body: {
      'id':  id,
      'question': question, 
      'option_1': option1, 
      'option_2': option2, 
      'option_3': option3, 
      'option_4':option4, 
      'correct_answer':correctAnswer},
    );

    if (response.statusCode == 200) {
      
  
      fetchRecords();
    } else {
      // Handle error
    }
  }

  Future<void> deleteRecord(String id) async {
    final response = await http.delete(
      Uri.parse(Api.quizes),
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
    return 
    Container(
      padding: const EdgeInsets.all(0),
      child:
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          color: Comcol.db2,
          child:
          ListTile(title: const Text("Quiz",style: TextStyle(fontSize: 40,fontFamily: "Kadwa",color: Comcol.dbl),), trailing:material.ElevatedButton(
            style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
          onPressed: () {
            _showAddDialog();
          },
          child: Container(height: 20,
          width: 80,
            decoration:const BoxDecoration(),
            child: const Stack(children: [
        Row(children: [Icon(FluentIcons.add),SizedBox(width: 3,),Text("Add New")],)],) ),
        ), ),
          ),
        Container(
          color: Comcol.db1,
          child:  
          const ListTile(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      SizedBox(width: 100,child:Text('Question',
        style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
      SizedBox(width: 100,child:Text('Option1',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
      SizedBox(width: 100,child:Text('Option2',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ), 
      SizedBox(width: 100,child:Text('Option3',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
       SizedBox(width: 100,child:Text('Option4',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
       SizedBox(width: 100,child:Text('Correct Answer',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
       SizedBox(width: 10,)
      ],),
      trailing:SizedBox(child:Text('Actions',
        style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),),),
      )),
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
            bool isEven =index % 2==0;
           Color backgroundColor =isEven? Comcol.db2:Comcol.dbl1;
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
                      child: Text(record['question'],
                      style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl)),),
                    SizedBox(
                      width: 140,
                    child:Text(record['option_1'],
                    style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl),),),
                    SizedBox(
                      width: 140,
                    child:Text(record['option_2'],
                    style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl),),),
                    SizedBox(
                      width: 140,
                    child:Text(record['option_3'],
                    style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl),),),
                    SizedBox(
                      width: 140,
                    child:Text(record['option_4'],
                    style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl),),),  
                    SizedBox(
                      width: 140,child:Text(record['correct_answer'],
                      style: const TextStyle(fontSize: 15,fontFamily: 'Kadwa',color: Comcol.dbl),),),
                ],),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    material.ElevatedButton(
                     style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  Stack(children: [
                      Row(children: [
                     SizedBox.square(child: Image.asset('assets/Edit.png'),),],)],),
                      onPressed: () {
                        _showEditDialog(record);
                      },
                    ),
                    const SizedBox(width: 5,),
                    material.ElevatedButton(
                      style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  Stack(children: [
                      Row(children: [SizedBox.square(child: Image.asset('assets/Delete.png',color: Comcol.dbl,scale: 1,),),
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
          title: const Text('Edit Record'),
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


  // Show dialog for adding a new record
  Future<void> _showAddDialog() async {
    TextEditingController questionController = TextEditingController();
    TextEditingController option1Controller = TextEditingController();
    TextEditingController option2Controller = TextEditingController();
    TextEditingController option3Controller = TextEditingController();
    TextEditingController option4Controller = TextEditingController();
    TextEditingController correcController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Add New Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              material.TextField(
                controller: questionController,
                decoration: const material.InputDecoration(labelText: 'Question'),
              ),
               material.TextField(
                controller: option1Controller,
                decoration: const material.InputDecoration(labelText: 'Option1'),
              ),
               material.TextField(
                controller: option2Controller,
                decoration: const material.InputDecoration(labelText: 'Option2'),
              ),
               material.TextField(
                controller: option3Controller,
                decoration: const material.InputDecoration(labelText: 'Option3'),
              ),
               material.TextField(
                controller: option4Controller,
                decoration: const material.InputDecoration(labelText: 'Option4'),
              ),
             material.TextField(
                controller: correcController,
                decoration: const material.InputDecoration(labelText: 'Correct answer'),
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
                addRecord(
                  questionController.text,
                  option1Controller.text,
                  option2Controller.text,
                  option3Controller.text,
                  option4Controller.text,
                  correcController.text
                );
                  Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for editing an existing record
  Future<void> _showEditDialog(Map<String, dynamic> record) async {
    TextEditingController questionController =
        TextEditingController(text: record['question']);
    TextEditingController option1Controller =
        TextEditingController(text: record['option_1']);
    TextEditingController option2Controller =
        TextEditingController(text: record['option_2']);
    TextEditingController option3Controller =
        TextEditingController(text: record['option_3']);
        TextEditingController option4Controller =
        TextEditingController(text: record['option_4']);
    TextEditingController correcController =
        TextEditingController(text: record['correct_answer']);
         
    await showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Edit Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
               material.TextField(
                controller: questionController,
                decoration: const material.InputDecoration(labelText: 'Question'),
              ),
               material.TextField(
                controller: option1Controller,
                decoration: const material.InputDecoration(labelText: 'Option1'),
              ),
               material.TextField(
                controller: option2Controller,
                decoration: const material.InputDecoration(labelText: 'Option2'),
              ),
               material.TextField(
                controller: option3Controller,
                decoration: const material.InputDecoration(labelText: 'Option3'),
              ),
               material.TextField(
                controller: option4Controller,
                decoration: const material.InputDecoration(labelText: 'Option4'),
              ),
             material.TextField(
                controller: correcController,
                decoration: const material.InputDecoration(labelText: 'Correct answer'),
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
                editRecord(
                 record['id'].toString(),
                questionController.text,
                option1Controller.text,
                option2Controller.text,
                option3Controller.text,
                option4Controller.text,
                correcController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

