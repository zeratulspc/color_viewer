import 'package:color_viewer/ColorPicker.dart';
import 'package:flutter/material.dart';

class ColorViewerPage extends StatefulWidget {
  ColorViewerPage({Key? key}) : super(key: key);
  @override
  _ColorViewerPageState createState() => _ColorViewerPageState();
}

class _ColorViewerPageState extends State<ColorViewerPage> {

  Color screenColor = Colors.white;
  get complimentaryColor => Color.fromARGB(
      screenColor.alpha,
      255 - screenColor.red,
      255 - screenColor.green,
      255 - screenColor.blue
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: screenColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: complimentaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ColorPickerDialog(initialColor: screenColor,colorPicked: (color){
                  setState(() {
                    screenColor = color;
                  });
                },
              );
            }
          );
        },
        tooltip: 'Change Color',
        child: Icon(Icons.edit, color: screenColor,),
      ),
    );
  }
}
