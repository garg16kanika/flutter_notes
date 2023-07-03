import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController mainContentController = TextEditingController();
  final date = DateTime.now().toString();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    mainContentController.dispose();
  }
//changes have to made

  @override
  Widget build(BuildContext context) {
    int colorId = Random().nextInt(AppStyle.cardsColor.length);
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        title: Text('Create a new Note'),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Add a title', border: InputBorder.none),
            style: AppStyle.mainTitle,
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            date,
            style: AppStyle.dateTitle,
          ),
          SizedBox(
            height: 28,
          ),
          TextField(
            controller: mainContentController,
            decoration: InputDecoration(
                hintText: 'Note content', border: InputBorder.none),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: AppStyle.mainContent,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('notes')
              .add({
                'note_title': titleController.text,
                'note_content': mainContentController.text,
                'color_id': colorId,
                'creation_date': date,
              })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                (err) => SnackBar(
                  content: Text(
                    'Failed to add notes due to $err',
                    style: AppStyle.mainContent,
                  ),
                ),
              );
        },
        child: Icon(
          Icons.save,
          color: AppStyle.accentColor,
        ),
      ),
    );
  }
}
