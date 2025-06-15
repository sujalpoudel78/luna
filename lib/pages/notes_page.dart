import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luna/pages/theme.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _addNotesController = TextEditingController();

  List noteData = ['placeholder'];

  void addNote() {
    final text = _addNotesController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        noteData.add(text);
        _addNotesController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NOTES')),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: noteData.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(noteData[index]),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            noteData.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppTheme.borderColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: ListTile(
                      title: Text(
                        noteData[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppTheme.dividerColor,
                  thickness: 1,
                  height: 9,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.borderColor),
              borderRadius: BorderRadius.circular(27),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleMedium,
                    controller: _addNotesController,
                    decoration: InputDecoration(
                      hintText: 'Enter note',
                      hintStyle: TextStyle(
                        color: AppTheme.borderColor,
                        fontFamily: 'Fredoka',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 9),
                IconButton(
                  onPressed: () {
                    addNote();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
