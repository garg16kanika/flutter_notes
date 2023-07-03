import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/screens/note_editor.dart';
import 'package:notes_app/screens/note_reader.dart';
import 'package:notes_app/style/app_style.dart';
import 'package:notes_app/widgets/notes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        title: Text('Notes App'),
        elevation: 0.0,
        backgroundColor: AppStyle.bgColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('notes').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map<Widget>(
                            (note) => notesCard(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return NoteReader(doc: note);
                                }),
                              );
                            }, note),
                          )
                          .toList(),
                    );
                  }
                  return Text(
                    'No data yet',
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          );
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
