import 'package:notepad_app/base/base_controller.dart';
import 'package:notepad_app/data/model/notepad_model.dart';

class NotepadController extends BaseController<NotepadModel> {
  @override
  Future<NotepadModel> create(NotepadModel baseModel) async {
    // final notepad = baseModel as NotepadModel;
    final db = await notepadDB.database;
    final id = await db.insert(tableNotes, baseModel.toJson());
    return baseModel.copy(id: id);
  }

  @override
  Future<List<NotepadModel>> getAllDatas() async {
    final db = await notepadDB.database;
    final result = await db.query(tableNotes);
    return result.map((json) => NotepadModel.fromJson(json)).toList();
  }

  @override
  Future<NotepadModel> getDataById(int id) async {
    final db = await notepadDB.database;
    final result = await db
        .query(tableNotes, where: '${NoteFields.id} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return NotepadModel.fromJson(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> deleteDataById(int id) async {
    final db = await notepadDB.database;
    return await db
        .delete(tableNotes, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateData(NotepadModel baseModel) async {
    // final notepad = ;
    final db = await notepadDB.database;
    return await db.update(tableNotes, baseModel.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [baseModel.id]);
  }
}
