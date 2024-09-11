import 'package:adminsite/style/colorpallete.dart';

import 'api_php.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter/material.dart' as material;

class User extends StatefulWidget {
  const User({super.key});

  @override
  UserState createState() => UserState();
}

class UserState extends State<User> {
  List<Map<String, dynamic>> records = [];
String gfz ='Expired';
 DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetchRecords();
  }
Future<String> theExpired(String expire, String word) async {
  DateTime now = DateTime.now();
  DateTime expirationDate = DateTime.parse(expire);
  Duration difference = expirationDate.difference(now);
  
  if (expirationDate.isBefore(now)) {
    // Perform automatic action for expired case
    _performAutomaticAction(word);
    return 'Expired';
  } else if (difference.inDays <= 10) {
    _performAutomaticAction1(word);
    return 'Warning';
  } else if (expirationDate.isAtSameMomentAs(now)) {
    // Handle expires today case
    return 'Expires Today';
  } else {
    // Handle not expired case
    return 'Not Expired';
  }
}
Future<void> _performAutomaticAction1(String word) async {
  final response = await http.get(
    Uri.parse('http://localhost/api/automsg/autoload.php?email=$word'),);

  if (response.statusCode == 200) {
    // Successful response
    print("Ok-${response.statusCode}");
  } else {
    // Handle HTTP error
    print("Nope-${response.statusCode}");
  }
}

Future<void> _performAutomaticAction(String word) async {
  final response = await http.get(
    Uri.parse('http://localhost/api/automsg/autoload1.php?email=$word'),);

  if (response.statusCode == 200) {
    // Successful response
    print("Ok-${response.statusCode}");
  } else {
    // Handle HTTP error
    print("Nope-${response.statusCode}");
  }
}


  Future<void> fetchRecords() async {
    final response = await http.get(Uri.parse(Api.users));

    if (response.statusCode == 200) {
      setState(() {
        records = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
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
          color: const Color.fromARGB(255, 22, 30, 69),
          child:
          const ListTile(title: Text("User",style: TextStyle(fontSize: 40,fontFamily: "Kadwa",color: Comcol.dbl),),  ),
          ),
        Container(
         decoration: BoxDecoration(
          color:const Color.fromARGB(255, 21, 41, 93),
          border: Border.all(color: Colors.white,width: 1)
           ),
          child:  
          const ListTile(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      SizedBox(width: 340,child:Text('Users',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
        SizedBox(width: 140,child:Text('Recent Log',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
        SizedBox(width: 140,child:Text('Expire',
      style: TextStyle(color: Colors.white,  fontSize: 20,fontFamily: 'Kadwa'),), ),
      
      
      ],),
      
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
                      width: 340,
                      child: Text(record['username'],
                      style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl)),),
                      SizedBox(
                      width: 140,
                      child: Text(record['recent_log'],
                      style: const TextStyle(fontSize: 20,fontFamily: 'Kadwa',color: Comcol.dbl)),),
                      SizedBox(
                      width: 140,
                      child: FutureBuilder<String>(
                  future: theExpired(record['expire'],record['username']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const material.CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        snapshot.data ?? '',
                        style: const TextStyle(fontSize: 20, fontFamily: 'Kadwa',color: Comcol.dbl),
                      );
                    }
                  },
                ),
                      )
                
                  
                ],),
                
              )); 
            },
          ),
        ),
      ],
    ))
    ;
  }
}