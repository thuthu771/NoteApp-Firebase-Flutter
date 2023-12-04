import 'package:firebase_noteapp/FB/fbaseservices.dart';
import 'package:firebase_noteapp/FB/ksackbar.dart';
import 'package:firebase_noteapp/FB/procolor.dart';
//import 'package:firebase_noteapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/colorpicker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titlecontroller = TextEditingController();
  Fbase fbase = Fbase();
  @override
  void dispose() {
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context, listen: true);
    // String title = titlecontroller.text;
    return WillPopScope(
      onWillPop: () async {
        if (titlecontroller.text == '') {
          ScaffoldMessenger.of(context).showSnackBar(titlesnackbar);
        } else {
          String title = titlecontroller.text;
          fbase.adddata(title, themeData.selectdIndex);
          titlecontroller.clear();

          ScaffoldMessenger.of(context).showSnackBar(savesnackbar);
        }
        return true;
      },
      child: Scaffold(
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
            if (titlecontroller.text == '') {
              ScaffoldMessenger.of(context).showSnackBar(titlesnackbar);
            } else {
              String title = titlecontroller.text;
              fbase.adddata(title, themeData.selectdIndex);
              titlecontroller.clear();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(savesnackbar);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
