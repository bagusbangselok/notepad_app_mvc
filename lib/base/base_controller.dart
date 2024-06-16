import 'package:notepad_app/base/base_model.dart';
import 'package:notepad_app/data/database/notepad_database.dart';

abstract class BaseController<T extends BaseModel> {
  NotepadDatabase notepadDB = NotepadDatabase();

  Future<T> create(T baseModel);
  Future<List<T>> getAllDatas();
  Future<T> getDataById(int id);
  Future<int> updateData(T baseModel);
  Future<int> deleteDataById(int id);
}
