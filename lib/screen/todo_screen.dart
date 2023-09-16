import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_controller.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:get/get.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({Key? key}) : super(key: key);

  static const id = '/Todo_Screen';

  final TextEditingController textEditingController = TextEditingController();

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
                ),
              ),
              SizedBox(
                width: context.width,
                child: CupertinoButton(
                  color: Colors.deepPurple,
                  child: const Text('Add'),
                  onPressed: () {
                    final newItemText =
                        textEditingController.text.trim(); // Trim whitespace
                    if (newItemText.isNotEmpty) {
                      final exists = controller.todos.any(
                        (todo) => todo.text == newItemText,
                      );

                      if (exists) {
                        // Show a dialog indicating that the item already exists
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Item Already Exists'),
                              content: const Text(
                                  'The item already exists in the list.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
