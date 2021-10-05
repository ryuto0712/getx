import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//グローバルに設定している（Providerでいうconsummer的な役割）グローバルに設定してるからProviderScope内で参照することができる
final RiverpodTodoModelProvider =
//ChangeNotifierProviderには何かしらの関数を返さないといけない
    ChangeNotifierProvider.autoDispose((ref) => RiverpodTodoModel());

// pedantic_monoに従って直していくとだいぶきれいになります
class RiverpodTodoModel extends ChangeNotifier {
  //動的型付
  List<Map<String, dynamic>> todoList = [];

  String? taskName;

  Future<void> init() async {
    todoList = await fetchTodo();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> fetchTodo() async {
    //5秒でreturnしますってメソッド
    await Future<void>.delayed(const Duration(seconds: 5));
    return [
      <String, dynamic>{'taskName': '掃除', 'complete': false},
      <String, dynamic>{'taskName': '洗濯', 'complete': false},
      <String, dynamic>{'taskName': 'サウナ', 'complete': false},
    ];
  }

  void toggleComplete(int index) {
    final dynamic complete = todoList[index]['complete'];
    //true or falseであれば
    if (complete is bool) {
      todoList[index]['complete'] = !complete;
    } else {
      return;
    }
    notifyListeners();
  }

  void addTodo() {
    todoList.add(<String, dynamic>{'taskName': taskName, 'complete': false});
    notifyListeners();
  }

  int completeCounter() {
    return todoList.where((element) => element['complete'] == true).length;
  }
}
