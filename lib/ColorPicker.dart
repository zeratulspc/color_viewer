import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final Function colorPicked;
  ColorPickerDialog({required this.initialColor, required this.colorPicked});
  _ColorPickerDialogState createState()=>_ColorPickerDialogState(initialColor: initialColor);
}

class _ColorPickerDialogState extends State<ColorPickerDialog>{
  Color initialColor = Colors.white;
  get complimentaryColor => Color.fromARGB(
      initialColor.alpha,
      255 - initialColor.red,
      255 - initialColor.green,
      255 - initialColor.blue,
  );
  _ColorPickerDialogState({required this.initialColor});
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    setState(() {
      controller.text = initialColor.value.toRadixString(16).toUpperCase();
    });
    controller.addListener(() {
      String src = controller.text;
      if(src.length==8) {
        int? v = int.tryParse(src,radix: 16);
        if(v!=null) {
          setState(() {
            initialColor = Color(v);
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text("Set Color"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height/5,
              margin: EdgeInsets.only(bottom: 15.0),
              decoration: ShapeDecoration(
                color: initialColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                )
              ),
            ),
            Container(
              height: 64,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 8,
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: "",
                        labelText: '${initialColor.value.toRadixString(16).toUpperCase()}',
                      )
                    ),
                  ),
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      Navigator.pop(context);
                      widget.colorPicked(initialColor);
                    },
                    splashColor: Colors.white,
                    child: Container(
                      height: 64,
                      width: 64,
                      margin: EdgeInsets.symmetric(horizontal: 4,vertical: 2.5),
                      decoration: ShapeDecoration(
                        color: complimentaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          child: Icon(
                            Icons.edit,
                            size: 32,
                            color: initialColor,
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}