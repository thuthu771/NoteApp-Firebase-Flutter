import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_noteapp/FB/updatepage.dart';

class Fbase {
  // final CollectionReference notesdata =
  //     FirebaseFirestore.instance.collection("notes");

  // //add note
  // Future<void> adddata(String titledata) async {
  //   notesdata.add({"notes": titledata, "timestamp": Timestamp.now()});
  // }

  // //to get notes
  // Stream<QuerySnapshot> getnotes() {
  //   final notestream =
  //       notesdata.orderBy("timestamp", descending: true).snapshots();
  //   return notestream;
  // }

  // //to edit
  // Future<void> editdata(dynamic id, titledata) async {
  //   notesdata
  //       .doc(id)
  //       .update({"notes": titledata, "timestamp": Timestamp.now()});
  // }

  // //to delete
  // Future<void> deletedata(dynamic id) async {
  //   notesdata.doc(id).delete();
  // }
  Future<void> adddata(String titledata, int colorindex) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .add({
      "notes": titledata,
      'colorindex': colorindex,
      "timestamp": Timestamp.now()
    });
  }

  Future<void> updatedata(dynamic id, String titledata, int colorindex) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(id)
        .update({
      "notes": titledata,
      'colorindex': colorindex,
      "timestamp": Timestamp.now()
    });
  }

  Future<void> deletedata(dynamic id) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(id)
        .delete();
  }
}
