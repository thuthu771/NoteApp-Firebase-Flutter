//import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:firebase_noteapp/FB/procolor.dart';
import 'package:firebase_noteapp/widgets/colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fbaseservices.dart';

class Update extends StatefulWidget {
  final dynamic id;
  final String message;
  final int currentindex;

  const Update(
      {super.key,
      required this.message,
      required this.id,
      required this.currentindex});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  Fbase fbase = Fbase();
  TextEditingController titlecontroller = TextEditingController();
  @override
  void dispose() {
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context);
    titlecontroller.text = widget.message;

    return Scaffold(
      backgroundColor: themeData.listofcolors[themeData.selectdIndex],
      appBar: AppBar(),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Title",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: titlecontroller,
            ),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ColorPicker(themeData: themeData);
                  },
                );
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: const Center(child: Text("show colors")),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String title = titlecontroller.text;
          fbase.updatedata(widget.id, title, themeData.selectdIndex);
          titlecontroller.clear();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
