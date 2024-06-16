import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:notepad_app/data/model/notepad_model.dart';

final _cardColor = [
  Colors.amberAccent,
  Colors.lightBlueAccent,
  Colors.lightGreenAccent,
  Colors.cyanAccent,
  Colors.tealAccent
];

class NoteCard extends StatelessWidget {
  final NotepadModel notepad;
  final int index;
  const NoteCard({super.key, required this.notepad, required this.index});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().add_jms().format(notepad.createdTime);
    final minHeigth = _getMinHeight(index);
    final color = _cardColor[index % _cardColor.length];

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeigth),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(child: Text(time, style: TextStyle(color: Colors.grey.shade700))),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: notepad.statusId == 1 ? [
                        Colors.amberAccent,
                        Colors.indigo
                      ] : [
                        Colors.green,
                        Colors.blue
                      ]
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid
                    )
                  ),
                  child: Icon(
                    notepad.statusId == 1 ? Icons.access_time : Icons.check,
                    color: Colors.white,
                    size: 26,
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              notepad.title.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text.rich(
                overflow: TextOverflow.clip,
                maxLines: 2,
                TextSpan(
                    text: notepad.description,
                    style: TextStyle(color: Colors.black, fontSize: 16)))
          ],
        ),
      ),
    );
  }

  double _getMinHeight(int index) {
    switch (index % 4) {
      case 0:
      case 3:
        return 100;
      case 1:
      case 2:
        return 150;
      default:
        return 100;
    }
  }
}
