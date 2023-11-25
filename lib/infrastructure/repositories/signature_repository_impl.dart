import 'package:calendar_app/infrastructure/database/database_helper.dart';

import '../model/signature_model.dart';

class SignatureRepositoryImpl {
  final dataBase = DataBaseHelper.instance.db;

  Future<List<SignatureModel>> getAll() async {
    final data = await dataBase.query(SignatureModel.nameClass);
    return data.map((e) => SignatureModel.fromMap(e)).toList();
  }

  Future<int> insert(SignatureModel signature) async {
    return await dataBase.insert(SignatureModel.nameClass, {'name': signature.name, 'teacherId': signature.teacherId});
  }

  Future<void> update(SignatureModel signature) async {
    await dataBase.update(SignatureModel.nameClass, signature.toMap(), where: 'id = ?', whereArgs: [signature.id]);
  }

  Future<void> delete(SignatureModel signatureModel) async {
    await dataBase.delete(SignatureModel.nameClass, where: 'id = ?', whereArgs: [signatureModel.id]);
  }
}
