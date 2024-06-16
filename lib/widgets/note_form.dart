import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteForm extends StatelessWidget {
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;
  final Widget dropdownFutureBuilder;
  // final Future<Object?>? future;
  // final Widget Function(BuildContext, AsyncSnapshot<Object?>) dropdownBuilder;
  const NoteForm(
      {super.key,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.onChangeIsImportant,
      required this.onChangeNumber,
      required this.onChangeTitle,
      // required this.future,
      // required this.dropdownBuilder,
      required this.dropdownFutureBuilder,
      required this.onChangeDescription});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Switch(
                  value: isImportant,
                  onChanged: onChangeIsImportant,
                  activeColor: Colors.green,
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        Text("0       1       2       3       4       5", style: TextStyle(fontSize: 20),),
                        Slider(
                          activeColor: Colors.green.shade200,
                            value: number.toDouble(),
                            min: 0,
                            max: 5,
                            divisions: 5,
                            label: "Tingkat kepentingan",
                            thumbColor: Colors.green,
                            onChanged: (value) => onChangeNumber(value.toInt())),
                      ],
                    ))
              ],
            ),
            dropdownFutureBuilder,
            // FutureBuilder<Object?>(
            //   future: future,
            //   builder: dropdownBuilder
            // ),
            _titleFormWidget(),
            const SizedBox(height: 8),
            _descriptionFormWidget()
          ],
        ),
      ),
    );
  }

  Widget _titleFormWidget() {
    return TextFormField(
      maxLines: null,
      initialValue: title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      textCapitalization: TextCapitalization.characters,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Judul",
          hintStyle: TextStyle(color: Colors.grey)),
      onChanged: onChangeTitle,
      validator: (title) {
        if (title == null || title.isEmpty) {
          return "Judul tidak boleh kosong";
        }
      },
    );
  }

  Widget _descriptionFormWidget() {
    return TextFormField(
      maxLines: null,
      initialValue: description,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Deskripsi",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      onChanged: onChangeDescription,
      validator: (title) {
        if (title == null || title.isEmpty) {
          return "Isi tidak boleh kosong";
        }
      },
    );
  }
}
