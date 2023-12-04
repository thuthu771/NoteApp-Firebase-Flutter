//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_noteapp/FB/fbaseservices.dart';
import 'package:firebase_noteapp/FB/procolor.dart';
import 'package:firebase_noteapp/FB/updatepage.dart';
import 'package:firebase_noteapp/addnotes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Fbase fbase = Fbase();
  bool isGridview = true;
  void changeGrid() {
    isGridview = !isGridview;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  changeGrid();
                });
              },
              icon: !isGridview
                  ? Icon(Icons.grid_on)
                  : Icon(Icons.line_style_rounded)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const EditPage(),
          ));
        },
        child: const Icon(Icons.notes_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("noteapp")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("notes")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return isGridview
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                snapshot.data!.docs[index];
                            var id = snapshot.data!.docs[index].id;

                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Dismissible(
                                key: ValueKey(id),
                                background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,

                                    // width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 237, 196, 210),
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("confirm"),
                                          content: const Text(" are you sure?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text("DELETE")),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text("CANCEL")),
                                          ],
                                        );
                                      });
                                },
                                onDismissed: (DismissDirection direction) {
                                  fbase.deletedata(id);
                                  print("dis $direction");
                                },
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: themeData
                                          .listofcolors[document['colorindex']],
                                      border: Border.all()),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Update(
                                                        id: id,
                                                        message:
                                                            document["notes"],
                                                        currentindex: document[
                                                            'colorindex'],
                                                      ),
                                                    ));
                                                  },
                                                  child: const Icon(Icons.edit),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    fbase.deletedata(id);
                                                  },
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(document['notes'])),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                snapshot.data!.docs[index];
                            var id = snapshot.data!.docs[index].id;

                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Dismissible(
                                key: ValueKey(id),
                                background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,

                                    // width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 237, 196, 210),
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("confirm"),
                                          content: const Text(" are you sure?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text("DELETE")),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text("CANCEL")),
                                          ],
                                        );
                                      });
                                },
                                onDismissed: (DismissDirection direction) {
                                  fbase.deletedata(id);
                                  print("dis $direction");
                                },
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: themeData
                                          .listofcolors[document['colorindex']],
                                      border: Border.all()),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Update(
                                                        id: id,
                                                        message:
                                                            document["notes"],
                                                        currentindex: document[
                                                            'colorindex'],
                                                      ),
                                                    ));
                                                  },
                                                  child: const Icon(Icons.edit),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    fbase.deletedata(id);
                                                  },
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(document['notes'])),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
