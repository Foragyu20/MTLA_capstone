
import 'package:adminsite/api_php.dart';
import 'package:adminsite/style/colorpallete.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'addtra.dart';
import 'editmode.dart';
class Translation extends StatefulWidget {
  const Translation({Key? key}) : super(key: key);
  @override
TranslationState createState() => TranslationState();
}

class TranslationState extends State<Translation> {

  List<Map<String, dynamic>> records = [];

  bool formz = true;

late String searchText  = '';
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
          return  record['english_word'] != null && record['english_word'].toLowerCase().contains(searchText.toLowerCase());
        }).toList();
      });
    } else {
      // Handle error
    }
  }


  Future<void> deleteRecord(String id) async {
  final response = await http.post(
    Uri.parse(Api.deltra),
    body: {'id': id},
  );

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    print(result['message']);
    fetchRecords();
  } else {
    print('Error: ${response.statusCode}');
  }
}


  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(0),
      child:
    Column(
  mainAxisAlignment: MainAxisAlignment.center,
      children: [
Container(
          padding: const EdgeInsets.all(5),
          color:  Comcol.db2,
          child:
           ListTile(title:Row(children: [ const Text("Translation",style: TextStyle(fontSize: 40,fontFamily: "Kadwa",color: Comcol.dbl),),
           const SizedBox(width: 100,),
           SizedBox(width: 300,child:TextBox(
            placeholder: 'Search',
            onChanged: (value) {
                  setState(() {
                    searchText = value;
                    fetchRecords();
                  });
                },decoration:const BoxDecoration() ,) ,)
           ],), trailing:
                Row(children: [material.ElevatedButton(
            style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
          onPressed: () {
          setState(() {
            formz = !formz;
          });
          },
          child: Container(height: 40,
          width: 80,
          padding: const EdgeInsets.all(5),
            decoration:const BoxDecoration(),
            child:
        Row(children: [
      formz ? const Icon(FluentIcons.add) : const Icon(FluentIcons.back),
    const SizedBox(width: 5),
    formz ? const Text("Add") : const Text("back"),
        ],) ),
        ),
     
        const SizedBox(width: 50,),
         material.ElevatedButton(
                      style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  const Stack(children: [
                      Row(children: [Text("To Edit",style:TextStyle(fontFamily: 'Arimo') ,),
                       SizedBox(width: 10,), Icon(FluentIcons.edit)],)],),
                      onPressed: () {
                    Navigator.pushReplacement(
          context,
          FluentPageRoute(builder: (context) => const Editmodez()));
                      },
                    ), 
        ],)
                ),
          ),
       
       if (formz)
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
            bool isEven =index % 2==0;
          
            Color backgroundColor =isEven?  Comcol.dbl1:Comcol.db2;
              final record = records[index];
              return Container(
                padding: const EdgeInsets.all(20),
               color:  Comcol.dbl1,
                child:Expander(
                  contentBackgroundColor: backgroundColor,
                              header:Text(record['english_word'],
                      style:  const TextStyle(fontSize: 20,fontFamily: 'Kadwa',)), 
                content:
                
                   
                 Column( mainAxisAlignment: MainAxisAlignment.start,children:[
                    
const SizedBox(),

Column(
  children: [
  InfoLabel(label: 'Definition:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['definition'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),
   InfoLabel(label: 'Part of Speech:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['part_of_speech'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),
  
   InfoLabel(label: 'Example:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['english_example'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),

  InfoLabel(label: 'Pangasinan:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['pangasinan_word'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),

InfoLabel(label: 'Pangasinan Example:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['pangasinan_example'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),

InfoLabel(label: 'Ilocano:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
child:Text(record['ilocano_word'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl,),),),

InfoLabel(label: 'Ilocano Example:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['ilocano_example'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),

InfoLabel(label: 'Tagalog:',
labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
child: Text(record['tagalog_word'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl,),),)],),

InfoLabel(label: 'Tagalog Example:',labelStyle: const TextStyle(fontFamily: 'Kadwa',color: Comcol.dbl,),
  child:Text(record['tagalog_example'],style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl),),),
]),      
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   
                    const SizedBox(width: 5,),
                    material.ElevatedButton(
                      style:const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  Stack(children: [
                      Row(children: [const Text("Delete",style:TextStyle(fontFamily: 'Arimo') ,),const SizedBox(width: 10,),SizedBox.square(child: Image.asset('assets/Delete.png'),),
                      ],)],),
                      onPressed: () {
                       _showDeleteDialog(record);
                      },
                    ),
                  
                  ],
                ),
)
              
          );},
          ),
        
    )

    else
   const AddTra()
    
    ],
    ));
  }
void showContentDialog(BuildContext context) async {
   String pOs ='Select Parts of Speech';
String noun = 'Noun';
String pronoun = 'Pronoun';
String verb = 'Verb';
String adjective = 'Adjective';
String adverb = 'Adverb';

   await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('Delete file permanently?'),
      content:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width: 300,child:InfoLabel(label: "English Word",child: const TextBox(),),),
          SizedBox(width: 300,child:InfoLabel(label: "English Word",child: const TextBox(),) ,),
SizedBox(width: 300,child:InfoLabel(label: "English Word",child: const TextBox(),),),
        DropDownButton(
          title:Text(pOs),
          items: [
MenuFlyoutItem(text: const Text('Noun'), onPressed: () {
setState(() {
  pOs = noun;
});
}),
    MenuFlyoutItem(text: const Text('Pronoun'), onPressed: () {setState(() {
      pOs=pronoun;
    });}),
    MenuFlyoutItem(text: const Text('Verb'), onPressed: () {setState(() {
      pOs = verb;
    });}),
    MenuFlyoutItem(text: const Text('Adjective'), onPressed: () {setState(() {
      pOs = adjective;
    });}),
    MenuFlyoutItem(text: const Text('Adverb'), onPressed: () {setState(() {
      pOs = adverb;
    });}),
        ]), 
       
          ],) ,
      actions: [
        Button(
          child: const Text('Upload'),
          onPressed: () {
            Navigator.pop(context, 'Done');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, 'canceled'),
        ),
      ],
    ),
  );
  setState(() {});
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
}