import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

class NoteReader extends StatefulWidget {
  const NoteReader({required this.doc, super.key});
  final QueryDocumentSnapshot doc;
  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc.data()!.toString().contains('color_id')
        ? widget.doc.get('color_id')
        : 3;
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.doc.data()!.toString().contains('note_title')
              ? widget.doc.get('note_title')
              : 'no note title',
        ),
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc.data()!.toString().contains('creation_date')
                  ? widget.doc.get('creation_date')
                  : 'no date',
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.doc.data()!.toString().contains('note_content')
                  ? widget.doc.get('note_content')
                  : 'no content',
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
