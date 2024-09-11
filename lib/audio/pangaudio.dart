import 'dart:io';
import 'package:adminsite/style/colorpallete.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:adminsite/api_php.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:http/http.dart' as http;
import 'dart:convert';


class AudioPangasinanList extends StatefulWidget {
  const AudioPangasinanList({super.key});

  @override
  AudioPangasinanListState createState() => AudioPangasinanListState();
}

class AudioPangasinanListState extends State<AudioPangasinanList> {
  List<Map<String, dynamic>> records = [];
late File audio;
late String searchText  = '';
  @override
  void initState() {
    super.initState();
    fetchRecords();
  }
Future<void> fetchRecords() async {
    final response = await http.get(
      Uri.parse(Api.pangaudio),
    );

    if (response.statusCode == 200) {
      setState(() {
        records = List<Map<String, dynamic>>.from(json.decode(response.body));
        records = records.where((record) {
          return  record['pangasinan'] != null && record['pangasinan'].toLowerCase().contains(searchText.toLowerCase());
        }).toList();
      });
    } else {
      // Handle error
    }
  }


  Future<void> deleteRecord(String id) async {
    final response = await http.delete(
      Uri.parse(Api.pangaudio),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      fetchRecords();
    } else {
      // Handle error
    }
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
          ListTile(title:Row(children: [const Text("Pangasinan",style: TextStyle(fontSize: 40,fontFamily: "Kadwa",color: Comcol.dbl),), const SizedBox(width: 100,),
           SizedBox(width: 300,child:TextBox(
            placeholder: 'Search',
            onChanged: (value) {
                  setState(() {
                    searchText = value;
                    fetchRecords();
                  });
                },decoration:const BoxDecoration() ,) ,)],) , trailing:material.ElevatedButton(
            style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
          onPressed: () {
           pickFile();
          },
          child: Container(height: 40,
            decoration:const BoxDecoration(),
            child:const Icon(FluentIcons.cloud_upload)),
        ), ),
          ),
        Container(
          color: Comcol.db1,
          child:  
          const ListTile(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      
      SizedBox(width: 140,child:Text('Audio',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
   
   SizedBox(
        width: 200,
        child:Text('Actions',
        style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),),),
      ],),
     
      )),
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
            bool isEven =index % 2==0;
          Color backgroundColor =isEven?Comcol.dbl1:Comcol.db2;
              final record = records[index];
              return Container(
               color: backgroundColor,
                child:ListTile(
                title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    SizedBox(
                      width: 140,
                      child: Text(record['pangasinan'],
                      style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl)),),
               Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    material.ElevatedButton(
                   style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  const Stack(children: [
                      Row(children: [SizedBox.square(child: Icon(FluentIcons.play),),],)],),
                      onPressed: () {
                        playAudio(record['pangasinan']);
                      },
                    ),
                    const SizedBox(width: 5,),
                    material.ElevatedButton(
                style: const material.ButtonStyle(
              side: material.MaterialStatePropertyAll(BorderSide(width: 2, color: Colors.white)),
              foregroundColor: material.MaterialStatePropertyAll(Colors.white),
              backgroundColor: material.MaterialStatePropertyAll(Color.fromARGB(255, 22, 42, 94)) ),
                      child:  Stack(children: [
                      Row(children: [SizedBox.square(child: Image.asset('assets/Delete.png',color: Comcol.dbl,),),
                      ],)],),
                      onPressed: () {
                       _showDeleteDialog(record);
                      },
                    ),
                  const SizedBox(width: 20,)
                  ],
                ),
                ],),
                
              )); 
            },
          ),
        ),
      ],
    ))
    ;
  }
  
  Future<void> audioUp(File audioz) async {
    final url = Uri.parse("http://Gubat.local/api/upload_audio2.php");

    try {
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('audio', audioz.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final message = jsonDecode(responseData);
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return material.AlertDialog(
              title: const Text('File'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("File name: ${message['filename']}"),
                ],
              ),
              actions: [
                material.TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Nice'),
                ),
              ],
            );
          },
        );
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return material.AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to upload audio file.'),
              actions: [
                material.TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return material.AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred during the upload process.'),
            actions: [
              material.TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      File file = File(platformFile.path!);
      audio = file;
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return material.AlertDialog(
            title: const Text('File'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("File path: ${file.path}"),
              ],
            ),
            actions: [
              material.TextButton(
                onPressed: () {
                  audioUp(audio);
                  Navigator.pop(context);
                },
                child: const Text('Upload'),
              ),
            ],
          );
        },
      );
    }
  }

  // The player
  
Future playAudio(String fileName) async {
final player = AudioPlayer();
    await player.play(UrlSource('http://Gubat.local/api/audiopre.php?file_name=$fileName'));
  }
}