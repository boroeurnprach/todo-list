import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_controller.dart';
import 'package:get/get.dart';

class TodoEdit extends StatelessWidget {
  final int? index;
  TodoEdit({Key? key, required this.index}) : super(key: key);
  final todoController = Get.put(TodoController());

  void _updateTask(TodoController controller,
      TextEditingController textEditingController, BuildContext context) {
    final updatedText = textEditingController.text;
    final existingIndex = controller.todos.indexWhere(
      (todo) =>
          todo.text == updatedText && controller.todos.indexOf(todo) != index,
    );
    if (updatedText.isEmpty) {
      // Show a dialog indicating that the task is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Task is Empty'),
            content: const Text(
              'Please enter a task to continue.',
            ),
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
    } else if (existingIndex != -1) {
      // Show a dialog indicating that the item already exists
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Item Already Exists'),
            content: const Text(
              'The item already exists in the list.',
            ),
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
      // Update the item if it doesn't exist elsewhere in the list
      var editing = controller.todos[index!];
      editing.text = updatedText;
      controller.todos[index!] = editing;
      controller.update();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController =
        TextEditingController(text: todoController.todos[index!].text);

    return GetBuilder(
      init: TodoController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "What do you want to accomplish?",
                      focusedBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    maxLines: 15,
                    autofocus: true,
                    controller: textEditingController,
                    // Handle the "Enter" key press here
                    onSubmitted: (_) {
                      _updateTask(controller, textEditingController, context);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () {
                        // Handle the "Update" button press here

                        _updateTask(controller, textEditingController, context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
