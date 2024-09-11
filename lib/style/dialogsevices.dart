import 'package:flutter/material.dart';

class DialogService{
  static Future<void> showDeleteDialog(BuildContext context, Map<String, dynamic> record, Function deleteCallback) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: SizedBox(height: 190,width: 180,child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ const Text("Do you really want to delete this record?"),
          const SizedBox(height: 120,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            
            ElevatedButton(   style:ButtonStyle(
         
              foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 0, 0, 0),
              ),
              backgroundColor: MaterialStateProperty.all( Colors.redAccent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
             
            ),
                            onPressed: (){   Navigator.of(context).pop();},
                            child:const Text('Cancel',style: TextStyle(color: Colors.white),)),
                            const SizedBox(width: 50,),
            ElevatedButton(   style:ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 0, 0, 0),
              ),
              backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255, 71, 70, 70)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            
            ),
                            onPressed: (){   Navigator.of(context).pop();},
                            child:const Text('Confirm',style: TextStyle(color: Colors.white))),
           
           ],)
          ],),)
         
         ,
        );
      },
    );
  }

  static Future<void> showEditDialog(BuildContext context, Map<String, dynamic> record, Function editCallback) async {
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
        return AlertDialog(
          title: const Text('Edit Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: wordController,
                decoration: const InputDecoration(labelText: 'Word'),
              ),
             TextField(
                controller: partOfSpeechController,
                decoration: const InputDecoration(labelText: 'Part of Speech'),
              ),
              TextField(
                controller: definitionController,
                decoration: const InputDecoration(labelText: 'Definition'),
              ),
              TextField(
                controller: exampleController,
                decoration: const InputDecoration(labelText: 'Example'),
              ),
            const SizedBox(height: 20,),
            
            ElevatedButton(   style:ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 0, 0, 0),
              ),
              backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255, 71, 70, 70)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            
            ),
                           onPressed: () {
                editCallback(
                  record['id'].toString(),
                  wordController.text,
                 partOfSpeechController.text,
                 definitionController.text,
                 exampleController.text,
                );
                Navigator.pop(context);
              },
                            child:const Text('Save',style: TextStyle(color: Colors.white))),
            ],
          ),
         
          
        );
      },
    );
  }

 
}
