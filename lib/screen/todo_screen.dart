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
                    fontSize: 25.0,
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
                    controller.todos.add(
                      Todo(
                        text: textEditingController.text,
                      ),
                    );
                    controller.update();
                    Get.back();
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
