
import 'package:adminsite/api_php.dart';
import 'package:flutter/material.dart';
import 'style/customz.dart';
import 'style/colorpallete.dart';
class DashB extends StatefulWidget {
  const DashB({super.key});

  @override
  State<DashB> createState() => _DashBState();
}
  

Future<String> ez = FetchApi.quize();

Future<String> tp = FetchApi.trapan();
Future<String> use= FetchApi.userc();
Future<String> ia= FetchApi.ailo();
Future<String> pa= FetchApi.apan();

class _DashBState extends State<DashB> {
  @override
  Widget build(BuildContext context) {


    return
    Container(
      decoration: const BoxDecoration(color:Comcol.dbl1),
      
      child: RefreshIndicator(
  onRefresh: () async {
    
    setState(() {
      ia= FetchApi.ailo();
      ez = FetchApi.quize();
      tp = FetchApi.trapan();
      use= FetchApi.userc();
      pa= FetchApi.apan();
    });
  },
  child:
  
   SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Align(
              alignment: Alignment.topRight,
              child: 
              Column(children: [ ElevatedButton(
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(color: Comcol.dbl, width: 0.5)),
                backgroundColor: MaterialStatePropertyAll(Comcol.db1)),
                onPressed: () {
    setState(() {

      ez = FetchApi.quize();
      tp = FetchApi.trapan();
      use= FetchApi.userc();
      ia= FetchApi.ailo();
      pa= FetchApi.apan();
    });
  }, child: const Text("refresh",style: TextStyle(color: Comcol.dbl),)),const SizedBox(width: 40,)],)
               ),
               const SizedBox(height: 20,),
  Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(border: BorderDirectional(top: BorderSide(width: 0.5,color: Colors.white))),
    child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              const Text("User",style: TextStyle(fontSize: 40,fontFamily: 'Kadwa',color: Colors.white),),
                const SizedBox(width: 135,),
                MyCustomContainer(
                  widths:175,
                  heights: 
                  100,
                  di: use,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Usersl.png",labelText: "Users", )
              ],
            ),),
             Container(
                  padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(border: 
              BorderDirectional(top: BorderSide(width: 0.5,color: Colors.white))),
              child:Row(
              children: [
        const Text("Translation",style: TextStyle(fontSize: 40,fontFamily: 'Kadwa',color: Colors.white),), 
              const SizedBox(width: 5,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               MyCustomContainer(widths:175,
                  heights: 100,di: tp,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/translatel.png",labelText: "Translation",),
                const SizedBox(width: 20,),
              ],),],)), 
           Container(
                  padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(border: 
              BorderDirectional(top: BorderSide(width: 0.5,color: Colors.white))),
              child:Row(
              children: [
           const Text("Audio",style: TextStyle(fontSize: 40,fontFamily: 'Kadwa',color: Colors.white),),
              
              const SizedBox(width: 105,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 MyCustomContainer(widths:175,
                  heights:100,di: pa,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Audiol.png",labelText: "Pangasinan",),
                const SizedBox(width: 20,),
              MyCustomContainer(widths:175,
                  heights:100,di: ia,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Audiol.png",labelText: "Ilocano",),
                const SizedBox(width: 20,),
              ],),],)), 
            Container(
                  padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(border: 
              BorderDirectional(top: BorderSide(width: 0.5,color: Colors.white))),
              child:Row(
              children: [   const Text("Quiz",style: TextStyle(fontSize: 40,fontFamily: 'Kadwa',color: Colors.white),), 
             const SizedBox(width: 135,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyCustomContainer(widths:175,
                  heights:100,di: ez,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Quizl.png",labelText: "Quiz",),
              ]),],)), 
            Container( 
                  padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(border:BorderDirectional(top: BorderSide(width: 0.5,color: Colors.white))),
              child:Row(
              children: [ 
          const Text("Dictionary",style: TextStyle(fontSize: 40,fontFamily: 'Kadwa',color: Colors.white),), 
              
              const SizedBox(width: 20,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 MyCustomContainer(widths:175,
                  heights: 100,di: tp,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Dictionaryl.png",labelText: "Pangasinan",),
                const SizedBox(width: 20,),
               MyCustomContainer(widths:175,
                  heights: 100,di: tp,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Dictionaryl.png",labelText: "Ilocano",),
                const SizedBox(width: 20,),
               MyCustomContainer(widths:175,
                  heights:100,di: tp,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Dictionaryl.png",labelText: "Tagalog",),
                const SizedBox(width: 20,),
            MyCustomContainer(widths:175,
                  heights:100,di: tp,backgroundColor: Co.user, textColor: Colors.white,imagePath: "assets/Dictionaryl.png",labelText: "English",),
            ],),],)),
          ],
        ),
      ),
    ), 
  );
  }
}
