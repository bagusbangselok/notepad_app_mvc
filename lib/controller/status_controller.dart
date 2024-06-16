import 'package:notepad_app/base/base_controller.dart';
import 'package:notepad_app/base/base_model.dart';
import 'package:notepad_app/data/model/status_model.dart';

class StatusController extends BaseController<StatusModel> {
  @override
  Future<StatusModel> create(StatusModel baseModel) async {
    // final status = baseModel as StatusModel;
    final db = await notepadDB.database;
    final id = await db.insert(tableStatus, baseModel.toJson());
    return baseModel.copy(id: id);
  }

  @override
  Future<List<StatusModel>> getAllDatas() async {
    final db = await notepadDB.database;
    final result = await db.query(tableStatus);
    return result.map((json) => StatusModel.fromJson(json)).toList();
  }

  @override
  Future<StatusModel> getDataById(int id) async {
    final db = await notepadDB.database;
    final result = await db
        .query(tableStatus, where: '${StatusFields.id} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return StatusModel.fromJson(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> deleteDataById(int id) async {
    final db = await notepadDB.database;
    return await db
        .delete(tableStatus, where: '${StatusFields.id} = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateData(BaseModel baseModel) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
