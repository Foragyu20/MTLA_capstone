import 'package:flutter/material.dart';

class MyCustomContainer extends StatelessWidget {
  final Future<String> di;
  final Color backgroundColor;
  final Color textColor;
  final String imagePath;
  final String labelText;
  final double widths;
  final double heights;

  const MyCustomContainer({super.key, 
    required this.di,
    required this.heights,
    required this.widths,
    this.backgroundColor = const Color.fromARGB(255, 98, 221, 96),
    this.textColor = Colors.white,
    this.imagePath = "assets/Dictionaryl.png",
    this.labelText = "Ilocano",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widths,
      height: heights,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Flexible(child: Text(
                  labelText,
                  style: TextStyle(fontSize: 20, fontFamily: 'Kadwa', color: textColor),
                ), ),
          FutureBuilder<String>(
                  future: di,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        snapshot.data ?? '',
                        style: TextStyle(fontSize: 15, fontFamily: 'Kadwa', color: textColor),
                      );
                    }
                  },
                ),
                
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child:Image.asset(imagePath, scale: 2.5),
          ),
        ],
      ),
    );
  }
}
