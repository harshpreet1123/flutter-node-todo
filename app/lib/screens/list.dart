import 'package:cpto/services/dio.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todoList = [];

  getTodos() async {
    final _todoList = await DioClient().getTodos();
    setState(() {
      todoList = _todoList;
    });
    print(todoList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ListTile(
                title: Text(
                  todo['task'],
                  style: TextStyle(
                      decoration: todo['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                leading:
                    Checkbox(value: todo['completed'], onChanged: (value) {
                      DioClient().toggleTodo(id:todo['_id']);
                      setState(() {
                        todo['completed']=value;
                      });
                    }),
                trailing: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                      ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () async{
                      await DioClient().delete(id:todo['_id']);
                      setState(() {
                         todoList.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
