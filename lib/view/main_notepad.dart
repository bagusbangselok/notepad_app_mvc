import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad_app/base/base_state.dart';
import 'package:notepad_app/base/base_stateful_widget.dart';
import 'package:notepad_app/controller/notepad_controller.dart';
import 'package:notepad_app/controller/status_controller.dart';
import 'package:notepad_app/controller/theme_controller.dart';
import 'package:notepad_app/data/model/notepad_model.dart';
import 'package:notepad_app/data/model/status_model.dart';
import 'package:notepad_app/view/add_and_edit.dart';
import 'package:notepad_app/view/detail_notepad.dart';
import 'package:notepad_app/widgets/exit_confirm.dart';
import 'package:notepad_app/widgets/note_card.dart';
import 'package:provider/provider.dart';

class MainNotepad extends BaseStatefulWidget {
  const MainNotepad({super.key});

  @override
  BaseState<MainNotepad> createState() => _MainNotepadState();
}

class _MainNotepadState extends BaseState<MainNotepad> {
  late List<NotepadModel> _notepad;
  var _isLoading = false;
  final ThemeController themeController = ThemeController();
  late final StatusController _statusController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshNotes();
    _addStatus();
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
    _notepad = [];
    super.baseController = NotepadController();
    _statusController = StatusController();
    _isLoading = false;
  }

  Future<void> _addStatus() async {
    List<StatusModel> _status = await _statusController.getAllDatas();
    print('Status = ${_status.isEmpty}');
    if (_status.isEmpty != true) {
      print("ada");
    } else {
      print("tidak ada");
      _statusController.create(
          StatusModel(status: 'In-progress', createdTime: DateTime.now()));

      _statusController.create(
          StatusModel(status: 'Completed', createdTime: DateTime.now()));
    }
  }

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });
    _notepad = (await baseController.getAllDatas()) as List<NotepadModel>;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() {
          showDialog(
              context: context,
              builder: (context) {
                return ExitConfirm();
              });
          return true;
        });
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Notepad",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Consumer<ThemeController>(
                  builder: (context, themeController, child) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      themeController.toggleTheme();
                    });
                  },
                  child: themeController.isDark == true
                      ? const Icon(Icons.nights_stay)
                      : const Icon(Icons.sunny),
                );
              }),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    _refreshNotes();
                  });
                },
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 16)
            ]),
        body: _isLoading
            ? const Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      "Memuat...",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              )
            : _notepad.isEmpty
                ? Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 14),
                    child: const Text(
                      "Note kosong",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: _notepad.length,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      final notepad = _notepad[index];
                      return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DetailNotepad(id: notepad.id!)));
                            _refreshNotes();
                          },
                          child: NoteCard(notepad: notepad, index: index));
                    }),
        floatingActionButton: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            label: const Text("Tambah catatan",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            isExtended: true,
            backgroundColor: Colors.white54,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              // final notepad = NotepadModel(
              //     isImportant: false,
              //     number: 1,
              //     title: "Tes aja",
              //     description: "Deskripsi dari note",
              //     createdTime: DateTime.now()
              // );
              // await NotepadController().create(notepad);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddAndEdit()));
              _refreshNotes();
            }),
      ),
    );
  }
}
