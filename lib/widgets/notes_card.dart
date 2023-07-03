import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

Widget notesCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc.data()!.toString().contains('color_id')
            ? doc.get('color_id')
            : 3],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc.data()!.toString().contains('note_title')
                ? doc.get('note_title')
                : 'no note title',
            style: AppStyle.mainTitle,
          ),
          Text(
            doc.data()!.toString().contains('creation_date')
                ? doc.get('creation_date')
                : 'no date',
            style: AppStyle.dateTitle,
          ),
          Text(
            doc.data()!.toString().contains('note_content')
                ? doc.get('note_content')
                : 'no content',
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
