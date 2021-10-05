import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider_sample/getx/getx_todo_controller.dart';

class GetxTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GetxTodoController c = Get.put(GetxTodoController());
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
              c.taskName = value as RxString;
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