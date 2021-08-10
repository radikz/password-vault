import 'package:flutter/foundation.dart';
import '../model/account.dart';
import 'dbhelper_provider.dart';

class DataProvider with ChangeNotifier {
  final DBHelperProvider dbHelper;
  List<Account> _items = [];
  final tableName = 'account';

  DataProvider(this._items, this.dbHelper) {
    if (dbHelper != null) fetchAndSetData();
  }

  List<Account> get items => [..._items];

  Future<void> addAccount(String site, String username, String password) async {
    if (dbHelper.db != null) {
      // do not execute if db is not instantiate
      Account account = Account(
        site: site,
        username: username,
        password: password,
      );

      /*dbHelper.insert(tableName, {
        'site': site,
        'password': password
      });*/
      final count = await dbHelper.insert(tableName, account.toMap());
      account.id = count;
      _items.add(account);
      notifyListeners();
    }
  }

  Future<void> update(Account account) async {
    if (dbHelper.db != null) {
      final accountWhere = _items.indexWhere((acc) {
        print('acc ${acc.id}, account: ${account.id}');
        return acc.id == account.id;
      });
      print('accountWhere: $accountWhere');
      _items[accountWhere] = account;
      notifyListeners();
      print('id: ${account.id}');
      final count = await dbHelper.update(tableName, account.toMap(),
          where: 'id=?', whereArgs: [account.id]);
      print(count);
    }
  }

  Future<int> delete(int id) async {
    int count = await dbHelper.delete(tableName,
        where: 'id=?',
        whereArgs: [id]);
    return count;
  }

  Future<void> fetchAndSetData() async {
    if (dbHelper.db != null) {
      // do not execute if db is not instantiate
      final dataList = await dbHelper.getData(tableName);
      print('data ${dataList.length}');
      if (dataList.isEmpty) return;
      /*_items = dataList
          .map((item) => Account(
                id: item['id'],
                site: item['site'],
                password: item['password'],
              ),)
          .toList();*/
      _items = dataList.map((item) => Account.fromMap(item)).toList();
      notifyListeners();
    }
  }
}
