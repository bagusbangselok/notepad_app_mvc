import 'package:flutter/material.dart';
import 'package:notepad_app/base/base_controller.dart';
import 'package:notepad_app/base/base_model.dart';
import 'package:notepad_app/base/base_state.dart';
import 'package:notepad_app/base/base_stateful_widget.dart';
import 'package:notepad_app/controller/notepad_controller.dart';
import 'package:notepad_app/controller/status_controller.dart';
import 'package:notepad_app/data/model/notepad_model.dart';
import 'package:notepad_app/data/model/status_model.dart';
import 'package:notepad_app/view/main_notepad.dart';
import 'package:notepad_app/widgets/note_form.dart';

class AddAndEdit extends BaseStatefulWidget {
  const AddAndEdit({super.key, this.notepad});
  final NotepadModel? notepad;

  @override
  BaseState<AddAndEdit> createState() => _AddAndEditState(this.notepad);
}

class _AddAndEditState extends BaseState<AddAndEdit> {
  _AddAndEditState(this.notepad);
  final NotepadModel? notepad;
  late final List<StatusModel> statusModel;
  late int? _id;
  late bool _isImportant;
  late int _number;
  late String _title;
  late String _description;
  late int _statusId;
  final _formKey = GlobalKey<FormState>();
  var _isUpdate = false;
  bool isFormNotEmpty = false;
  bool isTitleNotEmpty = false;
  bool isDescriptionNotEmpty = false;
  late final StatusController _statusController;
  String hintText = "Pilih status";

  Future<void> cekData() async {
    statusModel = await _statusController.getAllDatas();
    print(statusModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cekData();
  }

  @override
  void initState() {
    super.initState();
    baseController = NotepadController();
    _statusController = StatusController();
    _id = notepad?.id;
    _isImportant = notepad?.isImportant ?? false;
    _number = notepad?.number ?? 0;
    _title = notepad?.title ?? '';
    _description = notepad?.description ?? '';
    _isUpdate = notepad != null;
    _statusId = notepad?.statusId ?? 1;
    isTitleNotEmpty = false;
    isDescriptionNotEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    print("title: ${isTitleNotEmpty}");
    print("desc: ${isDescriptionNotEmpty}");
    print("Form: ${isFormNotEmpty}");
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: isFormNotEmpty == false
                ? () {
                    null;
                  }
                : () async {
                    _id == null ? await _addNote() : await _updateNote();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MainNotepad()));
                  },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: isFormNotEmpty == false ? Colors.grey : null,
                  ),
                  SizedBox(width: 3),
                  Text("Simpan",
                      style: TextStyle(
                          fontSize: 15,
                          color: isFormNotEmpty == false ? Colors.grey : null)),
                ],
              ),
            ),
          )
        ],
        title: Text(
          _isUpdate ? "Edit" : "Tambah",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: NoteForm(
              isImportant: _isImportant,
              number: _number,
              title: _title,
              description: _description,
              dropdownFutureBuilder: FutureBuilder<List<StatusModel>>(
                future: _statusController.getAllDatas(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<StatusModel>> statusItem) {
                  return DropdownButtonFormField<String>(
                    value: _statusId.toString(),
                    // hint: Text(hintText),
                    isExpanded: true,
                    items: statusItem.data?.map((status) {
                      return DropdownMenuItem<String>(
                        value: status.id.toString(),
                        child: Text("${status.status}  ${status.id}"),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      int value = int.parse(newValue!);
                      _statusId = value;
                    },
                  );
                },
              ),
              // future: _statusController.getAllDatas(),
              // dropdownBuilder: (BuildContext context, AsyncSnapshot statusItem) {
              //   return DropdownButtonFormField(
              //     items: statusItem.data?.map((status){
              //     return DropdownMenuItem(
              //       value: status.id.toString(),
              //       child: Text(status.name),
              //     );
              //     }).toList(),
              //     onChanged: (String? newValue){},
              //   );
              // },
              onChangeIsImportant: (value) {
                setState(() {
                  _isImportant = value;
                  print("important $value");
                });
              },
              onChangeNumber: (value) {
                setState(() {
                  _number = value;
                });
              },
              onChangeTitle: (value) {
                setState(() {
                  _title = value;
                  if (value == null || value.isEmpty || value == '') {
                    isTitleNotEmpty = false;
                    isFormNotEmpty = false;
                  } else if (value != null || value.isNotEmpty || value == '') {
                    isTitleNotEmpty = true;
                    if (isDescriptionNotEmpty) {
                      isFormNotEmpty = true;
                    }
                  }
                });
              },
              onChangeDescription: (value) {
                setState(() {
                  _description = value;
                  if (value == null || value.isEmpty || value == '') {
                    isDescriptionNotEmpty = false;
                    isFormNotEmpty = false;
                  } else if (value != null || value.isNotEmpty) {
                    isDescriptionNotEmpty = true;
                    if (isTitleNotEmpty) {
                      isFormNotEmpty = true;
                    }
                  }
                });
              }),
        ),
      ),
    );
  }

  Future<void> _addNote() async {
    final notepad = NotepadModel(
        isImportant: _isImportant,
        number: _number,
        title: _title,
        description: _description,
        createdTime: DateTime.now(),
        statusId: _statusId);
    await baseController.create(notepad as BaseModel);
  }

  Future<void> _updateNote() async {
    final updateNotepad = NotepadModel(
        id: notepad?.id,
        isImportant: _isImportant,
        number: _number,
        title: _title,
        description: _description,
        createdTime: DateTime.now(),
        statusId: _statusId) as BaseModel;
    await baseController.updateData(updateNotepad);
  }
}
