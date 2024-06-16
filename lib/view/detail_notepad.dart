import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad_app/base/base_model.dart';
import 'package:notepad_app/base/base_state.dart';
import 'package:notepad_app/base/base_stateful_widget.dart';
import 'package:notepad_app/controller/notepad_controller.dart';
import 'package:notepad_app/controller/status_controller.dart';
import 'package:notepad_app/data/model/notepad_model.dart';
import 'package:notepad_app/data/model/status_model.dart';
import 'package:notepad_app/view/add_and_edit.dart';

class DetailNotepad extends BaseStatefulWidget {
  const DetailNotepad({super.key, required this.id});
  final int id;

  @override
  BaseState<DetailNotepad> createState() => _DetailNotepadState(this.id);
}

class _DetailNotepadState extends BaseState<DetailNotepad> {
  _DetailNotepadState(this.id);
  final int id;
  late NotepadModel _notepad = BaseModel as NotepadModel;
  var _isLoading = false;
  final NotepadController _notepadController = NotepadController();
  final StatusController _statusController = StatusController();
  late StatusModel _status;

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });
    _notepad = (await baseController.getDataById(id)) as NotepadModel;
    _status = (await _statusController.getDataById(_notepad.statusId!.toInt()));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    baseController = NotepadController();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[_editButton(), _deleteButton(), SizedBox(width: 16)],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Memuat...")
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(9),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // color: _notepad.statusId == 1 ? Colors.yellow : Colors.green,
                  child: Text(
                    _status.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: _notepad.statusId == 1
                              ? [Colors.indigo, Colors.grey, Colors.amberAccent]
                              : [Colors.green, Colors.blue]),
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _notepad.title.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(DateFormat.yMMMd().format(_notepad.createdTime)),
                const SizedBox(height: 8),
                Text(_notepad.description, style: TextStyle(fontSize: 18))
              ],
            ),
    );
  }

  Widget _editButton() {
    return IconButton(
        onPressed: () async {
          if (_isLoading) return;
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAndEdit(notepad: _notepad)));
          _refreshNotes();
        },
        icon: const Icon(Icons.edit_outlined));
  }

  Widget _deleteButton() {
    return IconButton(
        onPressed: () async {
          if (_isLoading) return;
          await _notepadController.deleteDataById(id);
          Navigator.of(context).pop();
          _refreshNotes();
        },
        icon: const Icon(Icons.delete_outline));
  }
}
