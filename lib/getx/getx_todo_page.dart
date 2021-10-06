import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider_sample/getx/getx_todo_controller.dart';

class GetxTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ..init()で初期化処理を呼び出すようにしてください
    // またはController側に書いたようにコンストラクタに書いたように初期化処理が自動的に走るようにするとよいかと思います
    final GetxTodoController c = Get.put(GetxTodoController()..init());
    return Scaffold(
      appBar: AppBar(title: const Text('TODO')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() => Text('達成数: ${c.completeCounter()}')),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: c.todoList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Obx(
                            () =>
                                Text(c.todoList[index]['taskName'].toString()),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            c.toggleComplete(index);
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.check,
                              color: c.todoList[index]['complete'] == true
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              //consumerが監視している
              // こちらも.valueで代入しないとエラーになります
              c.taskName.value = value;
            },
          ),
          ElevatedButton(
              onPressed: () {
                c.addTodo();
              },
              child: const Text('追加する')),
        ],
      ),
    );
  }
}
