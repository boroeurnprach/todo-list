import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_controller.dart';
import 'package:get/get.dart';

class TodoEdit extends StatelessWidget {
  final int? index;
  TodoEdit({Key? key, @required this.index}) : super(key: key);
  final todoController = Get.put(TodoController());
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
                    // textAlign: TextAlign.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ignore: deprecated_member_use
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // ignore: deprecated_member_use
                    ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () {
                        var editing = controller.todos[index!];
                        editing.text = textEditingController.text;
                        controller.todos[index!] = editing;
                        controller.update();
                        Get.back();
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
