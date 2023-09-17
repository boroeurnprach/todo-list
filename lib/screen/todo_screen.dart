import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_controller.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:get/get.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({Key? key}) : super(key: key);

  static const id = '/Todo_Screen';

  final TextEditingController textEditingController = TextEditingController();

  void _addTodoItem(TodoController controller, String text) {
    final newItemText = text.trim();
    if (newItemText.isEmpty) {
      showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Require a task'),
              content: const Text('Please enter a task to continue'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          }); // Trim whitespace
    }
    if (newItemText.isNotEmpty) {
      final exists = controller.todos.any(
        (todo) => todo.text == newItemText,
      );

      if (exists) {
        // Show a dialog indicating that the item already exists
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Item Already Exists'),
              content: const Text('The item already exists in the list.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Add the item to the list
        controller.todos.add(
          Todo(
            text: newItemText,
          ),
        );
        controller.update();
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TodoController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo Item'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "What do you want to accomplish?",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  autofocus: true,
                  controller: textEditingController,
                  // Handle the "Enter" key press here
                  onSubmitted: (text) {
                    _addTodoItem(controller, text);
                    textEditingController.clear();
                  },
                ),
              ),
              SizedBox(
                width: context.width,
                child: CupertinoButton(
                  color: Colors.deepPurple,
                  child: const Text('Add'),
                  onPressed: () {
                    _addTodoItem(controller, textEditingController.text);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
