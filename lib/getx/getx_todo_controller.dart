import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// pedantic_monoに従って直していくとだいぶきれいになります
class GetxTodoController extends GetxController {
  // このようにコンストラクタに初期化処理を書いておくと
  // ..init()のように初期化を呼び出すのを忘れても大丈夫なので便利です
  GetxTodoController() {
    init();
  }

  //動的型付
  //asの後ろの型を
  var todoList = [].obs;

  var taskName = "".obs;

  Future<void> init() async {
    // .valueが本来扱いたい型になるのでそちらに代入するようにしてください
    todoList.value = await fetchTodo();
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
  }

  void addTodo() {
    todoList.add(<String, dynamic>{'taskName': taskName, 'complete': false});
  }

  int completeCounter() {
    return todoList.where((element) => element['complete'] == true).length;
  }
}
