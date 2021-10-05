import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/provider/provider_todo_model.dart';

class ProviderTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderTodoModel()..init(),
      child: Consumer<ProviderTodoModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('TODO')),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('達成数: ${model.completeCounter()}'),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.todoList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                  model.todoList[index]['taskName'].toString()),
                            ),
                            IconButton(
                              onPressed: () {
                                model.toggleComplete(index);
                              },
                              icon: Icon(
                                Icons.check,
                                color: model.todoList[index]['complete'] == true
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    //consumerが監視している
                    model.taskName = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      model.addTodo();
                    },
                    child: const Text('追加する')),
              ],
            ),
          );
        },
      ),
    );
  }
}
