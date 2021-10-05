import 'package:flutter/material.dart';

class StatefulTodoPage extends StatefulWidget {
  @override
  _StatefulTodoState createState() => _StatefulTodoState();
}

class _StatefulTodoState extends State<StatefulTodoPage> {
  List<Map<String, dynamic>> todoList = [];

  String? taskName;

  @override
  void initState() {
    setState(() {
      Future(() async {
        todoList = await fetchTodo();
      });
    });
    super.initState();
  }

  Future<List<Map<String, dynamic>>> fetchTodo() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return [
      <String, dynamic>{'taskName': '掃除', 'complete': false},
      <String, dynamic>{'taskName': '洗濯', 'complete': false},
      <String, dynamic>{'taskName': 'サウナ', 'complete': false},
    ];
  }

  void toggleComplete(int index) {
    final dynamic complete = todoList[index]['complete'];
    if (complete is bool) {
      setState(() {
        todoList[index]['complete'] = !complete;
      });
    } else {
      return;
    }
  }

  void addTodo() {
    setState(() {
      todoList.add(<String, dynamic>{'taskName': taskName, 'complete': false});
    });
  }

  int completeCounter() {
    return todoList.where((element) => element['complete'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODO')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('達成数: ${completeCounter()}'),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(todoList[index]['taskName'].toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          toggleComplete(index);
                        },
                        icon: Icon(
                          Icons.check,
                          color: todoList[index]['complete'] == true
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
              taskName = value;
            },
          ),
          ElevatedButton(
              onPressed: () {
                addTodo();
              },
              child: const Text('追加する')),
        ],
      ),
    );
  }
}
